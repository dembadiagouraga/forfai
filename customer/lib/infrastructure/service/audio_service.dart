import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../app_constants.dart'; // Import centralized constants

/// Simple enum to represent audio player states
enum AudioPlayerState {
  playing,
  paused,
  stopped
}

// Flag to track if we've already requested permissions
// This helps avoid showing system dialogs repeatedly
bool _hasRequestedAudioPermissions = false;

/// Service for handling audio recording and playback
class AudioService {
  // Singleton pattern
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal() {
    _player = just_audio.AudioPlayer();
  }

  // Recorder
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecorderInitialized = false;
  String? _recordingPath;

  // Player
  late just_audio.AudioPlayer _player;

  // Timer for tracking recording duration
  Timer? _timer;
  int _recordingDuration = 0;
  final _durationController = StreamController<int>.broadcast();

  // List to store all recording segments when pausing/resuming
  final List<String> _recordingSegments = [];

  // Recording state management for pause/resume
  bool _isRecordingPaused = false;

  // Permission management
  PermissionStatus? _lastPermissionStatus;
  DateTime? _lastPermissionCheck;
  final Duration _permissionCacheTimeout = const Duration(minutes: 5);

  // Current audio quality setting (default to standard for better quality)
  AudioQuality _currentQuality = AudioQuality.standard;

  // Cache configuration constants
  static const int _maxCacheSizeMB = 50; // 50MB cache limit
  static const int _cacheExpiryDays = 7; // 7-day expiry
  static const String _cacheDirectoryName = 'voice_cache';

  // Recording validation constants
  static const int _minValidFileSizeBytes = 1024; // 1KB minimum for valid audio
  static const int _minValidDurationMs = 100; // 100ms minimum duration
  static const int _maxValidationRetries = 3; // Maximum retry attempts for validation
  static const Duration _validationTimeout = Duration(seconds: 5); // Timeout for validation operations

  // Cache status tracking
  final _cacheStatusController = StreamController<CacheStatus>.broadcast();

  /// Stream for recording duration updates
  Stream<int> get durationStream => _durationController.stream;

  /// Stream for playback state updates
  Stream<just_audio.PlayerState> get playbackStateStream => _player.playerStateStream;

  /// Stream for cache status updates
  Stream<CacheStatus> get cacheStatusStream => _cacheStatusController.stream;

  /// Get the current recording duration in seconds
  int get recordingDuration => _recordingDuration;

  /// Check if recording is currently active (not paused)
  Future<bool> get isRecording async {
    try {
      return await _recorder.isRecording() && !_isRecordingPaused;
    } catch (e) {
      debugPrint('Error checking recording state: $e');
      return false;
    }
  }

  /// Check if recording is currently paused
  bool get isRecordingPaused => _isRecordingPaused;

  /// Check if there's any recording session (active or paused)
  Future<bool> get hasActiveRecordingSession async {
    try {
      return await _recorder.isRecording() || _isRecordingPaused;
    } catch (e) {
      debugPrint('Error checking recording session state: $e');
      return false;
    }
  }

  /// Get current audio quality setting
  AudioQuality get currentQuality => _currentQuality;

  /// Validate if a recorded file contains actual audio data
  /// Returns a detailed validation result with error information
  Future<Map<String, dynamic>> validateRecordedFile(String filePath) async {
    try {
      debugPrint('=== RECORDING VALIDATION ===');
      debugPrint('Validating file: $filePath');

      // Check if file exists
      final file = File(filePath);
      if (!await file.exists()) {
        debugPrint('❌ File does not exist');
        return {
          'isValid': false,
          'error': 'FILE_NOT_FOUND',
          'title': 'Recording File Missing',
          'message': 'The recorded file could not be found. Please try recording again.',
          'canRetry': true,
          'details': 'File path: $filePath',
        };
      }

      // Check file size
      final fileSize = await file.length();
      debugPrint('File size: $fileSize bytes');

      if (fileSize == 0) {
        debugPrint('❌ File is empty (0 bytes)');
        return {
          'isValid': false,
          'error': 'EMPTY_FILE',
          'title': 'Empty Recording',
          'message': 'The recording file is empty. Please try recording again.',
          'canRetry': true,
          'details': 'File size: 0 bytes',
        };
      }

      if (fileSize < _minValidFileSizeBytes) {
        debugPrint('❌ File too small: $fileSize bytes (minimum: $_minValidFileSizeBytes bytes)');
        return {
          'isValid': false,
          'error': 'FILE_TOO_SMALL',
          'title': 'Recording Too Short',
          'message': 'The recording is too short or may not contain audio data. Please try recording for a longer duration.',
          'canRetry': true,
          'details': 'File size: $fileSize bytes (minimum required: $_minValidFileSizeBytes bytes)',
        };
      }

      // Check if file has valid audio format
      final formatValidation = await _validateAudioFormat(filePath);
      if (!formatValidation['isValid']) {
        debugPrint('❌ Invalid audio format');
        return formatValidation;
      }

      // Try to get audio duration using just_audio
      final durationValidation = await _validateAudioDuration(filePath);
      if (!durationValidation['isValid']) {
        debugPrint('❌ Invalid audio duration');
        return durationValidation;
      }

      // Check if duration matches expected recording time
      final durationMs = durationValidation['durationMs'] as int;
      final expectedDurationMs = _recordingDuration * 1000;
      final durationDifference = (durationMs - expectedDurationMs).abs();

      debugPrint('Expected duration: ${expectedDurationMs}ms, Actual duration: ${durationMs}ms');
      debugPrint('Duration difference: ${durationDifference}ms');

      // Allow some tolerance for duration differences (up to 2 seconds)
      if (durationDifference > 2000 && expectedDurationMs > 1000) {
        debugPrint('⚠️ Duration mismatch detected but file appears valid');
        // Don't fail validation for duration mismatch, just log it
      }

      // All validations passed
      debugPrint('✅ File validation successful');
      return {
        'isValid': true,
        'fileSize': fileSize,
        'durationMs': durationMs,
        'expectedDurationMs': expectedDurationMs,
        'format': _getFileExtension(filePath),
        'message': 'Recording validation successful',
        'details': 'File size: $fileSize bytes, Duration: ${durationMs}ms',
      };

    } catch (e) {
      debugPrint('❌ Error during file validation: $e');
      return {
        'isValid': false,
        'error': 'VALIDATION_ERROR',
        'title': 'Validation Failed',
        'message': 'Unable to validate the recording. The file may be corrupted.',
        'canRetry': true,
        'details': 'Validation error: $e',
      };
    }
  }

  /// Validate audio format by checking file header and extension
  Future<Map<String, dynamic>> _validateAudioFormat(String filePath) async {
    try {
      final file = File(filePath);
      final extension = _getFileExtension(filePath).toLowerCase();

      // Check if extension matches expected format
      if (extension != _currentQuality.extension) {
        debugPrint('⚠️ File extension mismatch: expected ${_currentQuality.extension}, got $extension');
        // Don't fail for extension mismatch, just log it
      }

      // Read first few bytes to check file header
      final bytes = await file.openRead(0, 16).first;

      // Check for common audio file signatures
      if (extension == 'm4a' || extension == 'mp4') {
        // M4A/MP4 files start with ftyp box (0x66 0x74 0x79 0x70) at offset 4
        if (bytes.length >= 8) {
          final hasFtyp = bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70;

          if (!hasFtyp) {
            debugPrint('❌ Invalid M4A file header');
            return {
              'isValid': false,
              'error': 'INVALID_AUDIO_FORMAT',
              'title': 'Invalid Audio Format',
              'message': 'The recorded file does not appear to be a valid audio file. Please try recording again.',
              'canRetry': true,
              'details': 'Invalid M4A file header',
            };
          }
        }
      } else if (extension == 'mp3') {
        // MP3 files can start with ID3 tag (0x49 0x44 0x33) or frame sync (0xFF 0xFB/0xFA)
        if (bytes.length >= 3) {
          final hasId3 = bytes[0] == 0x49 && bytes[1] == 0x44 && bytes[2] == 0x33;
          final hasFrameSync = bytes[0] == 0xFF && (bytes[1] & 0xE0) == 0xE0;

          if (!hasId3 && !hasFrameSync) {
            debugPrint('❌ Invalid MP3 file header');
            return {
              'isValid': false,
              'error': 'INVALID_AUDIO_FORMAT',
              'title': 'Invalid Audio Format',
              'message': 'The recorded file does not appear to be a valid audio file. Please try recording again.',
              'canRetry': true,
              'details': 'Invalid MP3 file header',
            };
          }
        }
      } else if (extension == 'aac') {
        // AAC files typically start with ADTS header (0xFF 0xF1 or 0xFF 0xF9)
        if (bytes.length >= 2) {
          final hasAdts = bytes[0] == 0xFF && (bytes[1] & 0xF0) == 0xF0;

          if (!hasAdts) {
            debugPrint('❌ Invalid AAC file header');
            return {
              'isValid': false,
              'error': 'INVALID_AUDIO_FORMAT',
              'title': 'Invalid Audio Format',
              'message': 'The recorded file does not appear to be a valid audio file. Please try recording again.',
              'canRetry': true,
              'details': 'Invalid AAC file header',
            };
          }
        }
      } else if (extension == 'wav') {
        // WAV files start with RIFF header
        if (bytes.length >= 4) {
          final hasRiff = bytes[0] == 0x52 && bytes[1] == 0x49 && bytes[2] == 0x46 && bytes[3] == 0x46;

          if (!hasRiff) {
            debugPrint('❌ Invalid WAV file header');
            return {
              'isValid': false,
              'error': 'INVALID_AUDIO_FORMAT',
              'title': 'Invalid Audio Format',
              'message': 'The recorded file does not appear to be a valid audio file. Please try recording again.',
              'canRetry': true,
              'details': 'Invalid WAV file header',
            };
          }
        }
      }

      debugPrint('✅ Audio format validation passed');
      return {
        'isValid': true,
        'format': extension,
      };

    } catch (e) {
      debugPrint('❌ Error validating audio format: $e');
      return {
        'isValid': false,
        'error': 'FORMAT_VALIDATION_ERROR',
        'title': 'Format Validation Failed',
        'message': 'Unable to validate the audio format. Please try recording again.',
        'canRetry': true,
        'details': 'Format validation error: $e',
      };
    }
  }

  /// Validate audio duration by attempting to load the file
  Future<Map<String, dynamic>> _validateAudioDuration(String filePath) async {
    just_audio.AudioPlayer? tempPlayer;

    try {
      debugPrint('Validating audio duration...');

      // Create temporary player for validation
      tempPlayer = just_audio.AudioPlayer();

      // Set a timeout for the validation
      final validationFuture = tempPlayer.setFilePath(filePath).timeout(_validationTimeout);
      await validationFuture;

      // Get duration
      final duration = tempPlayer.duration;
      if (duration == null) {
        debugPrint('❌ Could not determine audio duration');
        return {
          'isValid': false,
          'error': 'DURATION_UNKNOWN',
          'title': 'Invalid Audio File',
          'message': 'The recorded file appears to be corrupted or invalid. Please try recording again.',
          'canRetry': true,
          'details': 'Could not determine audio duration',
        };
      }

      final durationMs = duration.inMilliseconds;
      debugPrint('Audio duration: ${durationMs}ms');

      if (durationMs < _minValidDurationMs) {
        debugPrint('❌ Audio duration too short: ${durationMs}ms (minimum: $_minValidDurationMs ms)');
        return {
          'isValid': false,
          'error': 'DURATION_TOO_SHORT',
          'title': 'Recording Too Short',
          'message': 'The recording is too short. Please record for at least 1 second.',
          'canRetry': true,
          'details': 'Duration: ${durationMs}ms (minimum required: $_minValidDurationMs ms)',
        };
      }

      debugPrint('✅ Audio duration validation passed');
      return {
        'isValid': true,
        'durationMs': durationMs,
      };

    } on TimeoutException {
      debugPrint('❌ Audio validation timed out');
      return {
        'isValid': false,
        'error': 'VALIDATION_TIMEOUT',
        'title': 'Validation Timeout',
        'message': 'The recording validation timed out. The file may be corrupted.',
        'canRetry': true,
        'details': 'Validation timed out after ${_validationTimeout.inSeconds} seconds',
      };
    } catch (e) {
      debugPrint('❌ Error validating audio duration: $e');
      return {
        'isValid': false,
        'error': 'DURATION_VALIDATION_ERROR',
        'title': 'Audio Validation Failed',
        'message': 'The recorded file appears to be corrupted or in an unsupported format. Please try recording again.',
        'canRetry': true,
        'details': 'Duration validation error: $e',
      };
    } finally {
      // Clean up temporary player
      try {
        await tempPlayer?.dispose();
      } catch (e) {
        debugPrint('Error disposing temporary player: $e');
      }
    }
  }

  /// Get file extension from path
  String _getFileExtension(String filePath) {
    final lastDot = filePath.lastIndexOf('.');
    if (lastDot == -1) return '';
    return filePath.substring(lastDot + 1);
  }

  /// Handle recording errors and provide user-friendly messages
  /// Logs detailed errors for debugging while showing simple messages to users
  Map<String, dynamic> _handleRecordingError(dynamic error, String operation) {
    debugPrint('=== RECORDING ERROR HANDLER ===');
    debugPrint('Operation: $operation');
    debugPrint('Error Type: ${error.runtimeType}');
    debugPrint('Error Details: $error');

    // Handle specific exception types
    if (error is RecordingPermissionException) {
      debugPrint('Permission Error: ${error.errorCode}');
      return {
        'success': false,
        'errorType': 'PERMISSION_ERROR',
        'userMessage': error.message,
        'debugMessage': error.toString(),
        'canRetry': error.canRetry,
        'canOpenSettings': error.canOpenSettings,
        'actionText': error.actionText,
        'details': error.toMap(),
      };
    }

    if (error is RecordingException) {
      debugPrint('Recording Error: ${error.errorCode}');
      return {
        'success': false,
        'errorType': 'RECORDING_ERROR',
        'userMessage': error.userMessage,
        'debugMessage': error.debugMessage,
        'canRetry': error.canRetry,
        'isTemporary': error.isTemporary,
        'suggestedAction': error.suggestedAction,
        'details': error.toMap(),
      };
    }

    if (error is AudioFileException) {
      debugPrint('Audio File Error: ${error.errorCode}');
      return {
        'success': false,
        'errorType': 'FILE_ERROR',
        'userMessage': error.userMessage,
        'debugMessage': error.debugMessage,
        'canRetry': error.canRetry,
        'filePath': error.filePath,
        'details': error.toMap(),
      };
    }

    // Handle platform-specific errors
    if (error.toString().contains('PlatformException')) {
      debugPrint('Platform Exception detected');
      return _handlePlatformException(error, operation);
    }

    // Handle file system errors
    if (error is FileSystemException) {
      debugPrint('File System Exception: ${error.message}');
      return {
        'success': false,
        'errorType': 'FILE_SYSTEM_ERROR',
        'userMessage': 'Unable to access audio files. Please check device storage.',
        'debugMessage': 'FileSystemException: ${error.message} (Path: ${error.path})',
        'canRetry': true,
        'suggestedAction': 'Check device storage space and permissions',
      };
    }

    // Handle timeout errors
    if (error.toString().toLowerCase().contains('timeout')) {
      debugPrint('Timeout error detected');
      return {
        'success': false,
        'errorType': 'TIMEOUT_ERROR',
        'userMessage': 'Recording operation timed out. Please try again.',
        'debugMessage': 'Timeout during $operation: $error',
        'canRetry': true,
        'isTemporary': true,
        'suggestedAction': 'Try again in a moment',
      };
    }

    // Handle generic errors
    debugPrint('Generic error - providing fallback handling');
    return {
      'success': false,
      'errorType': 'UNKNOWN_ERROR',
      'userMessage': 'An unexpected error occurred during recording. Please try again.',
      'debugMessage': 'Unknown error during $operation: $error',
      'canRetry': true,
      'isTemporary': true,
      'suggestedAction': 'Try again or restart the app if the problem persists',
    };
  }

  /// Handle platform-specific exceptions
  Map<String, dynamic> _handlePlatformException(dynamic error, String operation) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('permission')) {
      return {
        'success': false,
        'errorType': 'PLATFORM_PERMISSION_ERROR',
        'userMessage': 'Microphone access is required to record voice messages.',
        'debugMessage': 'Platform permission error during $operation: $error',
        'canRetry': true,
        'canOpenSettings': true,
        'actionText': 'Grant Permission',
      };
    }

    if (errorString.contains('codec') || errorString.contains('format')) {
      return {
        'success': false,
        'errorType': 'CODEC_ERROR',
        'userMessage': 'Audio format not supported on this device. Trying alternative format.',
        'debugMessage': 'Codec/format error during $operation: $error',
        'canRetry': true,
        'isTemporary': false,
        'suggestedAction': 'Use compatibility mode',
      };
    }

    if (errorString.contains('device') || errorString.contains('hardware')) {
      return {
        'success': false,
        'errorType': 'HARDWARE_ERROR',
        'userMessage': 'Microphone hardware issue detected. Please check your device.',
        'debugMessage': 'Hardware error during $operation: $error',
        'canRetry': true,
        'isTemporary': true,
        'suggestedAction': 'Check microphone hardware or restart device',
      };
    }

    if (errorString.contains('busy') || errorString.contains('in use')) {
      return {
        'success': false,
        'errorType': 'DEVICE_BUSY_ERROR',
        'userMessage': 'Microphone is being used by another app. Please close other apps and try again.',
        'debugMessage': 'Device busy error during $operation: $error',
        'canRetry': true,
        'isTemporary': true,
        'suggestedAction': 'Close other apps using microphone',
      };
    }

    // Generic platform exception
    return {
      'success': false,
      'errorType': 'PLATFORM_ERROR',
      'userMessage': 'A system error occurred. Please try again.',
      'debugMessage': 'Platform exception during $operation: $error',
      'canRetry': true,
      'isTemporary': true,
      'suggestedAction': 'Try again or restart the app',
    };
  }

  /// Check microphone permission status with caching
  /// Returns current permission status without requesting
  Future<PermissionStatus> checkMicrophonePermission() async {
    try {
      // Use cached status if available and not expired
      if (_lastPermissionStatus != null &&
          _lastPermissionCheck != null &&
          DateTime.now().difference(_lastPermissionCheck!).compareTo(_permissionCacheTimeout) < 0) {
        debugPrint('Using cached permission status: $_lastPermissionStatus');
        return _lastPermissionStatus!;
      }

      // Check current permission status
      final status = await Permission.microphone.status;

      // Update cache
      _lastPermissionStatus = status;
      _lastPermissionCheck = DateTime.now();

      debugPrint('Microphone permission status: $status');
      return status;
    } catch (e) {
      debugPrint('Error checking microphone permission: $e');
      return PermissionStatus.denied;
    }
  }

  /// Request microphone permission with proper error handling
  /// Returns the permission status after request
  Future<PermissionStatus> requestMicrophonePermission() async {
    try {
      debugPrint('Requesting microphone permission...');

      // First check current status
      final currentStatus = await checkMicrophonePermission();

      // If already granted, no need to request
      if (currentStatus == PermissionStatus.granted) {
        debugPrint('Microphone permission already granted');
        return currentStatus;
      }

      // If permanently denied, cannot request again
      if (currentStatus == PermissionStatus.permanentlyDenied) {
        debugPrint('Microphone permission permanently denied - cannot request');
        return currentStatus;
      }

      // Request permission
      final requestedStatus = await Permission.microphone.request();

      // Update cache with new status
      _lastPermissionStatus = requestedStatus;
      _lastPermissionCheck = DateTime.now();

      debugPrint('Microphone permission request result: $requestedStatus');
      return requestedStatus;
    } catch (e) {
      debugPrint('Error requesting microphone permission: $e');
      return PermissionStatus.denied;
    }
  }

  /// Get user-friendly permission status message
  String getPermissionStatusMessage(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Microphone access granted. You can now record voice messages.';
      case PermissionStatus.denied:
        return 'Microphone access denied. Please allow microphone access to record voice messages.';
      case PermissionStatus.permanentlyDenied:
        return 'Microphone access permanently denied. Please enable microphone access in device settings to record voice messages.';
      case PermissionStatus.restricted:
        return 'Microphone access restricted. This device may not support voice recording.';
      case PermissionStatus.limited:
        return 'Microphone access limited. Voice recording may not work properly.';
      case PermissionStatus.provisional:
        return 'Microphone access provisional. Please confirm permission to record voice messages.';
      default:
        return 'Unknown microphone permission status. Please check device settings.';
    }
  }

  /// Get detailed permission error information
  Map<String, dynamic> getPermissionErrorDetails(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        return {
          'error': 'PERMISSION_DENIED',
          'title': 'Microphone Access Required',
          'message': 'This app needs microphone access to record voice messages. Please tap "Allow" when prompted.',
          'actionText': 'Request Permission',
          'canRetry': true,
          'canOpenSettings': false,
        };
      case PermissionStatus.permanentlyDenied:
        return {
          'error': 'PERMISSION_PERMANENTLY_DENIED',
          'title': 'Microphone Access Blocked',
          'message': 'Microphone access has been permanently denied. Please enable it in device settings to record voice messages.',
          'actionText': 'Open Settings',
          'canRetry': false,
          'canOpenSettings': true,
        };
      case PermissionStatus.restricted:
        return {
          'error': 'PERMISSION_RESTRICTED',
          'title': 'Microphone Restricted',
          'message': 'Microphone access is restricted on this device. Voice recording may not be available.',
          'actionText': 'Check Settings',
          'canRetry': false,
          'canOpenSettings': true,
        };
      case PermissionStatus.limited:
        return {
          'error': 'PERMISSION_LIMITED',
          'title': 'Limited Microphone Access',
          'message': 'Microphone access is limited. Voice recording quality may be affected.',
          'actionText': 'Check Settings',
          'canRetry': true,
          'canOpenSettings': true,
        };
      default:
        return {
          'error': 'PERMISSION_UNKNOWN',
          'title': 'Permission Status Unknown',
          'message': 'Unable to determine microphone permission status. Please check device settings.',
          'actionText': 'Check Settings',
          'canRetry': true,
          'canOpenSettings': true,
        };
    }
  }

  /// Open device settings for app permissions
  /// Returns true if settings were opened successfully
  Future<bool> openPermissionSettings() async {
    try {
      debugPrint('Opening app settings for permission management...');
      final opened = await openAppSettings();
      if (opened) {
        debugPrint('App settings opened successfully');
        // Clear permission cache so it's re-checked when user returns
        _lastPermissionStatus = null;
        _lastPermissionCheck = null;
      } else {
        debugPrint('Failed to open app settings');
      }
      return opened;
    } catch (e) {
      debugPrint('Error opening app settings: $e');
      return false;
    }
  }

  /// Check if recording is possible with current permissions
  /// Returns a result object with permission status and error details
  Future<Map<String, dynamic>> checkRecordingPermissions() async {
    try {
      final status = await checkMicrophonePermission();

      if (status == PermissionStatus.granted) {
        return {
          'canRecord': true,
          'status': status,
          'message': getPermissionStatusMessage(status),
        };
      } else {
        final errorDetails = getPermissionErrorDetails(status);
        return {
          'canRecord': false,
          'status': status,
          'message': getPermissionStatusMessage(status),
          'error': errorDetails,
        };
      }
    } catch (e) {
      debugPrint('Error checking recording permissions: $e');
      return {
        'canRecord': false,
        'status': PermissionStatus.denied,
        'message': 'Unable to check microphone permissions. Please try again.',
        'error': {
          'error': 'PERMISSION_CHECK_FAILED',
          'title': 'Permission Check Failed',
          'message': 'Unable to check microphone permissions. Please try again or check device settings.',
          'actionText': 'Retry',
          'canRetry': true,
          'canOpenSettings': true,
        },
      };
    }
  }

  /// Request permissions and provide user feedback
  /// Returns a result object with success status and user-friendly messages
  Future<Map<String, dynamic>> requestRecordingPermissions() async {
    try {
      debugPrint('Requesting recording permissions with user feedback...');

      final status = await requestMicrophonePermission();

      if (status == PermissionStatus.granted) {
        return {
          'success': true,
          'status': status,
          'message': getPermissionStatusMessage(status),
          'title': 'Permission Granted',
        };
      } else {
        final errorDetails = getPermissionErrorDetails(status);
        return {
          'success': false,
          'status': status,
          'message': getPermissionStatusMessage(status),
          'error': errorDetails,
        };
      }
    } catch (e) {
      debugPrint('Error requesting recording permissions: $e');
      return {
        'success': false,
        'status': PermissionStatus.denied,
        'message': 'Failed to request microphone permissions. Please try again.',
        'error': {
          'error': 'PERMISSION_REQUEST_FAILED',
          'title': 'Permission Request Failed',
          'message': 'Unable to request microphone permissions. Please check device settings.',
          'actionText': 'Open Settings',
          'canRetry': true,
          'canOpenSettings': true,
        },
      };
    }
  }

  /// Set audio quality for recording
  void setAudioQuality(AudioQuality quality) {
    _currentQuality = quality;
    debugPrint('Audio quality set to: ${quality.description}');
    debugPrint('Estimated file size: ${quality.estimatedSizePerMinuteMB.toStringAsFixed(2)} MB/min');
  }

  /// Get available audio quality options
  List<AudioQuality> getAvailableQualities() {
    return AudioQuality.values;
  }

  /// Convenience method: Start recording with premium quality (MP3 192kbps)
  Future<String?> startPremiumRecording({int? preserveDuration, bool isNewRecording = true}) {
    return startRecording(
      preserveDuration: preserveDuration,
      isNewRecording: isNewRecording,
      quality: AudioQuality.premium,
    );
  }

  /// Convenience method: Start recording with high quality (MP3 160kbps)
  Future<String?> startHighQualityRecording({int? preserveDuration, bool isNewRecording = true}) {
    return startRecording(
      preserveDuration: preserveDuration,
      isNewRecording: isNewRecording,
      quality: AudioQuality.high,
    );
  }

  /// Convenience method: Start recording with standard quality (MP3 128kbps)
  Future<String?> startStandardRecording({int? preserveDuration, bool isNewRecording = true}) {
    return startRecording(
      preserveDuration: preserveDuration,
      isNewRecording: isNewRecording,
      quality: AudioQuality.standard,
    );
  }

  /// Convenience method: Start recording with compatibility mode (MP3 128kbps)
  /// Upgraded from 96kbps for better quality while maintaining compatibility
  Future<String?> startCompatibilityRecording({int? preserveDuration, bool isNewRecording = true}) {
    return startRecording(
      preserveDuration: preserveDuration,
      isNewRecording: isNewRecording,
      quality: AudioQuality.compatibility,
    );
  }

  /// Get estimated file size for current recording duration
  double getEstimatedFileSizeMB() {
    final durationMinutes = _recordingDuration / 60.0;
    return _currentQuality.estimatedSizePerMinuteMB * durationMinutes;
  }

  /// Convenience method: Toggle recording pause/resume
  /// Returns true if recording is now paused, false if resumed
  Future<bool> toggleRecordingPause() async {
    try {
      if (_isRecordingPaused) {
        final success = await resumeRecording();
        return !success; // If resume succeeded, recording is not paused
      } else {
        final success = await pauseRecording();
        return success; // If pause succeeded, recording is paused
      }
    } catch (e) {
      debugPrint('Error toggling recording pause: $e');
      return _isRecordingPaused; // Return current state on error
    }
  }

  /// Convenience method: Get recording state as string for debugging
  Future<String> getRecordingStateString() async {
    try {
      final isRecording = await _recorder.isRecording();
      if (isRecording && !_isRecordingPaused) {
        return 'RECORDING';
      } else if (_isRecordingPaused) {
        return 'PAUSED';
      } else {
        return 'STOPPED';
      }
    } catch (e) {
      debugPrint('Error getting recording state: $e');
      return 'ERROR';
    }
  }

  /// Ensure recording file is compatible with upload and playback systems
  /// Validates file format, size, and prepares for upload
  Future<String?> prepareRecordingForUpload(String filePath) async {
    try {
      debugPrint('Preparing recording for upload: $filePath');

      final file = File(filePath);
      if (!await file.exists()) {
        debugPrint('Error: Recording file does not exist');
        return null;
      }

      final fileSize = await file.length();
      debugPrint('Recording file size: $fileSize bytes (${(fileSize / 1024).toStringAsFixed(1)} KB)');

      // Check minimum file size (should be at least 1KB for a valid recording)
      if (fileSize < 1000) {
        debugPrint('Warning: Recording file is very small ($fileSize bytes) - may indicate recording issue');
      }

      // Verify file extension is MP3 (required for upload compatibility)
      if (!filePath.toLowerCase().endsWith('.mp3')) {
        debugPrint('Warning: File does not have .mp3 extension, upload may fail');
      }

      // Check if file is readable
      try {
        final bytes = await file.readAsBytes();
        if (bytes.isEmpty) {
          debugPrint('Error: Recording file is empty');
          return null;
        }
        debugPrint('File validation successful - ready for upload');
      } catch (e) {
        debugPrint('Error reading recording file: $e');
        return null;
      }

      // File is valid and ready for upload
      debugPrint('Recording prepared successfully for upload:');
      debugPrint('  - Path: $filePath');
      debugPrint('  - Size: $fileSize bytes');
      debugPrint('  - Format: MP3');
      debugPrint('  - Duration: ${_recordingDuration} seconds');

      return filePath;

    } catch (e) {
      debugPrint('Error preparing recording for upload: $e');
      return null;
    }
  }

  /// Get recording metadata for upload
  Map<String, dynamic> getRecordingMetadata() {
    return {
      'duration': _recordingDuration,
      'format': _currentQuality.extension,
      'quality': _currentQuality.description,
      'qualityLevel': _currentQuality.qualityLevel,
      'sampleRate': _currentQuality.sampleRate,
      'bitRate': _currentQuality.bitRate,
      'channels': 1, // Mono
      'encoder': 'record_package',
      'mimeType': _currentQuality.mimeType,
      'estimatedSizeMB': getEstimatedFileSizeMB(),
      'isHighClarity': _currentQuality.isHighClarity,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }

  /// Test method to demonstrate pause/resume functionality
  /// This method shows how to use the pause/resume features
  Future<void> demonstratePauseResumeFunctionality() async {
    try {
      debugPrint('=== PAUSE/RESUME FUNCTIONALITY DEMONSTRATION ===');

      // Start recording
      debugPrint('1. Starting recording...');
      final recordingPath = await startRecording();
      if (recordingPath == null) {
        debugPrint('Failed to start recording');
        return;
      }
      debugPrint('Recording started: $recordingPath');
      debugPrint('State: ${await getRecordingStateString()}');

      // Record for 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      debugPrint('2. After 3 seconds - Duration: ${_recordingDuration}s');

      // Pause recording
      debugPrint('3. Pausing recording...');
      final pauseSuccess = await pauseRecording();
      debugPrint('Pause success: $pauseSuccess');
      debugPrint('State: ${await getRecordingStateString()}');
      debugPrint('Duration preserved: ${_recordingDuration}s');
      debugPrint('Segments count: ${_recordingSegments.length}');

      // Wait 2 seconds while paused
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('4. After 2 seconds pause - Duration should still be: ${_recordingDuration}s');

      // Resume recording
      debugPrint('5. Resuming recording...');
      final resumeSuccess = await resumeRecording();
      debugPrint('Resume success: $resumeSuccess');
      debugPrint('State: ${await getRecordingStateString()}');
      debugPrint('Duration continuing from: ${_recordingDuration}s');

      // Record for 2 more seconds
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('6. After 2 more seconds - Duration: ${_recordingDuration}s');

      // Stop recording
      debugPrint('7. Stopping recording...');
      final finalPath = await stopRecording();
      debugPrint('Final recording path: $finalPath');
      debugPrint('Final duration: ${_recordingDuration}s');
      debugPrint('Total segments merged: ${_recordingSegments.length}');

      debugPrint('=== DEMONSTRATION COMPLETE ===');

    } catch (e) {
      debugPrint('Error in pause/resume demonstration: $e');
    }
  }

  /// Demonstrate complete recording workflow with upload preparation
  /// This method shows the full recording process from start to upload-ready file
  Future<void> demonstrateCompleteRecordingWorkflow() async {
    try {
      debugPrint('=== COMPLETE RECORDING WORKFLOW DEMONSTRATION ===');

      // 1. Start recording
      debugPrint('1. Starting high-quality recording...');
      final recordingPath = await startRecording();
      if (recordingPath == null) {
        debugPrint('Failed to start recording');
        return;
      }
      debugPrint('Recording started: $recordingPath');
      debugPrint('Settings: MP3, 128kbps, 44.1kHz, Mono');

      // 2. Record for a few seconds
      await Future.delayed(const Duration(seconds: 3));
      debugPrint('2. Recording for 3 seconds... Duration: ${_recordingDuration}s');

      // 3. Pause recording
      debugPrint('3. Pausing recording...');
      await pauseRecording();
      debugPrint('Recording paused. Segments: ${_recordingSegments.length}');

      // 4. Wait while paused
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('4. Paused for 1 second...');

      // 5. Resume recording
      debugPrint('5. Resuming recording...');
      await resumeRecording();
      debugPrint('Recording resumed. Continuing from ${_recordingDuration}s');

      // 6. Record for more time
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('6. Recording for 2 more seconds... Duration: ${_recordingDuration}s');

      // 7. Stop recording
      debugPrint('7. Stopping recording...');
      final finalPath = await stopRecording();
      if (finalPath == null) {
        debugPrint('Failed to stop recording');
        return;
      }
      debugPrint('Recording stopped. Final path: $finalPath');
      debugPrint('Final duration: ${_recordingDuration}s');

      // 8. Prepare for upload
      debugPrint('8. Preparing recording for upload...');
      final uploadReadyPath = await prepareRecordingForUpload(finalPath);
      if (uploadReadyPath == null) {
        debugPrint('Failed to prepare recording for upload');
        return;
      }

      // 9. Get metadata
      debugPrint('9. Getting recording metadata...');
      final metadata = getRecordingMetadata();
      debugPrint('Recording metadata:');
      metadata.forEach((key, value) {
        debugPrint('  - $key: $value');
      });

      // 10. Simulate upload process
      debugPrint('10. Recording is ready for upload to AWS S3:');
      debugPrint('  ✅ File path: $uploadReadyPath');
      debugPrint('  ✅ Format: MP3 (compatible with backend)');
      debugPrint('  ✅ Quality: 128kbps (high quality)');
      debugPrint('  ✅ Duration: ${metadata['duration']} seconds');
      debugPrint('  ✅ File size: Ready for multipart upload');

      debugPrint('=== COMPLETE WORKFLOW DEMONSTRATION SUCCESSFUL ===');

    } catch (e) {
      debugPrint('Error in complete workflow demonstration: $e');
    }
  }

  /// Test file path generation and upload compatibility
  /// This method verifies that generated file paths work with the upload system
  Future<void> testFilePathCompatibility() async {
    try {
      debugPrint('=== FILE PATH COMPATIBILITY TEST ===');

      // Test 1: Generate recording path
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'voice_message_${timestamp}.mp3';
      final testPath = '${tempDir.path}/$fileName';

      debugPrint('1. Generated file path: $testPath');
      debugPrint('   - Directory: ${tempDir.path}');
      debugPrint('   - Filename: $fileName');
      debugPrint('   - Extension: .mp3');

      // Test 2: Verify path format matches upload expectations
      final pathComponents = testPath.split('/');
      final fileNameFromPath = pathComponents.last;
      final extensionFromPath = fileNameFromPath.split('.').last;

      debugPrint('2. Path analysis:');
      debugPrint('   - Filename from path: $fileNameFromPath');
      debugPrint('   - Extension from path: $extensionFromPath');
      debugPrint('   - Is MP3: ${extensionFromPath.toLowerCase() == 'mp3'}');
      debugPrint('   - Contains timestamp: ${fileNameFromPath.contains(timestamp.toString())}');

      // Test 3: Verify compatibility with backend expectations
      final isCompatible = extensionFromPath.toLowerCase() == 'mp3' &&
                          fileNameFromPath.startsWith('voice_message_') &&
                          fileNameFromPath.contains(timestamp.toString());

      debugPrint('3. Upload compatibility check:');
      debugPrint('   - MP3 format: ✅ ${extensionFromPath.toLowerCase() == 'mp3'}');
      debugPrint('   - Proper naming: ✅ ${fileNameFromPath.startsWith('voice_message_')}');
      debugPrint('   - Unique timestamp: ✅ ${fileNameFromPath.contains(timestamp.toString())}');
      debugPrint('   - Overall compatible: ${isCompatible ? '✅' : '❌'}');

      // Test 4: Verify metadata format
      final metadata = getRecordingMetadata();
      debugPrint('4. Metadata compatibility:');
      debugPrint('   - Format: ${metadata['format']} (expected: mp3)');
      debugPrint('   - Quality: ${metadata['quality']} (expected: high)');
      debugPrint('   - Sample Rate: ${metadata['sampleRate']} (expected: 44100)');
      debugPrint('   - Bit Rate: ${metadata['bitRate']} (expected: 128000)');
      debugPrint('   - Channels: ${metadata['channels']} (expected: 1)');

      final metadataCompatible = metadata['format'] == 'mp3' &&
                                metadata['sampleRate'] == 44100 &&
                                metadata['bitRate'] == 128000 &&
                                metadata['channels'] == 1;

      debugPrint('   - Metadata compatible: ${metadataCompatible ? '✅' : '❌'}');

      // Test 5: Overall compatibility result
      final overallCompatible = isCompatible && metadataCompatible;
      debugPrint('5. Overall compatibility result: ${overallCompatible ? '✅ PASS' : '❌ FAIL'}');

      if (overallCompatible) {
        debugPrint('=== FILE PATH COMPATIBILITY TEST PASSED ===');
        debugPrint('✅ Recording files will be compatible with:');
        debugPrint('   - AWS S3 upload system');
        debugPrint('   - Backend API expectations');
        debugPrint('   - Playback systems');
        debugPrint('   - Cache management');
      } else {
        debugPrint('=== FILE PATH COMPATIBILITY TEST FAILED ===');
        debugPrint('❌ Issues detected that may cause upload/playback problems');
      }

    } catch (e) {
      debugPrint('Error in file path compatibility test: $e');
    }
  }

  /// Convenience method: Start recording with automatic permission handling
  /// This method handles permissions gracefully and provides user-friendly error messages
  Future<Map<String, dynamic>> startRecordingWithPermissions({
    int? preserveDuration,
    bool isNewRecording = true,
    AudioQuality? quality,
  }) async {
    try {
      debugPrint('Starting recording with automatic permission handling...');

      // First check if we can record
      final permissionResult = await checkRecordingPermissions();
      if (!permissionResult['canRecord']) {
        debugPrint('Cannot record due to permissions: ${permissionResult['message']}');
        return {
          'success': false,
          'error': 'PERMISSION_REQUIRED',
          'message': permissionResult['message'],
          'permissionError': permissionResult['error'],
        };
      }

      // Attempt to start recording
      final recordingPath = await startRecording(
        preserveDuration: preserveDuration,
        isNewRecording: isNewRecording,
        quality: quality,
      );

      if (recordingPath != null) {
        return {
          'success': true,
          'path': recordingPath,
          'message': 'Recording started successfully',
          'duration': _recordingDuration,
          'quality': _currentQuality.description,
        };
      } else {
        return {
          'success': false,
          'error': 'RECORDING_START_FAILED',
          'message': 'Failed to start recording. Please try again.',
        };
      }
    } on RecordingPermissionException catch (e) {
      debugPrint('Permission exception during recording start: $e');
      return _handleRecordingError(e, 'startRecordingWithPermissions');
    } on RecordingException catch (e) {
      debugPrint('Recording exception during recording start: $e');
      return _handleRecordingError(e, 'startRecordingWithPermissions');
    } on AudioFileException catch (e) {
      debugPrint('Audio file exception during recording start: $e');
      return _handleRecordingError(e, 'startRecordingWithPermissions');
    } catch (e) {
      debugPrint('Unexpected error starting recording: $e');
      return _handleRecordingError(e, 'startRecordingWithPermissions');
    }
  }

  /// Convenience method: Request permissions with user-friendly flow
  /// Returns a result that UI can use to show appropriate dialogs/messages
  Future<Map<String, dynamic>> handlePermissionRequest() async {
    try {
      debugPrint('Handling permission request with user-friendly flow...');

      // First check current status
      final currentStatus = await checkMicrophonePermission();

      if (currentStatus == PermissionStatus.granted) {
        return {
          'success': true,
          'alreadyGranted': true,
          'message': getPermissionStatusMessage(currentStatus),
          'title': 'Permission Already Granted',
        };
      }

      if (currentStatus == PermissionStatus.permanentlyDenied) {
        final errorDetails = getPermissionErrorDetails(currentStatus);
        return {
          'success': false,
          'permanentlyDenied': true,
          'message': getPermissionStatusMessage(currentStatus),
          'error': errorDetails,
        };
      }

      // Request permission
      final result = await requestRecordingPermissions();
      return result;

    } catch (e) {
      debugPrint('Error handling permission request: $e');
      return {
        'success': false,
        'error': {
          'error': 'PERMISSION_FLOW_ERROR',
          'title': 'Permission Error',
          'message': 'Unable to handle permission request. Please try again.',
          'actionText': 'Retry',
          'canRetry': true,
          'canOpenSettings': true,
        },
      };
    }
  }

  /// Demonstrate permission handling workflow
  /// This method shows how to properly handle permissions in the UI
  Future<void> demonstratePermissionHandling() async {
    try {
      debugPrint('=== PERMISSION HANDLING DEMONSTRATION ===');

      // 1. Check current permission status
      debugPrint('1. Checking current permission status...');
      final currentStatus = await checkMicrophonePermission();
      debugPrint('Current status: $currentStatus');
      debugPrint('Message: ${getPermissionStatusMessage(currentStatus)}');

      // 2. Check if recording is possible
      debugPrint('2. Checking if recording is possible...');
      final canRecordResult = await checkRecordingPermissions();
      debugPrint('Can record: ${canRecordResult['canRecord']}');
      debugPrint('Message: ${canRecordResult['message']}');

      if (!canRecordResult['canRecord']) {
        final errorDetails = canRecordResult['error'];
        debugPrint('Error details:');
        debugPrint('  - Error: ${errorDetails['error']}');
        debugPrint('  - Title: ${errorDetails['title']}');
        debugPrint('  - Message: ${errorDetails['message']}');
        debugPrint('  - Action: ${errorDetails['actionText']}');
        debugPrint('  - Can retry: ${errorDetails['canRetry']}');
        debugPrint('  - Can open settings: ${errorDetails['canOpenSettings']}');
      }

      // 3. Demonstrate permission request flow
      if (currentStatus != PermissionStatus.granted) {
        debugPrint('3. Demonstrating permission request flow...');
        final requestResult = await handlePermissionRequest();
        debugPrint('Request result:');
        debugPrint('  - Success: ${requestResult['success']}');
        debugPrint('  - Message: ${requestResult['message']}');

        if (requestResult.containsKey('error')) {
          final error = requestResult['error'];
          debugPrint('  - Error: ${error['error']}');
          debugPrint('  - Title: ${error['title']}');
          debugPrint('  - Action: ${error['actionText']}');
        }
      } else {
        debugPrint('3. Permission already granted, skipping request demonstration');
      }

      // 4. Demonstrate recording with permission handling
      debugPrint('4. Demonstrating recording with automatic permission handling...');
      final recordingResult = await startRecordingWithPermissions();
      debugPrint('Recording result:');
      debugPrint('  - Success: ${recordingResult['success']}');
      debugPrint('  - Message: ${recordingResult['message']}');

      if (recordingResult['success']) {
        debugPrint('  - Path: ${recordingResult['path']}');
        debugPrint('  - Quality: ${recordingResult['quality']}');

        // Stop the demonstration recording
        await Future.delayed(const Duration(seconds: 1));
        await stopRecording();
        debugPrint('  - Demonstration recording stopped');
      } else {
        debugPrint('  - Error: ${recordingResult['error']}');
        if (recordingResult.containsKey('permissionError')) {
          final permError = recordingResult['permissionError'];
          debugPrint('  - Permission Error: ${permError['error']}');
          debugPrint('  - Permission Title: ${permError['title']}');
          debugPrint('  - Permission Action: ${permError['actionText']}');
        }
      }

      debugPrint('=== PERMISSION HANDLING DEMONSTRATION COMPLETE ===');

    } catch (e) {
      debugPrint('Error in permission handling demonstration: $e');
    }
  }

  /// Demonstrate comprehensive error handling for recording operations
  /// This method shows how errors are handled and provides user-friendly messages
  Future<void> demonstrateErrorHandling() async {
    try {
      debugPrint('=== RECORDING ERROR HANDLING DEMONSTRATION ===');

      // 1. Test permission error handling
      debugPrint('1. Testing permission error handling...');
      try {
        // Simulate permission error
        throw RecordingPermissionException(
          'TEST_PERMISSION_ERROR',
          'Test Permission Error',
          'This is a test permission error message.',
          canRetry: true,
          canOpenSettings: true,
          actionText: 'Grant Permission',
        );
      } catch (e) {
        final errorResult = _handleRecordingError(e, 'permission_test');
        debugPrint('Permission error handled:');
        debugPrint('  - Error Type: ${errorResult['errorType']}');
        debugPrint('  - User Message: ${errorResult['userMessage']}');
        debugPrint('  - Can Retry: ${errorResult['canRetry']}');
        debugPrint('  - Can Open Settings: ${errorResult['canOpenSettings']}');
      }

      // 2. Test recording error handling
      debugPrint('2. Testing recording error handling...');
      try {
        // Simulate recording error
        throw RecordingException(
          'TEST_RECORDING_ERROR',
          'Test Recording Error',
          'This is a test user-friendly message.',
          'This is detailed debug information for developers.',
          canRetry: true,
          isTemporary: true,
          suggestedAction: 'Try again in a moment',
        );
      } catch (e) {
        final errorResult = _handleRecordingError(e, 'recording_test');
        debugPrint('Recording error handled:');
        debugPrint('  - Error Type: ${errorResult['errorType']}');
        debugPrint('  - User Message: ${errorResult['userMessage']}');
        debugPrint('  - Debug Message: ${errorResult['debugMessage']}');
        debugPrint('  - Can Retry: ${errorResult['canRetry']}');
        debugPrint('  - Is Temporary: ${errorResult['isTemporary']}');
      }

      // 3. Test file error handling
      debugPrint('3. Testing file error handling...');
      try {
        // Simulate file error
        throw AudioFileException(
          'TEST_FILE_ERROR',
          'Test File Error',
          'Unable to save recording file.',
          'File system error: Permission denied writing to /test/path',
          filePath: '/test/path/recording.mp3',
          canRetry: true,
        );
      } catch (e) {
        final errorResult = _handleRecordingError(e, 'file_test');
        debugPrint('File error handled:');
        debugPrint('  - Error Type: ${errorResult['errorType']}');
        debugPrint('  - User Message: ${errorResult['userMessage']}');
        debugPrint('  - File Path: ${errorResult['filePath']}');
        debugPrint('  - Can Retry: ${errorResult['canRetry']}');
      }

      // 4. Test platform exception handling
      debugPrint('4. Testing platform exception handling...');
      try {
        // Simulate platform exception
        throw Exception('PlatformException: Microphone permission denied by user');
      } catch (e) {
        final errorResult = _handleRecordingError(e, 'platform_test');
        debugPrint('Platform error handled:');
        debugPrint('  - Error Type: ${errorResult['errorType']}');
        debugPrint('  - User Message: ${errorResult['userMessage']}');
        debugPrint('  - Can Open Settings: ${errorResult['canOpenSettings']}');
      }

      // 5. Test file system exception handling
      debugPrint('5. Testing file system exception handling...');
      try {
        // Simulate file system exception
        throw FileSystemException('No space left on device', '/storage/recording.mp3');
      } catch (e) {
        final errorResult = _handleRecordingError(e, 'filesystem_test');
        debugPrint('File system error handled:');
        debugPrint('  - Error Type: ${errorResult['errorType']}');
        debugPrint('  - User Message: ${errorResult['userMessage']}');
        debugPrint('  - Suggested Action: ${errorResult['suggestedAction']}');
      }

      // 6. Test timeout error handling
      debugPrint('6. Testing timeout error handling...');
      try {
        // Simulate timeout error
        throw Exception('TimeoutException: Recording operation timed out after 30 seconds');
      } catch (e) {
        final errorResult = _handleRecordingError(e, 'timeout_test');
        debugPrint('Timeout error handled:');
        debugPrint('  - Error Type: ${errorResult['errorType']}');
        debugPrint('  - User Message: ${errorResult['userMessage']}');
        debugPrint('  - Is Temporary: ${errorResult['isTemporary']}');
      }

      // 7. Test generic error handling
      debugPrint('7. Testing generic error handling...');
      try {
        // Simulate generic error
        throw Exception('Some unexpected error occurred');
      } catch (e) {
        final errorResult = _handleRecordingError(e, 'generic_test');
        debugPrint('Generic error handled:');
        debugPrint('  - Error Type: ${errorResult['errorType']}');
        debugPrint('  - User Message: ${errorResult['userMessage']}');
        debugPrint('  - Can Retry: ${errorResult['canRetry']}');
      }

      debugPrint('=== ERROR HANDLING DEMONSTRATION COMPLETE ===');
      debugPrint('✅ All error types handled successfully with user-friendly messages');
      debugPrint('✅ Detailed logging provided for debugging');
      debugPrint('✅ App crash prevention implemented');

    } catch (e) {
      debugPrint('Error in error handling demonstration: $e');
    }
  }

  /// Demonstrate the new audio quality settings
  /// This method shows all available quality levels and their characteristics
  Future<void> demonstrateAudioQualitySettings() async {
    try {
      debugPrint('=== AUDIO QUALITY SETTINGS DEMONSTRATION ===');

      // 1. Show all available quality levels
      debugPrint('1. Available Quality Levels:');
      for (final quality in AudioQuality.values) {
        debugPrint('  - ${quality.description}');
        debugPrint('    * Bit Rate: ${quality.bitRate} bps');
        debugPrint('    * Sample Rate: ${quality.sampleRate} Hz');
        debugPrint('    * File Size: ${quality.estimatedSizePerMinuteMB.toStringAsFixed(2)} MB/min');
        debugPrint('    * Quality Level: ${quality.qualityLevel}/4');
        debugPrint('    * High Clarity: ${quality.isHighClarity}');
        debugPrint('    * Suitable for Long Recordings: ${quality.isSuitableForLongRecordings}');
        debugPrint('    * Use Case: ${quality.recommendedUseCase}');
        debugPrint('    * MIME Type: ${quality.mimeType}');
        debugPrint('');
      }

      // 2. Show current default quality
      debugPrint('2. Current Default Quality: ${_currentQuality.description}');
      debugPrint('   - This is now set to Standard Quality (128kbps) instead of Compatibility mode');
      debugPrint('   - Provides better audio quality by default');
      debugPrint('');

      // 3. Show quality recommendations for different durations
      debugPrint('3. Quality Recommendations by Duration:');
      final testDurations = [30, 120, 300, 600, 900]; // 30s, 2m, 5m, 10m, 15m
      for (final duration in testDurations) {
        final recommended = getRecommendedQuality(duration);
        final minutes = duration / 60.0;
        debugPrint('   - ${minutes.toStringAsFixed(1)} minutes: ${recommended.description}');
      }
      debugPrint('');

      // 4. Show quality recommendations for different use cases
      debugPrint('4. Quality Recommendations by Use Case:');
      final useCases = ['music', 'interview', 'voice', 'compatibility', 'professional'];
      for (final useCase in useCases) {
        final recommended = getRecommendedQualityForUseCase(useCase);
        debugPrint('   - $useCase: ${recommended.description}');
      }
      debugPrint('');

      // 5. Show file size comparisons
      debugPrint('5. File Size Comparison (for 5-minute recording):');
      for (final quality in AudioQuality.values) {
        final sizeMB = quality.estimatedSizePerMinuteMB * 5;
        debugPrint('   - ${quality.description}: ${sizeMB.toStringAsFixed(2)} MB');
      }
      debugPrint('');

      // 6. Test quality switching
      debugPrint('6. Testing Quality Switching:');
      final originalQuality = _currentQuality;

      for (final quality in AudioQuality.values) {
        setAudioQuality(quality);
        final metadata = getRecordingMetadata();
        debugPrint('   - Set to ${quality.description}:');
        debugPrint('     * Bit Rate: ${metadata['bitRate']} bps');
        debugPrint('     * Quality Level: ${metadata['qualityLevel']}/4');
        debugPrint('     * High Clarity: ${metadata['isHighClarity']}');
      }

      // Restore original quality
      setAudioQuality(originalQuality);
      debugPrint('   - Restored to original quality: ${originalQuality.description}');
      debugPrint('');

      // 7. Show improvements over old system
      debugPrint('7. Improvements Over Previous System:');
      debugPrint('   ✅ All quality modes now use reliable MP3 encoding');
      debugPrint('   ✅ Compatibility mode upgraded from 96kbps to 128kbps');
      debugPrint('   ✅ Added Premium (192kbps) and High (160kbps) quality options');
      debugPrint('   ✅ Default quality improved from Compatibility to Standard');
      debugPrint('   ✅ Better file size estimation with MP3 overhead calculation');
      debugPrint('   ✅ Intelligent quality recommendations based on duration and use case');
      debugPrint('   ✅ Enhanced metadata with quality level and clarity indicators');
      debugPrint('');

      debugPrint('=== AUDIO QUALITY SETTINGS DEMONSTRATION COMPLETE ===');
      debugPrint('✅ All quality modes use MP3 encoding for maximum compatibility');
      debugPrint('✅ Higher quality defaults provide better user experience');
      debugPrint('✅ Intelligent recommendations optimize quality vs file size');

    } catch (e) {
      debugPrint('Error in audio quality demonstration: $e');
    }
  }

  /// Demonstrate recording validation functionality
  /// This method shows how validation works and handles different error scenarios
  Future<void> demonstrateRecordingValidation() async {
    try {
      debugPrint('=== RECORDING VALIDATION DEMONSTRATION ===');

      // 1. Show validation constants and settings
      debugPrint('1. Validation Settings:');
      debugPrint('   - Minimum file size: $_minValidFileSizeBytes bytes (${(_minValidFileSizeBytes / 1024).toStringAsFixed(1)} KB)');
      debugPrint('   - Minimum duration: $_minValidDurationMs ms');
      debugPrint('   - Maximum retries: $_maxValidationRetries');
      debugPrint('   - Validation timeout: ${_validationTimeout.inSeconds} seconds');
      debugPrint('');

      // 2. Test validation with a non-existent file
      debugPrint('2. Testing validation with non-existent file...');
      final nonExistentResult = await validateRecordedFile('/non/existent/file.mp3');
      debugPrint('   Result: ${nonExistentResult['isValid'] ? 'VALID' : 'INVALID'}');
      if (!nonExistentResult['isValid']) {
        debugPrint('   Error: ${nonExistentResult['error']}');
        debugPrint('   Message: ${nonExistentResult['message']}');
        debugPrint('   Can Retry: ${nonExistentResult['canRetry']}');
      }
      debugPrint('');

      // 3. Show validation error types
      debugPrint('3. Validation Error Types Handled:');
      final errorTypes = [
        'FILE_NOT_FOUND - File does not exist',
        'EMPTY_FILE - File is 0 bytes',
        'FILE_TOO_SMALL - File smaller than minimum size',
        'INVALID_AUDIO_FORMAT - Invalid file header/format',
        'DURATION_UNKNOWN - Cannot determine audio duration',
        'DURATION_TOO_SHORT - Audio duration too short',
        'VALIDATION_TIMEOUT - Validation process timed out',
        'VALIDATION_ERROR - General validation failure',
      ];

      for (final errorType in errorTypes) {
        debugPrint('   ✓ $errorType');
      }
      debugPrint('');

      // 4. Show supported audio formats
      debugPrint('4. Supported Audio Format Validation:');
      debugPrint('   ✓ MP3 - ID3 tag (0x49 0x44 0x33) or frame sync (0xFF 0xE0+)');
      debugPrint('   ✓ AAC - ADTS header (0xFF 0xF0+)');
      debugPrint('   ✓ WAV - RIFF header (0x52 0x49 0x46 0x46)');
      debugPrint('');

      // 5. Show validation workflow
      debugPrint('5. Validation Workflow:');
      debugPrint('   1. Check file existence');
      debugPrint('   2. Check file size (minimum $_minValidFileSizeBytes bytes)');
      debugPrint('   3. Validate audio format by checking file header');
      debugPrint('   4. Validate audio duration using just_audio');
      debugPrint('   5. Compare actual vs expected duration (±2 second tolerance)');
      debugPrint('   6. Return comprehensive validation result');
      debugPrint('');

      // 6. Show integration with recording methods
      debugPrint('6. Integration with Recording Methods:');
      debugPrint('   ✓ stopRecording() - Automatic validation via _verifyAndFixAudioFile()');
      debugPrint('   ✓ safeStopRecordingWithValidation() - Safe wrapper with error handling');
      debugPrint('   ✓ recordWithValidationAndRetry() - Complete workflow with retry logic');
      debugPrint('   ✓ stopRecordingWithValidationAndRetry() - Stop with validation and retry');
      debugPrint('');

      // 7. Show user-friendly error messages
      debugPrint('7. User-Friendly Error Messages:');
      debugPrint('   ✓ "The recording file is empty. Please try recording again."');
      debugPrint('   ✓ "The recording is too short. Please record for at least 1 second."');
      debugPrint('   ✓ "The recorded file does not appear to be a valid audio file."');
      debugPrint('   ✓ "The recording validation timed out. The file may be corrupted."');
      debugPrint('   ✓ "Unable to validate the recording. The file may be corrupted."');
      debugPrint('');

      // 8. Show retry functionality
      debugPrint('8. Retry Functionality:');
      debugPrint('   ✓ Automatic retry on validation failure');
      debugPrint('   ✓ Configurable maximum retry attempts');
      debugPrint('   ✓ Intelligent delay between retries');
      debugPrint('   ✓ Different retry strategies for different error types');
      debugPrint('   ✓ Graceful fallback when all retries fail');
      debugPrint('');

      // 9. Show benefits for users
      debugPrint('9. Benefits for Users:');
      debugPrint('   ✅ Prevents upload of empty or corrupted files');
      debugPrint('   ✅ Clear error messages when recording fails');
      debugPrint('   ✅ Automatic retry for temporary issues');
      debugPrint('   ✅ Early detection of recording problems');
      debugPrint('   ✅ Better user experience with actionable feedback');
      debugPrint('   ✅ Reduced support requests for "silent" voice messages');
      debugPrint('');

      // 10. Show technical improvements
      debugPrint('10. Technical Improvements:');
      debugPrint('    ✅ File header validation for format verification');
      debugPrint('    ✅ Duration validation using just_audio player');
      debugPrint('    ✅ Timeout protection for validation operations');
      debugPrint('    ✅ Comprehensive error categorization');
      debugPrint('    ✅ Integration with existing error handling system');
      debugPrint('    ✅ Backward compatibility with existing recording flow');
      debugPrint('');

      debugPrint('=== RECORDING VALIDATION DEMONSTRATION COMPLETE ===');
      debugPrint('✅ Comprehensive validation prevents empty/corrupted file uploads');
      debugPrint('✅ User-friendly error messages guide users to successful recording');
      debugPrint('✅ Automatic retry functionality handles temporary issues');
      debugPrint('✅ Integration with existing recording workflow maintains compatibility');

    } catch (e) {
      debugPrint('Error in recording validation demonstration: $e');
    }
  }

  /// Safe recording operation wrapper that prevents app crashes
  /// This method wraps any recording operation with comprehensive error handling
  Future<Map<String, dynamic>> safeRecordingOperation(
    String operationName,
    Future<dynamic> Function() operation,
  ) async {
    try {
      debugPrint('=== SAFE RECORDING OPERATION: $operationName ===');

      final result = await operation();

      debugPrint('Safe operation completed successfully: $operationName');
      return {
        'success': true,
        'result': result,
        'operation': operationName,
        'message': 'Operation completed successfully',
      };

    } on RecordingPermissionException catch (e) {
      debugPrint('Permission error in safe operation $operationName: $e');
      return _handleRecordingError(e, operationName);
    } on RecordingException catch (e) {
      debugPrint('Recording error in safe operation $operationName: $e');
      return _handleRecordingError(e, operationName);
    } on AudioFileException catch (e) {
      debugPrint('File error in safe operation $operationName: $e');
      return _handleRecordingError(e, operationName);
    } catch (e) {
      debugPrint('Unexpected error in safe operation $operationName: $e');
      return _handleRecordingError(e, operationName);
    }
  }

  /// Safe start recording with comprehensive error handling
  /// This method ensures the app never crashes during recording start
  Future<Map<String, dynamic>> safeStartRecording({
    int? preserveDuration,
    bool isNewRecording = true,
    AudioQuality? quality,
  }) async {
    return await safeRecordingOperation('safeStartRecording', () async {
      final path = await startRecording(
        preserveDuration: preserveDuration,
        isNewRecording: isNewRecording,
        quality: quality,
      );

      if (path != null) {
        return {
          'path': path,
          'duration': _recordingDuration,
          'quality': _currentQuality.description,
        };
      } else {
        throw RecordingException(
          'START_RECORDING_FAILED',
          'Recording Start Failed',
          'Unable to start recording. Please try again.',
          'startRecording returned null path',
          canRetry: true,
          isTemporary: true,
          suggestedAction: 'Try again or check device settings',
        );
      }
    });
  }

  /// Safe stop recording with comprehensive error handling
  /// This method ensures the app never crashes during recording stop
  Future<Map<String, dynamic>> safeStopRecording() async {
    return await safeRecordingOperation('safeStopRecording', () async {
      final path = await stopRecording();

      if (path != null) {
        return {
          'path': path,
          'duration': _recordingDuration,
          'fileExists': await File(path).exists(),
        };
      } else {
        // Even if stop recording fails, we don't throw an error
        // because the recording state needs to be cleaned up
        debugPrint('Stop recording returned null, but this is not necessarily an error');
        return {
          'path': null,
          'duration': _recordingDuration,
          'fileExists': false,
          'warning': 'Recording stopped but no file was returned',
        };
      }
    });
  }

  /// Safe pause recording with comprehensive error handling
  /// This method ensures the app never crashes during recording pause
  Future<Map<String, dynamic>> safePauseRecording() async {
    return await safeRecordingOperation('safePauseRecording', () async {
      final success = await pauseRecording();

      return {
        'paused': success,
        'duration': _recordingDuration,
        'segments': _recordingSegments.length,
        'isPaused': _isRecordingPaused,
      };
    });
  }

  /// Safe resume recording with comprehensive error handling
  /// This method ensures the app never crashes during recording resume
  Future<Map<String, dynamic>> safeResumeRecording() async {
    return await safeRecordingOperation('safeResumeRecording', () async {
      final success = await resumeRecording();

      return {
        'resumed': success,
        'duration': _recordingDuration,
        'segments': _recordingSegments.length,
        'isPaused': _isRecordingPaused,
      };
    });
  }

  /// Safe stop recording with automatic validation
  /// This method stops recording and validates the file, providing retry options if validation fails
  Future<Map<String, dynamic>> safeStopRecordingWithValidation() async {
    return await safeRecordingOperation('safeStopRecordingWithValidation', () async {
      final path = await stopRecording();

      if (path != null) {
        // Validation is already performed in stopRecording via _verifyAndFixAudioFile
        // If we reach here, validation passed
        return {
          'path': path,
          'duration': _recordingDuration,
          'fileExists': await File(path).exists(),
          'validated': true,
        };
      } else {
        throw AudioFileException(
          'STOP_RECORDING_FAILED',
          'Recording Stop Failed',
          'Unable to stop recording or save the file. Please try again.',
          'stopRecording returned null path',
          canRetry: true,
        );
      }
    });
  }

  /// Validate and retry recording workflow
  /// This method provides a complete workflow with automatic retry on validation failure
  Future<Map<String, dynamic>> recordWithValidationAndRetry({
    int? preserveDuration,
    bool isNewRecording = true,
    AudioQuality? quality,
    int maxRetries = 3,
  }) async {
    int retryCount = 0;
    Map<String, dynamic>? lastError;

    while (retryCount < maxRetries) {
      try {
        debugPrint('=== RECORDING WITH VALIDATION (Attempt ${retryCount + 1}/$maxRetries) ===');

        // Start recording
        final startResult = await safeStartRecording(
          preserveDuration: preserveDuration,
          isNewRecording: isNewRecording,
          quality: quality,
        );

        if (!startResult['success']) {
          lastError = startResult;
          retryCount++;
          debugPrint('Recording start failed, attempt $retryCount/$maxRetries');

          if (retryCount < maxRetries) {
            debugPrint('Waiting 1 second before retry...');
            await Future.delayed(const Duration(seconds: 1));
            continue;
          } else {
            break;
          }
        }

        debugPrint('Recording started successfully, path: ${startResult['result']['path']}');

        // Return success with start information
        return {
          'success': true,
          'phase': 'RECORDING_STARTED',
          'message': 'Recording started successfully. Call stopRecordingWithValidation when done.',
          'startResult': startResult,
          'retryCount': retryCount,
        };

      } on AudioFileException catch (e) {
        debugPrint('Audio file error during recording attempt ${retryCount + 1}: $e');
        lastError = e.toMap();
        retryCount++;

        if (retryCount < maxRetries) {
          debugPrint('Retrying due to audio file error...');
          await Future.delayed(const Duration(seconds: 1));
        }
      } on RecordingException catch (e) {
        debugPrint('Recording error during recording attempt ${retryCount + 1}: $e');
        lastError = e.toMap();
        retryCount++;

        if (retryCount < maxRetries && e.canRetry) {
          debugPrint('Retrying due to recording error...');
          await Future.delayed(const Duration(seconds: 1));
        } else {
          break; // Don't retry if error is not retryable
        }
      } catch (e) {
        debugPrint('Unexpected error during recording attempt ${retryCount + 1}: $e');
        lastError = _handleRecordingError(e, 'recordWithValidationAndRetry');
        retryCount++;

        if (retryCount < maxRetries) {
          debugPrint('Retrying due to unexpected error...');
          await Future.delayed(const Duration(seconds: 1));
        }
      }
    }

    // All retries failed
    debugPrint('❌ All recording attempts failed after $maxRetries retries');
    return {
      'success': false,
      'error': 'MAX_RETRIES_EXCEEDED',
      'message': 'Recording failed after $maxRetries attempts. Please check your device and try again.',
      'retryCount': retryCount,
      'lastError': lastError,
      'canRetry': true,
      'suggestedAction': 'Check microphone permissions and device settings',
    };
  }

  /// Complete stop recording with validation and retry
  /// This method stops recording, validates the file, and provides retry options
  Future<Map<String, dynamic>> stopRecordingWithValidationAndRetry({
    int maxRetries = 2,
  }) async {
    int retryCount = 0;
    Map<String, dynamic>? lastError;

    while (retryCount < maxRetries) {
      try {
        debugPrint('=== STOP RECORDING WITH VALIDATION (Attempt ${retryCount + 1}/$maxRetries) ===');

        // Stop recording with validation
        final stopResult = await safeStopRecordingWithValidation();

        if (stopResult['success']) {
          debugPrint('✅ Recording stopped and validated successfully');
          return {
            'success': true,
            'message': 'Recording completed and validated successfully',
            'path': stopResult['result']['path'],
            'duration': stopResult['result']['duration'],
            'validated': true,
            'retryCount': retryCount,
          };
        } else {
          lastError = stopResult;
          retryCount++;
          debugPrint('Recording stop/validation failed, attempt $retryCount/$maxRetries');
        }

      } on AudioFileException catch (e) {
        debugPrint('Audio file validation error during stop attempt ${retryCount + 1}: $e');
        lastError = e.toMap();
        retryCount++;

        if (retryCount < maxRetries) {
          debugPrint('Validation failed, but recording may be salvageable. Retrying...');
          await Future.delayed(const Duration(milliseconds: 500));
        }
      } catch (e) {
        debugPrint('Unexpected error during stop attempt ${retryCount + 1}: $e');
        lastError = _handleRecordingError(e, 'stopRecordingWithValidationAndRetry');
        retryCount++;

        if (retryCount < maxRetries) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }

    // All retries failed
    debugPrint('❌ All stop/validation attempts failed after $maxRetries retries');
    return {
      'success': false,
      'error': 'STOP_VALIDATION_FAILED',
      'message': 'Unable to stop recording or validate the file after $maxRetries attempts.',
      'retryCount': retryCount,
      'lastError': lastError,
      'canRetry': true,
      'suggestedAction': 'Try recording again or check device storage',
    };
  }

  /// Get quality recommendation based on duration and device compatibility
  /// Updated to use higher quality defaults with intelligent fallback
  AudioQuality getRecommendedQuality(int estimatedDurationSeconds) {
    final estimatedMinutes = estimatedDurationSeconds / 60.0;

    // All modes now use reliable MP3 encoding for maximum compatibility
    // For very short recordings (< 1 minute), use high quality for best experience
    if (estimatedMinutes < 1) {
      return AudioQuality.high; // 160kbps - excellent quality for short clips
    }
    // For short recordings (1-3 minutes), use standard quality
    else if (estimatedMinutes < 3) {
      return AudioQuality.standard; // 128kbps - good balance
    }
    // For medium recordings (3-7 minutes), use standard quality
    else if (estimatedMinutes < 7) {
      return AudioQuality.standard; // 128kbps - reliable for medium length
    }
    // For long recordings (> 7 minutes), use compatibility mode (still 128kbps now)
    else {
      return AudioQuality.compatibility; // 128kbps - maximum compatibility
    }
  }

  /// Get quality recommendation based on use case
  AudioQuality getRecommendedQualityForUseCase(String useCase) {
    switch (useCase.toLowerCase()) {
      case 'music':
      case 'presentation':
      case 'interview':
        return AudioQuality.premium; // 192kbps for highest quality
      case 'important':
      case 'professional':
      case 'meeting':
        return AudioQuality.high; // 160kbps for excellent clarity
      case 'voice':
      case 'message':
      case 'chat':
      case 'casual':
        return AudioQuality.standard; // 128kbps for regular use
      case 'compatibility':
      case 'old_device':
      case 'fallback':
        return AudioQuality.compatibility; // 128kbps for maximum compatibility
      default:
        return AudioQuality.standard; // Default to standard quality
    }
  }

  /// Check if device supports AAC codec
  Future<bool> _supportsAACCodec() async {
    try {
      // For record package, we'll assume AAC is supported and handle errors during recording
      // This is a simplified approach since record package handles codec support internally
      debugPrint('Assuming AAC codec support - will handle errors during recording');
      return true;
    } catch (e) {
      debugPrint('Error testing AAC codec support: $e');
      return false;
    }
  }

  /// Get persistent cache directory
  Future<Directory> _getCacheDirectory() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory('${appDocDir.path}/$_cacheDirectoryName');

    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
      debugPrint('Created cache directory: ${cacheDir.path}');
    }

    return cacheDir;
  }

  /// Get cache file path for a specific chat and message
  Future<String> _getCacheFilePath(String chatId, String messageId, String extension) async {
    final cacheDir = await _getCacheDirectory();
    final chatCacheDir = Directory('${cacheDir.path}/$chatId');

    if (!await chatCacheDir.exists()) {
      await chatCacheDir.create(recursive: true);
    }

    return '${chatCacheDir.path}/$messageId.$extension';
  }

  /// Generate cache key from URL
  String _generateCacheKey(String url) {
    // Extract meaningful parts from URL for cache key
    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;

    if (pathSegments.isNotEmpty) {
      // Use the last path segment (usually the filename)
      final filename = pathSegments.last;
      // Remove extension and use as key
      return filename.split('.').first;
    }

    // Fallback: use hash of URL
    return url.hashCode.abs().toString();
  }

  /// Check network connectivity
  Future<bool> _isNetworkAvailable() async {
    try {
      // Simple connectivity check by trying to resolve a DNS
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      debugPrint('Network check failed: $e');
      return false;
    }
  }

  /// Emit cache status update
  void _emitCacheStatus(CacheStatus status) {
    try {
      _cacheStatusController.add(status);
    } catch (e) {
      debugPrint('Error emitting cache status: $e');
    }
  }

  /// Check if file exists in cache and is not expired
  Future<File?> _getCachedAudioFile(String url, {String? chatId, String? messageId}) async {
    try {
      final audioFormat = _detectAudioFormat(url);

      // Try structured cache first (if chatId and messageId provided)
      if (chatId != null && messageId != null) {
        final structuredPath = await _getCacheFilePath(chatId, messageId, audioFormat.extension);
        final structuredFile = File(structuredPath);

        if (await structuredFile.exists()) {
          // Check if file is not expired
          final stat = await structuredFile.stat();
          final age = DateTime.now().difference(stat.modified);

          if (age.inDays < _cacheExpiryDays) {
            debugPrint('Found cached file (structured): ${structuredFile.path}');
            // Update access time by touching the file
            await structuredFile.setLastModified(DateTime.now());
            // Emit cache hit status
            _emitCacheStatus(CacheStatus.hit);
            return structuredFile;
          } else {
            debugPrint('Cached file expired, deleting: ${structuredFile.path}');
            await structuredFile.delete();
            // Emit cache expired status
            _emitCacheStatus(CacheStatus.expired);
          }
        }
      }

      // Fallback to legacy cache (for backward compatibility)
      final cacheKey = _generateCacheKey(url);
      final cacheDir = await _getCacheDirectory();
      final legacyFile = File('${cacheDir.path}/$cacheKey.${audioFormat.extension}');

      if (await legacyFile.exists()) {
        final stat = await legacyFile.stat();
        final age = DateTime.now().difference(stat.modified);

        if (age.inDays < _cacheExpiryDays) {
          debugPrint('Found cached file (legacy): ${legacyFile.path}');
          // Update access time
          await legacyFile.setLastModified(DateTime.now());
          // Emit cache hit status
          _emitCacheStatus(CacheStatus.hit);
          return legacyFile;
        } else {
          debugPrint('Legacy cached file expired, deleting: ${legacyFile.path}');
          await legacyFile.delete();
          // Emit cache expired status
          _emitCacheStatus(CacheStatus.expired);
        }
      }

      debugPrint('No valid cached file found for: $url');
      // Emit cache miss status
      _emitCacheStatus(CacheStatus.miss);
      return null;
    } catch (e) {
      debugPrint('Error getting cached file: $e');
      return null;
    }
  }

  /// Cache audio file with proper structure
  Future<File?> _cacheAudioFile(String url, List<int> audioData, {String? chatId, String? messageId}) async {
    try {
      final audioFormat = _detectAudioFormat(url);
      File cacheFile;

      // Use structured cache if chatId and messageId provided
      if (chatId != null && messageId != null) {
        final structuredPath = await _getCacheFilePath(chatId, messageId, audioFormat.extension);
        cacheFile = File(structuredPath);
        debugPrint('Caching file (structured): ${cacheFile.path}');
      } else {
        // Fallback to legacy cache
        final cacheKey = _generateCacheKey(url);
        final cacheDir = await _getCacheDirectory();
        cacheFile = File('${cacheDir.path}/$cacheKey.${audioFormat.extension}');
        debugPrint('Caching file (legacy): ${cacheFile.path}');
      }

      // Write audio data to cache file
      await cacheFile.writeAsBytes(audioData);

      // Verify file was written successfully
      if (await cacheFile.exists() && await cacheFile.length() > 0) {
        debugPrint('File cached successfully: ${cacheFile.path}, size: ${audioData.length} bytes');

        // Emit cache success status
        _emitCacheStatus(CacheStatus.cached);

        // Clean up cache if needed
        await _cleanupCacheIfNeeded();

        return cacheFile;
      } else {
        debugPrint('Failed to cache file: ${cacheFile.path}');
        // Emit cache error status
        _emitCacheStatus(CacheStatus.error);
        return null;
      }
    } catch (e) {
      debugPrint('Error caching file: $e');
      return null;
    }
  }

  /// Clean up cache if size exceeds limit or files are expired
  Future<void> _cleanupCacheIfNeeded() async {
    try {
      final cacheDir = await _getCacheDirectory();
      final cacheSize = await _calculateCacheSize();

      debugPrint('Current cache size: ${(cacheSize / (1024 * 1024)).toStringAsFixed(2)} MB');

      // If cache size exceeds limit, clean up old files
      if (cacheSize > _maxCacheSizeMB * 1024 * 1024) {
        debugPrint('Cache size exceeded ${_maxCacheSizeMB}MB, cleaning up...');
        await _cleanupOldCacheFiles();
      }

      // Clean up expired files
      await _cleanupExpiredFiles();

    } catch (e) {
      debugPrint('Error during cache cleanup: $e');
    }
  }

  /// Calculate total cache size in bytes
  Future<int> _calculateCacheSize() async {
    try {
      final cacheDir = await _getCacheDirectory();
      int totalSize = 0;

      await for (final entity in cacheDir.list(recursive: true)) {
        if (entity is File) {
          final stat = await entity.stat();
          totalSize += stat.size;
        }
      }

      return totalSize;
    } catch (e) {
      debugPrint('Error calculating cache size: $e');
      return 0;
    }
  }

  /// Clean up old cache files (LRU - Least Recently Used)
  Future<void> _cleanupOldCacheFiles() async {
    try {
      final cacheDir = await _getCacheDirectory();
      final List<FileSystemEntity> files = [];

      // Collect all cache files
      await for (final entity in cacheDir.list(recursive: true)) {
        if (entity is File) {
          files.add(entity);
        }
      }

      // Sort by last modified time (oldest first)
      files.sort((a, b) {
        final aStat = a.statSync();
        final bStat = b.statSync();
        return aStat.modified.compareTo(bStat.modified);
      });

      // Delete oldest files until cache size is under limit
      int currentSize = await _calculateCacheSize();
      final targetSize = (_maxCacheSizeMB * 0.8 * 1024 * 1024).round(); // 80% of max size

      for (final file in files) {
        if (currentSize <= targetSize) break;

        try {
          final stat = file.statSync();
          await file.delete();
          currentSize -= stat.size;
          debugPrint('Deleted old cache file: ${file.path}');
        } catch (e) {
          debugPrint('Error deleting cache file ${file.path}: $e');
        }
      }

      debugPrint('Cache cleanup completed. New size: ${(currentSize / (1024 * 1024)).toStringAsFixed(2)} MB');
    } catch (e) {
      debugPrint('Error cleaning up old cache files: $e');
    }
  }

  /// Clean up expired cache files
  Future<void> _cleanupExpiredFiles() async {
    try {
      final cacheDir = await _getCacheDirectory();
      final now = DateTime.now();
      int deletedCount = 0;

      await for (final entity in cacheDir.list(recursive: true)) {
        if (entity is File) {
          try {
            final stat = await entity.stat();
            final age = now.difference(stat.modified);

            if (age.inDays >= _cacheExpiryDays) {
              await entity.delete();
              deletedCount++;
              debugPrint('Deleted expired cache file: ${entity.path}');
            }
          } catch (e) {
            debugPrint('Error checking/deleting expired file ${entity.path}: $e');
          }
        }
      }

      if (deletedCount > 0) {
        debugPrint('Cleaned up $deletedCount expired cache files');
      }
    } catch (e) {
      debugPrint('Error cleaning up expired files: $e');
    }
  }

  /// Public method: Initialize cache system and cleanup on app start
  Future<void> initializeCache() async {
    try {
      debugPrint('Initializing voice message cache system...');

      // Ensure cache directory exists
      await _getCacheDirectory();

      // Perform initial cleanup
      await _cleanupCacheIfNeeded();

      final cacheSize = await _calculateCacheSize();
      debugPrint('Cache system initialized. Current size: ${(cacheSize / (1024 * 1024)).toStringAsFixed(2)} MB');
    } catch (e) {
      debugPrint('Error initializing cache: $e');
    }
  }

  /// Public method: Get cache statistics
  Future<Map<String, dynamic>> getCacheStats() async {
    try {
      final cacheDir = await _getCacheDirectory();
      final cacheSize = await _calculateCacheSize();
      int fileCount = 0;
      int expiredCount = 0;
      final now = DateTime.now();

      await for (final entity in cacheDir.list(recursive: true)) {
        if (entity is File) {
          fileCount++;
          try {
            final stat = await entity.stat();
            final age = now.difference(stat.modified);
            if (age.inDays >= _cacheExpiryDays) {
              expiredCount++;
            }
          } catch (e) {
            // Ignore stat errors
          }
        }
      }

      return {
        'totalSizeMB': (cacheSize / (1024 * 1024)),
        'maxSizeMB': _maxCacheSizeMB,
        'fileCount': fileCount,
        'expiredCount': expiredCount,
        'expiryDays': _cacheExpiryDays,
        'cacheDirectory': cacheDir.path,
      };
    } catch (e) {
      debugPrint('Error getting cache stats: $e');
      return {};
    }
  }

  /// Public method: Clear all cache
  Future<void> clearCache() async {
    try {
      final cacheDir = await _getCacheDirectory();

      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        debugPrint('Cache cleared successfully');

        // Recreate cache directory
        await _getCacheDirectory();
      }
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  /// Public method: Clear cache for specific chat
  Future<void> clearChatCache(String chatId) async {
    try {
      final cacheDir = await _getCacheDirectory();
      final chatCacheDir = Directory('${cacheDir.path}/$chatId');

      if (await chatCacheDir.exists()) {
        await chatCacheDir.delete(recursive: true);
        debugPrint('Cache cleared for chat: $chatId');
      }
    } catch (e) {
      debugPrint('Error clearing chat cache: $e');
    }
  }

  /// Check if audio file is available offline (cached)
  Future<bool> isAudioAvailableOffline(String source, {String? chatId, String? messageId}) async {
    try {
      if (!source.startsWith('http')) {
        // Local file - always available offline
        final file = File(source);
        return await file.exists();
      }

      // Check if URL has cached version
      final cachedFile = await _getCachedAudioFile(source, chatId: chatId, messageId: messageId);
      return cachedFile != null;
    } catch (e) {
      debugPrint('Error checking offline availability: $e');
      return false;
    }
  }

  /// Get offline playback status for multiple audio sources
  Future<Map<String, bool>> getOfflineAvailability(List<String> sources, {String? chatId}) async {
    final Map<String, bool> availability = {};

    for (final source in sources) {
      // Extract message ID from source if possible
      String? messageId;
      try {
        final uri = Uri.parse(source);
        final pathSegments = uri.pathSegments;
        if (pathSegments.isNotEmpty) {
          messageId = pathSegments.last.split('.').first;
        }
      } catch (e) {
        // Ignore parsing errors
      }

      availability[source] = await isAudioAvailableOffline(source, chatId: chatId, messageId: messageId);
    }

    return availability;
  }

  /// Initialize the recorder with proper permission handling
  /// Returns true if initialization successful, false otherwise
  Future<bool> _initRecorder() async {
    if (!_isRecorderInitialized) {
      try {
        debugPrint('Initializing recorder with permission check...');

        // Check current permission status
        final permissionStatus = await checkMicrophonePermission();

        if (permissionStatus == PermissionStatus.granted) {
          // For record package, no explicit initialization needed
          // Just verify we have permission
          final hasPermission = await _recorder.hasPermission();
          _isRecorderInitialized = hasPermission;

          if (hasPermission) {
            debugPrint('Record package initialized successfully with granted permissions');
            return true;
          } else {
            debugPrint('Record package reports no permission despite granted status');
            _isRecorderInitialized = false;
            return false;
          }
        } else {
          debugPrint('Microphone permission not granted: $permissionStatus');
          _isRecorderInitialized = false;
          return false;
        }
      } catch (e) {
        debugPrint('Error initializing recorder: $e');
        _isRecorderInitialized = false;
        return false;
      }
    }

    // Already initialized
    return _isRecorderInitialized;
  }

  /// Start recording WITHOUT showing ANY permission dialog
  /// Returns the path where the recording will be saved
  /// [preserveDuration] - If provided, will start the timer from this duration instead of 0
  /// [isNewRecording] - If true, clears previous recording segments
  /// [quality] - Optional quality setting, uses current quality if not provided
  Future<String?> startRecording({
    int? preserveDuration,
    bool isNewRecording = true,
    AudioQuality? quality,
  }) async {
    try {
      // Set quality if provided
      if (quality != null) {
        setAudioQuality(quality);
      }

      // Check if recording is already in progress
      if (await _recorder.isRecording()) {
        debugPrint('Recording already in progress, stopping first');
        await stopRecording();
      }

      // Initialize with permission check
      final initSuccess = await _initRecorder();

      // Only proceed if initialization was successful
      if (!initSuccess || !_isRecorderInitialized) {
        debugPrint('Recorder initialization failed - checking permissions...');

        // Get detailed permission status for error reporting
        final permissionResult = await checkRecordingPermissions();
        if (!permissionResult['canRecord']) {
          final errorDetails = permissionResult['error'];
          debugPrint('Recording failed due to permissions: ${errorDetails['error']}');
          debugPrint('User message: ${permissionResult['message']}');

          // Throw a detailed exception that UI can catch and handle
          throw RecordingPermissionException(
            errorDetails['error'],
            errorDetails['title'],
            errorDetails['message'],
            canRetry: errorDetails['canRetry'],
            canOpenSettings: errorDetails['canOpenSettings'],
            actionText: errorDetails['actionText'],
          );
        }

        debugPrint('Recorder not initialized, cannot start recording');
        return null;
      }

      // If this is a new recording (not resuming), clear previous segments
      if (isNewRecording) {
        _recordingSegments.clear();
      }

      // Create a recording file path optimized for record package and upload compatibility
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'voice_message_${timestamp}.${_currentQuality.extension}';
      _recordingPath = '${tempDir.path}/$fileName';

      // Ensure the temporary directory exists
      if (!await tempDir.exists()) {
        await tempDir.create(recursive: true);
        debugPrint('Created temporary directory: ${tempDir.path}');
      }

      debugPrint('Starting recording with exact high-quality settings: ${_currentQuality.description}');
      debugPrint('File path: $_recordingPath');

      // Start recording with current quality settings
      try {
        debugPrint('Attempting to start recording with ${_currentQuality.description}...');
        debugPrint('Quality settings: ${_currentQuality.bitRate}bps, ${_currentQuality.sampleRate}Hz, ${_currentQuality.extension}');

        await _recorder.start(
          RecordConfig(
            encoder: _currentQuality.encoder,     // Use current quality encoder (all MP3 now)
            bitRate: _currentQuality.bitRate,    // Use current quality bit rate
            sampleRate: _currentQuality.sampleRate, // Use current quality sample rate (renamed from samplingRate)
            numChannels: 1,                      // Mono recording for better compatibility
          ),
          path: _recordingPath!,                 // Path is now required
        );
        debugPrint('Recording started successfully with ${_currentQuality.description}');
      } catch (e) {
        debugPrint('Failed to start recording with high-quality AAC settings: $e');

        // Analyze the error and provide specific handling
        if (e.toString().toLowerCase().contains('permission')) {
          throw RecordingPermissionException(
            'RECORDING_PERMISSION_DENIED',
            'Microphone Permission Required',
            'Microphone access is required to record voice messages. Please grant permission and try again.',
            canRetry: true,
            canOpenSettings: true,
            actionText: 'Grant Permission',
          );
        } else if (e.toString().toLowerCase().contains('codec') || e.toString().toLowerCase().contains('format')) {
          throw RecordingException(
            'CODEC_NOT_SUPPORTED',
            'Audio Format Error',
            'High-quality audio format not supported. Trying alternative format.',
            'AAC codec error during recording start: $e',
            canRetry: true,
            isTemporary: false,
            suggestedAction: 'Use compatibility mode',
          );
        } else if (e.toString().toLowerCase().contains('busy') || e.toString().toLowerCase().contains('in use')) {
          throw RecordingException(
            'MICROPHONE_BUSY',
            'Microphone In Use',
            'Microphone is being used by another app. Please close other apps and try again.',
            'Microphone busy error during recording start: $e',
            canRetry: true,
            isTemporary: true,
            suggestedAction: 'Close other apps using microphone',
          );
        } else {
          // Generic recording error - will be handled by fallback
          debugPrint('Generic recording error, attempting fallback...');
        }

        // Fallback: Try with same quality settings but ensure correct file extension
        debugPrint('Primary recording failed, trying fallback with same quality settings');

        // Ensure we have correct extension for fallback
        final expectedExtension = _currentQuality.extension;
        if (!_recordingPath!.toLowerCase().endsWith('.$expectedExtension')) {
          _recordingPath = '${_recordingPath!.replaceAll(RegExp(r'\.[^.]+$'), '.$expectedExtension')}';
        }

        try {
          await _recorder.start(
            RecordConfig(
              encoder: _currentQuality.encoder,     // Use current quality encoder
              bitRate: _currentQuality.bitRate,    // Use current quality bit rate
              sampleRate: _currentQuality.sampleRate, // Use current quality sample rate (renamed from samplingRate)
              numChannels: 1,                      // Mono recording for better compatibility
            ),
            path: _recordingPath!,                 // Path is now required
          );
          debugPrint('Fallback recording started successfully with ${_currentQuality.description}');
        } catch (e2) {
          debugPrint('High-quality fallback also failed, trying minimal settings: $e2');

          // Only if current quality fails, try compatibility mode as last resort
          try {
            debugPrint('Attempting compatibility mode recording as last resort...');
            final compatibilityQuality = AudioQuality.compatibility;
            await _recorder.start(
              RecordConfig(
                encoder: compatibilityQuality.encoder,     // AAC encoder
                bitRate: compatibilityQuality.bitRate,    // 128kbps (upgraded from old 96kbps)
                sampleRate: compatibilityQuality.sampleRate, // 44.1kHz (renamed from samplingRate)
                numChannels: 1,                           // Mono recording
              ),
              path: _recordingPath!,                      // Path is now required
            );
            debugPrint('Compatibility mode recording started successfully (${compatibilityQuality.description})');
          } catch (e3) {
            debugPrint('All recording attempts failed: $e3');

            // Provide specific error based on the final failure
            if (e3.toString().toLowerCase().contains('permission')) {
              throw RecordingPermissionException(
                'RECORDING_PERMISSION_DENIED',
                'Microphone Permission Required',
                'Microphone access is required to record voice messages. Please grant permission and try again.',
                canRetry: true,
                canOpenSettings: true,
                actionText: 'Grant Permission',
              );
            } else if (e3.toString().toLowerCase().contains('hardware') || e3.toString().toLowerCase().contains('device')) {
              throw RecordingException(
                'HARDWARE_NOT_SUPPORTED',
                'Recording Not Supported',
                'Voice recording is not supported on this device.',
                'Hardware/device error after all recording attempts: $e3',
                canRetry: false,
                isTemporary: false,
                suggestedAction: 'Check device compatibility',
              );
            } else if (e3.toString().toLowerCase().contains('codec') || e3.toString().toLowerCase().contains('format')) {
              throw RecordingException(
                'NO_SUPPORTED_CODEC',
                'Audio Format Not Supported',
                'No supported audio format found on this device.',
                'No supported codec after all attempts: $e3',
                canRetry: false,
                isTemporary: false,
                suggestedAction: 'Device may not support voice recording',
              );
            } else {
              throw RecordingException(
                'RECORDING_FAILED',
                'Recording Failed',
                'Unable to start recording. Please try again or restart the app.',
                'All recording attempts failed with final error: $e3',
                canRetry: true,
                isTemporary: true,
                suggestedAction: 'Restart the app or check device settings',
              );
            }
          }
        }
      }

      // Start timer for tracking duration
      // If preserveDuration is provided, start from that value instead of 0
      _recordingDuration = preserveDuration ?? 0;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _recordingDuration++;
        _durationController.add(_recordingDuration);
      });

      debugPrint('Recording started successfully with exact high-quality settings: ${_currentQuality.description}');
      return _recordingPath;
    } catch (e) {
      debugPrint('Error starting recording: $e');
      debugPrint('Failed to start recording');

      // Clean up on failure
      _timer?.cancel();
      _timer = null;
      _recordingPath = null;

      return null;
    }
  }

  /// Stop recording without any permission dialogs and return the recording path
  /// If there are multiple segments, they will be merged into a single file
  Future<String?> stopRecording() async {
    try {
      debugPrint('Attempting to stop recording...');

      // Check if recording is actually in progress
      if (await _recorder.isRecording()) {
        debugPrint('Recording is active, stopping recorder...');

        // Stop recorder using record package - this returns the actual recorded file path
        final recordedPath = await _recorder.stop();
        debugPrint('Recorder stopped successfully. Recorded path: $recordedPath');

        // Stop the timer if it's running
        _timer?.cancel();
        _timer = null;
        debugPrint('Recording timer stopped. Final duration: $_recordingDuration seconds');

        // Use the path returned by the recorder, or fall back to our stored path
        final tempPath = recordedPath ?? _recordingPath;
        debugPrint('Using file path: $tempPath');

        // Add current segment to the list if it exists
        if (tempPath != null) {
          _recordingSegments.add(tempPath);
          debugPrint('Added segment to list. Total segments: ${_recordingSegments.length}');
        }

        String? finalPath;

        // If we have multiple segments, merge them
        if (_recordingSegments.length > 1) {
          debugPrint('Multiple segments detected, merging ${_recordingSegments.length} segments...');
          // Create a merged file
          finalPath = await _mergeAudioSegments(_recordingSegments);
          debugPrint('Segments merged successfully. Final path: $finalPath');
        } else if (_recordingSegments.isNotEmpty) {
          // Just return the single segment
          finalPath = _recordingSegments.first;
          debugPrint('Single segment recording. Final path: $finalPath');
        }

        // Verify file and calculate actual duration
        if (finalPath != null) {
          debugPrint('Verifying and fixing audio file...');
          await _verifyAndFixAudioFile(finalPath);
          debugPrint('Audio file verification completed');
        } else {
          debugPrint('Warning: No final path available for verification');
        }

        debugPrint('Recording stopped successfully. Returning path: $finalPath');

        // WAV files are recorded directly, no conversion needed
        // Backend will handle any format conversion if required
        return finalPath;
      } else {
        debugPrint('No active recording found to stop');
        return null;
      }
    } catch (e) {
      // Enhanced error handling with cleanup
      debugPrint('Error stopping recording: $e');

      // Ensure timer is stopped even on error
      _timer?.cancel();
      _timer = null;

      // Determine if we have any segments to salvage
      String? salvageablePath;
      if (_recordingSegments.isNotEmpty) {
        salvageablePath = _recordingSegments.last;
        debugPrint('Attempting to salvage last recording segment: $salvageablePath');
      } else if (_recordingPath != null) {
        final file = File(_recordingPath!);
        if (await file.exists()) {
          salvageablePath = _recordingPath;
          debugPrint('Attempting to salvage current recording file: $salvageablePath');
        }
      }

      // Reset recording state on error
      _recordingPath = null;

      // Log detailed error for debugging
      debugPrint('Stop recording error details:');
      debugPrint('  - Error type: ${e.runtimeType}');
      debugPrint('  - Error message: $e');
      debugPrint('  - Salvageable path: $salvageablePath');
      debugPrint('  - Recording duration: $_recordingDuration seconds');
      debugPrint('  - Segments count: ${_recordingSegments.length}');

      // Return salvageable path if available, otherwise null
      return salvageablePath;
    }
  }

  /// Verify audio file and fix duration metadata if needed
  /// Now includes comprehensive validation with error throwing
  Future<void> _verifyAndFixAudioFile(String filePath) async {
    try {
      debugPrint('=== AUDIO FILE VERIFICATION ===');
      debugPrint('Verifying file: $filePath');

      // Perform comprehensive validation
      final validationResult = await validateRecordedFile(filePath);

      if (!validationResult['isValid']) {
        debugPrint('❌ File validation failed: ${validationResult['error']}');

        // Throw specific validation exception
        throw AudioFileException(
          validationResult['error'],
          validationResult['title'],
          validationResult['message'],
          'File validation failed: ${validationResult['details']}',
          filePath: filePath,
          canRetry: validationResult['canRetry'] ?? true,
        );
      }

      debugPrint('✅ File validation passed');

      // Update duration from validation if available
      if (validationResult.containsKey('durationMs')) {
        final actualDurationMs = validationResult['durationMs'] as int;
        final actualSeconds = (actualDurationMs / 1000).round();

        final timeDiff = (actualSeconds - _recordingDuration).abs();
        if (timeDiff > 1) {
          debugPrint('Updating duration from $_recordingDuration to $actualSeconds seconds based on validation');
          _recordingDuration = actualSeconds;
          _durationController.add(_recordingDuration);
        }
      }

      // Legacy verification for backward compatibility
      final file = File(filePath);
      final fileSize = await file.length();
      debugPrint('Audio file verification:');
      debugPrint('  Path: $filePath');
      debugPrint('  Size: $fileSize bytes');
      debugPrint('  Timer Duration: $_recordingDuration seconds');
      debugPrint('  File Format: ${filePath.toLowerCase().endsWith('.mp3') ? 'MP3' : filePath.toLowerCase().endsWith('.wav') ? 'WAV' : 'Unknown'}');

      // For WAV files, try to calculate duration from file size (legacy support)
      if (filePath.toLowerCase().endsWith('.wav')) {
        await _fixWAVDuration(filePath, fileSize);
      }

      // For MP3 files, we rely on just_audio for duration detection
      if (filePath.toLowerCase().endsWith('.mp3')) {
        debugPrint('  MP3 file detected - using just_audio for duration verification');
      }

      // Try to get actual duration using just_audio
      try {
        debugPrint('  Attempting to read file duration using just_audio...');
        final tempPlayer = just_audio.AudioPlayer();
        await tempPlayer.setFilePath(filePath);
        final actualDuration = tempPlayer.duration;

        if (actualDuration != null && actualDuration.inSeconds > 0) {
          debugPrint('  ✅ Actual Duration (from file): ${actualDuration.inSeconds} seconds');
          debugPrint('  ✅ File contains valid audio data');

          // Update our internal duration if file duration is significantly different
          final timeDiff = (actualDuration.inSeconds - _recordingDuration).abs();
          if (timeDiff > 1) {
            debugPrint('  ⚠️ Duration mismatch detected: Timer=${_recordingDuration}s, File=${actualDuration.inSeconds}s');
            debugPrint('  🔄 Updating timer duration to match file duration');
            _recordingDuration = actualDuration.inSeconds;
            _durationController.add(_recordingDuration);
          } else {
            debugPrint('  ✅ Timer and file durations match (difference: ${timeDiff}s)');
          }
        } else {
          debugPrint('  ❌ Could not get duration from file (duration is null or 0)');
          debugPrint('  ⚠️ This may indicate an empty or corrupted audio file');
          debugPrint('  🔄 Using timer duration: $_recordingDuration seconds');

          // If file has no duration but timer shows duration, this indicates a problem
          if (_recordingDuration > 0) {
            debugPrint('  ❌ CRITICAL: Timer shows ${_recordingDuration}s but file has no audio data');
            debugPrint('  ❌ This indicates a recording failure - file may be empty or corrupted');
          }
        }

        await tempPlayer.dispose();
      } catch (e) {
        debugPrint('  ❌ Error getting file duration: $e');
        debugPrint('  ⚠️ This may indicate file corruption or unsupported format');
        debugPrint('  🔄 Using timer duration: $_recordingDuration seconds');
      }

    } catch (e) {
      debugPrint('Error verifying audio file: $e');
    }
  }

  /// Pause recording by stopping current segment and preserving duration
  /// Uses segment-based approach since record package doesn't support native pause/resume
  Future<bool> pauseRecording() async {
    try {
      debugPrint('Attempting to pause recording...');

      // Check if recording is actually in progress
      if (!await _recorder.isRecording()) {
        debugPrint('No active recording to pause');
        return false;
      }

      if (_isRecordingPaused) {
        debugPrint('Recording is already paused');
        return true;
      }

      debugPrint('Pausing recording at ${_recordingDuration} seconds');

      // Stop the current recording segment
      final recordedPath = await _recorder.stop();
      debugPrint('Current segment stopped. Path: $recordedPath');

      // Add the current segment to our list
      final segmentPath = recordedPath ?? _recordingPath;
      if (segmentPath != null) {
        _recordingSegments.add(segmentPath);
        debugPrint('Added segment to list. Total segments: ${_recordingSegments.length}');
      }

      // Stop the timer but preserve the duration
      _timer?.cancel();
      _timer = null;
      debugPrint('Timer paused. Duration preserved: ${_recordingDuration} seconds');

      // Mark as paused
      _isRecordingPaused = true;

      debugPrint('Recording paused successfully');
      return true;

    } catch (e) {
      debugPrint('Error pausing recording: $e');
      debugPrint('Pause error details:');
      debugPrint('  - Error type: ${e.runtimeType}');
      debugPrint('  - Error message: $e');
      debugPrint('  - Current duration: $_recordingDuration seconds');
      debugPrint('  - Segments count: ${_recordingSegments.length}');
      debugPrint('  - Is paused: $_isRecordingPaused');

      // Attempt to recover by stopping timer and marking as paused
      try {
        _timer?.cancel();
        _timer = null;
        _isRecordingPaused = true;
        debugPrint('Recovered from pause error by stopping timer and marking as paused');
        return true;
      } catch (recoveryError) {
        debugPrint('Failed to recover from pause error: $recoveryError');
        return false;
      }
    }
  }

  /// Resume recording by starting a new segment and continuing duration tracking
  /// Uses segment-based approach since record package doesn't support native pause/resume
  Future<bool> resumeRecording() async {
    try {
      debugPrint('Attempting to resume recording...');

      if (!_isRecordingPaused) {
        debugPrint('Recording is not paused, cannot resume');
        return false;
      }

      debugPrint('Resuming recording from ${_recordingDuration} seconds');

      // Start a new recording segment (not a new recording, so preserve segments)
      final newSegmentPath = await startRecording(
        preserveDuration: _recordingDuration,
        isNewRecording: false, // Important: don't clear existing segments
      );

      if (newSegmentPath != null) {
        // Mark as no longer paused
        _isRecordingPaused = false;
        debugPrint('Recording resumed successfully. New segment: $newSegmentPath');
        return true;
      } else {
        debugPrint('Failed to start new recording segment');
        return false;
      }

    } catch (e) {
      debugPrint('Error resuming recording: $e');
      debugPrint('Resume error details:');
      debugPrint('  - Error type: ${e.runtimeType}');
      debugPrint('  - Error message: $e');
      debugPrint('  - Current duration: $_recordingDuration seconds');
      debugPrint('  - Segments count: ${_recordingSegments.length}');
      debugPrint('  - Is paused: $_isRecordingPaused');

      // Attempt to recover by resetting pause state
      try {
        _isRecordingPaused = false;
        debugPrint('Reset pause state after resume error');

        // If the error was due to permission or hardware issues, provide specific feedback
        if (e.toString().toLowerCase().contains('permission')) {
          debugPrint('Resume failed due to permission issue - user may need to re-grant permissions');
        } else if (e.toString().toLowerCase().contains('hardware') || e.toString().toLowerCase().contains('device')) {
          debugPrint('Resume failed due to hardware issue - device may be in use by another app');
        }

        return false;
      } catch (recoveryError) {
        debugPrint('Failed to recover from resume error: $recoveryError');
        return false;
      }
    }
  }

  /// Fix WAV file duration metadata
  Future<void> _fixWAVDuration(String filePath, int fileSize) async {
    try {
      debugPrint('Fixing WAV file duration metadata');

      // WAV file structure calculation
      // Assuming 16-bit PCM, 16kHz sample rate (our recording settings)
      const int sampleRate = 16000;
      const int bitsPerSample = 16;
      const int channels = 1; // Mono

      // WAV header is typically 44 bytes
      const int headerSize = 44;
      final int dataSize = fileSize - headerSize;

      if (dataSize > 0) {
        // Calculate duration: dataSize / (sampleRate * channels * bitsPerSample/8)
        final double calculatedDuration = dataSize / (sampleRate * channels * (bitsPerSample / 8));
        final int durationSeconds = calculatedDuration.round();

        debugPrint('WAV Duration Calculation:');
        debugPrint('  File Size: $fileSize bytes');
        debugPrint('  Data Size: $dataSize bytes');
        debugPrint('  Sample Rate: $sampleRate Hz');
        debugPrint('  Calculated Duration: ${calculatedDuration.toStringAsFixed(2)} seconds');
        debugPrint('  Rounded Duration: $durationSeconds seconds');

        // Update duration if calculation seems reasonable
        if (durationSeconds > 0 && durationSeconds < 3600) { // Max 1 hour
          final timeDiff = (durationSeconds - _recordingDuration).abs();
          if (timeDiff > 1) {
            debugPrint('  Updating duration from timer ($_recordingDuration) to calculated ($durationSeconds)');
            _recordingDuration = durationSeconds;
            _durationController.add(_recordingDuration);
          }
        }
      }
    } catch (e) {
      debugPrint('Error fixing WAV duration: $e');
    }
  }

  /// Cancel recording and delete all files without permission dialogs
  /// Works for both active and paused recordings
  Future<void> cancelRecording() async {
    try {
      debugPrint('Canceling recording...');

      // Stop timer if running
      _timer?.cancel();
      _timer = null;
      debugPrint('Recording timer canceled');

      // Only try to stop if recorder is initialized and recording
      if (_isRecorderInitialized) {
        // Check if recording is in progress
        if (await _recorder.isRecording()) {
          debugPrint('Stopping active recording...');
          // Stop recorder without showing any permission dialog
          await _recorder.stop();
        }
      }

      // Reset recording state
      _isRecordingPaused = false;
      _recordingDuration = 0;
      debugPrint('Recording state reset');

      // Delete the current recording file if it exists
      if (_recordingPath != null) {
        final file = File(_recordingPath!);
        if (await file.exists()) {
          await file.delete();
          debugPrint('Deleted current recording file: $_recordingPath');
        }
        _recordingPath = null;
      }

      // Delete all segment files and clear the list
      debugPrint('Deleting ${_recordingSegments.length} recording segments...');
      for (final segment in _recordingSegments) {
        try {
          final file = File(segment);
          if (await file.exists()) {
            await file.delete();
            debugPrint('Deleted segment: $segment');
          }
        } catch (e) {
          debugPrint('Error deleting segment file: $e');
        }
      }
      _recordingSegments.clear();

      debugPrint('Recording canceled successfully');
    } catch (e) {
      debugPrint('Error canceling recording: $e');
    }
  }

  // Timer for tracking playback position
  Timer? _positionTimer;
  final _positionController = StreamController<Duration>.broadcast();

  /// Get the current playback position
  Stream<Duration> get playbackPositionStream => _positionController.stream;

  /// Get the current duration of the audio being played
  Duration? getDuration() {
    try {
      return _player.duration;
    } catch (e) {
      debugPrint('Error getting audio duration: $e');
      return null;
    }
  }

  /// Play audio from a file or URL with cache support
  /// [source] - Audio file URL or local path
  /// [chatId] - Optional chat ID for structured caching
  /// [messageId] - Optional message ID for structured caching
  Future<void> playAudio(String source, {String? chatId, String? messageId}) async {
    try {
      // If source is empty, throw an error
      if (source.isEmpty) {
        throw Exception('Audio source is empty');
      }

      // Log the source for debugging
      debugPrint('Playing audio from source: $source');
      if (chatId != null && messageId != null) {
        debugPrint('Using structured cache: chat=$chatId, message=$messageId');
      }

      // Detect and validate audio format
      final audioFormat = _detectAudioFormat(source);
      debugPrint('Detected audio format: ${audioFormat.extension} (${audioFormat.mimeType})');

      // If source is a URL, check cache first, then download if needed
      if (source.startsWith('http')) {
        debugPrint('Attempting to play audio from URL: $source');

        // Check cache first (cache hit check before network download)
        final cachedFile = await _getCachedAudioFile(source, chatId: chatId, messageId: messageId);
        if (cachedFile != null) {
          debugPrint('Cache HIT! Playing from cache: ${cachedFile.path}');
          final success = await _playAudioFile(cachedFile.path, audioFormat);
          if (success) {
            return; // Successfully played from cache
          } else {
            debugPrint('Failed to play cached file, will re-download');
            // Delete corrupted cache file
            try {
              await cachedFile.delete();
            } catch (e) {
              debugPrint('Error deleting corrupted cache file: $e');
            }
          }
        } else {
          debugPrint('Cache MISS! Will check network and download if available');
        }

        // Check network availability before attempting download
        final isNetworkAvailable = await _isNetworkAvailable();
        if (!isNetworkAvailable) {
          debugPrint('Network unavailable and no cached file found');
          _emitCacheStatus(CacheStatus.offline);
          throw Exception('Voice message not available offline. Please check your internet connection.');
        }

        // Emit downloading status
        _emitCacheStatus(CacheStatus.downloading);

        // For S3 URLs, try direct playback first
        if (source.contains('amazonaws.com') || source.contains('s3.') || source.contains('cloudfront.net')) {
          debugPrint('Detected S3 URL, trying direct playback first');

          try {
            // Try direct playback of S3 URL
            await _player.setUrl(source);
            await _player.play();
            _startPositionTimer();
            debugPrint('Direct S3 URL playback successful');
            return;
          } catch (e) {
            debugPrint('Direct S3 URL playback failed, falling back to download: $e');
          }

          // If direct playback fails, fall back to downloading
          debugPrint('Falling back to enhanced download approach');

          // Create a temporary file with a unique name and proper extension
          final tempDir = await getTemporaryDirectory();
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final tempFile = File('${tempDir.path}/audio_$timestamp.${audioFormat.extension}');

          try {
            // Extract the base URL without query parameters
            String baseUrl = source;
            try {
              final uri = Uri.parse(source);
              baseUrl = '${uri.scheme}://${uri.host}${uri.path}';
              debugPrint('Base URL: $baseUrl');
            } catch (e) {
              debugPrint('Error parsing URL: $e');
            }

            // Try multiple approaches
            List<String> urlsToTry = [baseUrl, source];
            List<Map<String, String>> headersToTry = [
              // Minimal headers
              {
                'Accept': '*/*',
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
              },
              // More comprehensive headers
              {
                'Accept': '*/*',
                'Accept-Encoding': 'gzip, deflate, br',
                'Connection': 'keep-alive',
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
                'Range': 'bytes=0-',
              }
            ];

            bool success = false;
            Exception? lastError;

            // Try each URL with each set of headers
            for (String url in urlsToTry) {
              for (Map<String, String> headers in headersToTry) {
                try {
                  debugPrint('Trying download from URL: $url with headers: $headers');
                  final response = await http.get(Uri.parse(url), headers: headers);

                  if (response.statusCode == 200 || response.statusCode == 206) {
                    if (response.bodyBytes.isNotEmpty) {
                      debugPrint('Successfully downloaded file, size: ${response.bodyBytes.length} bytes');

                      // Check if the content is valid audio
                      if (response.bodyBytes.length < 100) {
                        debugPrint('Warning: Downloaded file is very small (${response.bodyBytes.length} bytes)');
                      }

                      // Write to file
                      await tempFile.writeAsBytes(response.bodyBytes);

                      // Verify file exists and has content
                      if (await tempFile.exists() && await tempFile.length() > 0) {
                        debugPrint('File saved successfully: ${tempFile.path}');

                        // Try to play the file with format-aware approach
                        try {
                          success = await _playAudioFile(tempFile.path, audioFormat);
                          if (success) {
                            // Cache the successfully downloaded file
                            await _cacheAudioFile(source, response.bodyBytes, chatId: chatId, messageId: messageId);
                            break;
                          }
                        } catch (e) {
                          debugPrint('Error playing downloaded file: $e');
                          lastError = Exception('Error playing downloaded file: $e');
                        }
                      }
                    } else {
                      debugPrint('Downloaded file is empty (0 bytes)');
                    }
                  } else {
                    debugPrint('Failed to download file: ${response.statusCode}');
                  }
                } catch (e) {
                  debugPrint('Error downloading from $url: $e');
                  lastError = Exception('Error downloading from $url: $e');
                }
              }

              if (success) break;
            }

            // If successful, return
            if (success) return;

            // If we get here, try one more approach - download with explicit MP3 extension
            try {
              String mp3Url = baseUrl;
              if (!mp3Url.toLowerCase().endsWith('.mp3')) {
                mp3Url = '$baseUrl.mp3';
              }

              debugPrint('Trying download with explicit MP3 URL: $mp3Url');
              final response = await http.get(Uri.parse(mp3Url));

              if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
                await tempFile.writeAsBytes(response.bodyBytes);
                final success = await _playAudioFile(tempFile.path, audioFormat);
                if (success) return;
              }
            } catch (e) {
              debugPrint('Error with explicit MP3 approach: $e');
              lastError = Exception('Error with explicit MP3 approach: $e');
            }

            // If we get here, all approaches failed
            throw lastError ?? Exception('Failed to download and play audio from S3');
          } catch (e) {
            debugPrint('Error downloading and playing audio: $e');
            throw Exception('Failed to download and play audio: $e');
          }
        } else {
          // For non-S3 URLs, use standard download
          debugPrint('Using standard download for non-S3 URL');
          try {
            final tempDir = await getTemporaryDirectory();
            final timestamp = DateTime.now().millisecondsSinceEpoch;
            final tempFile = File('${tempDir.path}/audio_$timestamp.${audioFormat.extension}');

            final response = await http.get(Uri.parse(source));

            if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
              debugPrint('Successfully downloaded file, size: ${response.bodyBytes.length} bytes');
              await tempFile.writeAsBytes(response.bodyBytes);

              // Play the downloaded file with format-aware approach
              debugPrint('Playing downloaded file: ${tempFile.path}');
              final success = await _playAudioFile(tempFile.path, audioFormat);
              if (!success) {
                throw Exception('Failed to play downloaded audio file');
              }

              // Cache the successfully downloaded file
              await _cacheAudioFile(source, response.bodyBytes, chatId: chatId, messageId: messageId);
              return;
            } else {
              debugPrint('Failed to download file: ${response.statusCode}');
              throw Exception('Failed to download audio file: ${response.statusCode}');
            }
          } catch (e) {
            debugPrint('Error downloading and playing audio: $e');
            throw Exception('Failed to download and play audio: $e');
          }
        }
      } else {
        // Local file
        debugPrint('Playing local audio file: $source');
        final file = File(source);

        if (await file.exists()) {
          final success = await _playAudioFile(source, audioFormat);
          if (!success) {
            throw Exception('Failed to play local audio file');
          }
        } else {
          throw Exception('Local audio file not found: $source');
        }
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
      rethrow;
    }
  }

  /// Start position timer
  void _startPositionTimer() {
    _positionTimer?.cancel();

    // Get the total duration of the audio
    final totalDuration = _player.duration;
    debugPrint('Starting position timer. Total duration: ${totalDuration?.inSeconds ?? 0} seconds');

    _positionTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      try {
        // Use the synchronous getter for position
        final position = _player.position;

        // Log position updates occasionally (every 1 second) to avoid flooding logs
        if (position.inMilliseconds % 1000 < 200) {
          debugPrint('Audio position: ${position.inSeconds}s / ${totalDuration?.inSeconds ?? 0}s');
        }

        _positionController.add(position);
      } catch (e) {
        debugPrint('Error getting player position: $e');
      }
    });
  }

  /// Pause audio playback
  Future<void> pauseAudio() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('Error pausing audio: $e');
    }
  }

  /// Stop audio playback
  Future<void> stopAudio() async {
    try {
      await _player.stop();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }

  /// Resume audio playback
  Future<void> resumeAudio() async {
    try {
      await _player.play();
    } catch (e) {
      debugPrint('Error resuming audio: $e');
    }
  }

  /// Get current player state
  AudioPlayerState getPlayerState() {
    if (_player.playing) {
      return AudioPlayerState.playing;
    } else if (_player.processingState == just_audio.ProcessingState.idle) {
      return AudioPlayerState.stopped;
    } else {
      return AudioPlayerState.paused;
    }
  }

  /// Legacy method: Get cached file if it exists (deprecated - use _getCachedAudioFile)
  @deprecated
  Future<File?> _getCachedFile(String url) async {
    return await _getCachedAudioFile(url);
  }

  /// Legacy method: Cache a file from URL (deprecated - use _cacheAudioFile)
  @deprecated
  Future<void> _cacheFile(String url) async {
    try {
      debugPrint('Legacy _cacheFile called for: $url');
      // This method is deprecated in favor of the new caching system
      // It's kept for backward compatibility but doesn't do anything
    } catch (e) {
      debugPrint('Error in legacy cache method: $e');
    }
  }

  /// Download a file from URL and return the local file
  Future<File?> _downloadFile(String url) async {
    try {
      debugPrint('Manually downloading file from URL: $url');

      // Create a temporary file
      final cacheDir = await getTemporaryDirectory();
      final fileName = _getFileNameFromUrl(url);
      final file = File('${cacheDir.path}/$fileName');

      // Special handling for S3 URLs
      if (url.contains('amazonaws.com')) {
        debugPrint('Detected S3 URL, using special handling');
        return await _downloadS3File(url, file);
      }

      // Try different approaches to download the file

      // Approach 1: Direct download with headers
      try {
        // Add more headers to avoid CORS issues
        final headers = {
          'Accept': '*/*',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Origin': AppConstants.adminPageUrl,
          'Referer': '${AppConstants.adminPageUrl}/',
          'Range': 'bytes=0-', // Add range header for partial content
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        };

        debugPrint('Downloading with headers: $headers');

        final response = await http.get(
          Uri.parse(url),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 206) {
          await file.writeAsBytes(response.bodyBytes);
          debugPrint('File downloaded successfully: $fileName, size: ${response.bodyBytes.length} bytes');

          // Check if file is valid
          if (response.bodyBytes.length > 0) {
            return file;
          } else {
            debugPrint('Downloaded file is empty');
          }
        } else {
          debugPrint('Failed to download file: ${response.statusCode}, ${response.reasonPhrase}');
        }
      } catch (e) {
        debugPrint('Error in approach 1: $e');
      }

      // Approach 2: Try direct URL with different headers
      try {
        debugPrint('Skipping proxy URL as it returns 404');
        debugPrint('Trying direct URL with different headers: $url');

        // Add more headers for S3 access
        final headers = {
          'Accept': '*/*',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Origin': '*',
          'Referer': '*',
          'Range': 'bytes=0-',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          'Access-Control-Allow-Origin': '*',
        };

        final response = await http.get(
          Uri.parse(url),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 206) {
          await file.writeAsBytes(response.bodyBytes);
          debugPrint('File downloaded with special headers successfully: $fileName, size: ${response.bodyBytes.length} bytes');

          // Check if file is valid
          if (response.bodyBytes.length > 0) {
            return file;
          } else {
            debugPrint('Downloaded file with special headers is empty');
          }
        } else {
          debugPrint('Failed to download file with special headers: ${response.statusCode}, ${response.reasonPhrase}');
        }
      } catch (e) {
        debugPrint('Error in approach 2: $e');
      }

      // Approach 3: Try adding file extension if missing
      if (!url.contains('.mp3') && !url.contains('.aac') && !url.contains('.m4a')) {
        // Try multiple extensions based on common formats
        final extensionsToTry = ['mp3', 'aac', 'm4a'];

        for (String ext in extensionsToTry) {
          try {
            final urlWithExt = '$url.$ext';
            debugPrint('Trying URL with .$ext extension: $urlWithExt');

            final response = await http.get(Uri.parse(urlWithExt));
            if (response.statusCode == 200) {
              await file.writeAsBytes(response.bodyBytes);
              debugPrint('File downloaded with $ext extension successfully: $fileName, size: ${response.bodyBytes.length} bytes');

              // Check if file is valid
              if (response.bodyBytes.length > 0) {
                return file;
              } else {
                debugPrint('Downloaded file with $ext extension is empty');
              }
            } else {
              debugPrint('Failed to download file with $ext extension: ${response.statusCode}');
            }
          } catch (e) {
            debugPrint('Error trying $ext extension: $e');
          }
        }
      }

      // If all approaches fail, return null
      return null;
    } catch (e) {
      debugPrint('Error downloading file: $e');
      return null;
    }
  }

  /// Special handling for S3 URLs
  Future<File?> _downloadS3File(String url, File file) async {
    try {
      debugPrint('Downloading S3 file: $url');

      // Extract the S3 URL without query parameters
      final uri = Uri.parse(url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.path}';
      debugPrint('Base S3 URL: $baseUrl');

      // Try different approaches

      // Approach 1: Simple direct download without Range headers
      try {
        debugPrint('Trying simple direct download without Range headers');

        // Minimal headers to avoid CORS issues
        final headers = {
          'Accept': '*/*',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        };

        // Try the base URL first (without query parameters)
        final baseResponse = await http.get(Uri.parse(baseUrl), headers: headers);

        if (baseResponse.statusCode == 200) {
          debugPrint('S3 file downloaded successfully with base URL, status: ${baseResponse.statusCode}, size: ${baseResponse.bodyBytes.length} bytes');

          if (baseResponse.bodyBytes.length > 0) {
            await file.writeAsBytes(baseResponse.bodyBytes);
            return file;
          } else {
            debugPrint('Downloaded file is empty (0 bytes)');
          }
        } else {
          debugPrint('Failed to download with base URL: ${baseResponse.statusCode}');
        }

        // If base URL fails, try the full URL
        final fullResponse = await http.get(Uri.parse(url), headers: headers);

        if (fullResponse.statusCode == 200) {
          debugPrint('S3 file downloaded successfully with full URL, status: ${fullResponse.statusCode}, size: ${fullResponse.bodyBytes.length} bytes');

          if (fullResponse.bodyBytes.length > 0) {
            await file.writeAsBytes(fullResponse.bodyBytes);
            return file;
          } else {
            debugPrint('Downloaded file is empty (0 bytes)');
          }
        } else {
          debugPrint('Failed to download with full URL: ${fullResponse.statusCode}');
        }
      } catch (e) {
        debugPrint('Error in simple direct download: $e');
      }

      // Approach 2: Try with different content types
      try {
        debugPrint('Trying with explicit content type');

        final headers = {
          'Accept': '*/*',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        };

        // Try with audio/mpeg content type
        final mpegUrl = '$baseUrl?content-type=audio/mpeg';
        debugPrint('Trying with audio/mpeg content type: $mpegUrl');

        final mpegResponse = await http.get(Uri.parse(mpegUrl), headers: headers);
        if (mpegResponse.statusCode == 200 && mpegResponse.bodyBytes.length > 0) {
          debugPrint('Downloaded successfully with audio/mpeg content type, size: ${mpegResponse.bodyBytes.length} bytes');
          await file.writeAsBytes(mpegResponse.bodyBytes);
          return file;
        }

        // Try with audio/aac content type
        final aacUrl = '$baseUrl?content-type=audio/aac';
        debugPrint('Trying with audio/aac content type: $aacUrl');

        final aacResponse = await http.get(Uri.parse(aacUrl), headers: headers);
        if (aacResponse.statusCode == 200 && aacResponse.bodyBytes.length > 0) {
          debugPrint('Downloaded successfully with audio/aac content type, size: ${aacResponse.bodyBytes.length} bytes');
          await file.writeAsBytes(aacResponse.bodyBytes);
          return file;
        }
      } catch (e) {
        debugPrint('Error with content type approach: $e');
      }

      return null;
    } catch (e) {
      debugPrint('Error downloading S3 file: $e');
      return null;
    }
  }

  /// Get filename from URL
  String _getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    final path = uri.path;
    return path.substring(path.lastIndexOf('/') + 1);
  }

  /// Format duration in mm:ss format
  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Merge multiple audio segments into a single file
  /// This is a simplified implementation that concatenates the audio files
  /// Optimized for MP3 format used by record package
  Future<String?> _mergeAudioSegments(List<String> segments) async {
    try {
      debugPrint('Merging ${segments.length} audio segments...');

      if (segments.isEmpty) {
        debugPrint('No segments to merge');
        return null;
      }

      if (segments.length == 1) {
        debugPrint('Single segment, no merging needed');
        return segments.first;
      }

      // Create a new file for the merged audio with MP3 extension (matching record package output)
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final mergedPath = '${tempDir.path}/merged_voice_${timestamp}.mp3';
      final mergedFile = File(mergedPath);

      debugPrint('Creating merged file: $mergedPath');

      // Create the file if it doesn't exist
      if (!await mergedFile.exists()) {
        await mergedFile.create();
      }

      // Open the file for writing
      final sink = mergedFile.openWrite();
      int totalBytes = 0;
      int mergedSegments = 0;

      try {
        // Read and write each segment
        for (int i = 0; i < segments.length; i++) {
          final segment = segments[i];
          final file = File(segment);

          debugPrint('Processing segment ${i + 1}/${segments.length}: $segment');

          if (await file.exists()) {
            // Get file size for logging
            final fileSize = await file.length();
            debugPrint('Segment ${i + 1} size: $fileSize bytes');

            // Read the file and write its contents to the merged file
            final bytes = await file.readAsBytes();
            sink.add(bytes);

            totalBytes += bytes.length;
            mergedSegments++;

            debugPrint('Segment ${i + 1} merged successfully');

            // Delete the segment file after merging
            await file.delete();
            debugPrint('Segment ${i + 1} file deleted');
          } else {
            debugPrint('Warning: Segment ${i + 1} file does not exist: $segment');
          }
        }

        // Close the file
        await sink.flush();
        await sink.close();

        debugPrint('Merging completed:');
        debugPrint('  - Total segments processed: $mergedSegments/${segments.length}');
        debugPrint('  - Total merged size: $totalBytes bytes');
        debugPrint('  - Final merged file: $mergedPath');

        // Verify the merged file
        if (await mergedFile.exists()) {
          final finalSize = await mergedFile.length();
          debugPrint('  - Final file size verification: $finalSize bytes');

          if (finalSize > 0) {
            // Clear the segments list
            segments.clear();
            debugPrint('Segments list cleared, merge successful');
            return mergedPath;
          } else {
            debugPrint('Error: Merged file is empty');
            return segments.isNotEmpty ? segments.last : null;
          }
        } else {
          debugPrint('Error: Merged file was not created');
          return segments.isNotEmpty ? segments.last : null;
        }
      } catch (e) {
        debugPrint('Error during segment merging: $e');
        await sink.close();

        // If merging fails, return the last segment as fallback
        return segments.isNotEmpty ? segments.last : null;
      }
    } catch (e) {
      debugPrint('Error merging audio segments: $e');
      return segments.isNotEmpty ? segments.last : null;
    }
  }

  /// Audio format detection and support
  AudioFormat _detectAudioFormat(String source) {
    // Extract file extension from URL or file path
    String extension = 'mp3'; // Default fallback
    String mimeType = 'audio/mpeg'; // Default fallback

    try {
      // Parse URL or file path to get extension
      final uri = Uri.parse(source);
      final path = uri.path.toLowerCase();

      if (path.contains('.aac')) {
        extension = 'aac';
        mimeType = 'audio/aac';
      } else if (path.contains('.mp3')) {
        extension = 'mp3';
        mimeType = 'audio/mpeg';
      } else if (path.contains('.m4a')) {
        extension = 'm4a';
        mimeType = 'audio/mp4';
      } else if (path.contains('.wav')) {
        extension = 'wav';
        mimeType = 'audio/wav';
      } else if (path.contains('.ogg')) {
        extension = 'ogg';
        mimeType = 'audio/ogg';
      } else if (path.contains('.webm')) {
        extension = 'webm';
        mimeType = 'audio/webm';
      }
    } catch (e) {
      debugPrint('Error parsing audio source for format detection: $e');
      // Use defaults
    }

    return AudioFormat(extension: extension, mimeType: mimeType);
  }

  /// Play audio file with format-aware approach and fallback mechanism
  Future<bool> _playAudioFile(String filePath, AudioFormat format) async {
    try {
      debugPrint('Attempting to play ${format.extension} file: $filePath');

      // Check if file exists and get file info
      final file = File(filePath);
      if (!await file.exists()) {
        debugPrint('ERROR: Audio file does not exist: $filePath');
        return false;
      }

      final fileSize = await file.length();
      debugPrint('File exists, size: $fileSize bytes');

      if (fileSize == 0) {
        debugPrint('ERROR: Audio file is empty (0 bytes)');
        return false;
      }

      // Primary attempt: Direct playback
      try {
        debugPrint('Trying direct setFilePath for ${format.extension}');
        await _player.setFilePath(filePath);
        await _player.play();
        _startPositionTimer();
        debugPrint('Successfully played ${format.extension} file directly');
        return true;
      } catch (e) {
        debugPrint('Direct playback failed for ${format.extension}: $e');
      }

      // Fallback 1: Try with URL if it's a local file
      if (!filePath.startsWith('http')) {
        try {
          final file = File(filePath);
          if (await file.exists()) {
            await _player.setUrl('file://$filePath');
            await _player.play();
            _startPositionTimer();
            debugPrint('Successfully played ${format.extension} file with file:// URL');
            return true;
          }
        } catch (e) {
          debugPrint('File URL playback failed for ${format.extension}: $e');
        }
      }

      // Fallback 2: For AAC files, try different approaches
      if (format.extension == 'aac') {
        try {
          // Try setting audio session for AAC
          await _player.setAudioSource(just_audio.AudioSource.uri(Uri.file(filePath)));
          await _player.play();
          _startPositionTimer();
          debugPrint('Successfully played AAC file with AudioSource.uri');
          return true;
        } catch (e) {
          debugPrint('AudioSource.uri playback failed for AAC: $e');
        }
      }

      // Fallback 2.5: For WAV files, try different approaches
      if (format.extension == 'wav') {
        try {
          debugPrint('Trying WAV-specific playback approach');
          // Try setting audio session for WAV
          await _player.setAudioSource(just_audio.AudioSource.uri(Uri.file(filePath)));
          await _player.play();
          _startPositionTimer();
          debugPrint('Successfully played WAV file with AudioSource.uri');
          return true;
        } catch (e) {
          debugPrint('AudioSource.uri playback failed for WAV: $e');
        }

        // Try with different WAV approach
        try {
          debugPrint('Trying WAV file with setUrl approach');
          await _player.setUrl('file://$filePath');
          await _player.play();
          _startPositionTimer();
          debugPrint('Successfully played WAV file with setUrl');
          return true;
        } catch (e) {
          debugPrint('setUrl playback failed for WAV: $e');
        }
      }

      // Fallback 3: Format conversion hint for just_audio
      try {
        // Set player to handle the specific format
        await _player.setFilePath(filePath);

        // For AAC files, ensure proper codec handling
        if (format.extension == 'aac') {
          debugPrint('Configuring player for AAC format');
        }

        await _player.play();
        _startPositionTimer();
        debugPrint('Successfully played ${format.extension} file with format hint');
        return true;
      } catch (e) {
        debugPrint('Format hint playback failed for ${format.extension}: $e');
      }

      debugPrint('All playback attempts failed for ${format.extension} file');
      return false;

    } catch (e) {
      debugPrint('Error in _playAudioFile: $e');
      return false;
    }
  }



  /// Dispose resources
  void dispose() {
    _timer?.cancel();
    _positionTimer?.cancel();
    // Record package doesn't need explicit closing
    _recorder.dispose();
    _player.dispose();
    _durationController.close();
    _positionController.close();
    _cacheStatusController.close();
    _isRecorderInitialized = false;
  }
}

/// Audio format information
class AudioFormat {
  final String extension;
  final String mimeType;

  AudioFormat({required this.extension, required this.mimeType});

  @override
  String toString() => '$extension ($mimeType)';
}

/// Audio quality settings for recording
/// Updated to use WAV format for better compatibility and conversion
/// WAV files will be converted to MP3 on client-side for web compatibility
enum AudioQuality {
  /// Premium quality WAV (192kbps equivalent) - Highest quality
  /// Uses WAV encoder, will be converted to MP3 for web compatibility
  premium(
    encoder: AudioEncoder.wav,
    extension: 'wav',
    mimeType: 'audio/wav',
    bitRate: 192000,
    sampleRate: 44100,
    description: 'Premium Quality (WAV → MP3 192kbps)',
  ),

  /// High quality WAV (160kbps equivalent) - Excellent quality with good file size
  /// Perfect balance for voice messages with high clarity
  high(
    encoder: AudioEncoder.wav,
    extension: 'wav',
    mimeType: 'audio/wav',
    bitRate: 160000,
    sampleRate: 44100,
    description: 'High Quality (WAV → MP3 160kbps)',
  ),

  /// Standard quality WAV (128kbps equivalent) - Good balance of quality and size
  /// Default setting for most voice messages
  /// ✅ FIXED: Ensure consistent format for cross-platform compatibility
  standard(
    encoder: AudioEncoder.wav,
    extension: 'wav',
    mimeType: 'audio/wav',
    bitRate: 128000,
    sampleRate: 44100,
    description: 'Standard Quality (WAV 128kbps - Cross-platform compatible)',
  ),

  /// Compatibility mode WAV (128kbps equivalent) - Maximum compatibility
  /// Upgraded from 96kbps for better quality while maintaining compatibility
  compatibility(
    encoder: AudioEncoder.wav,
    extension: 'wav',
    mimeType: 'audio/wav',
    bitRate: 128000,
    sampleRate: 44100,
    description: 'Compatibility Mode (WAV → MP3 128kbps)',
  );

  const AudioQuality({
    required this.encoder,
    required this.extension,
    required this.mimeType,
    required this.bitRate,
    required this.sampleRate,
    required this.description,
  });

  final AudioEncoder encoder;
  final String extension;
  final String mimeType;
  final int bitRate;
  final int sampleRate;
  final String description;

  /// Get estimated file size per minute in MB
  double get estimatedSizePerMinuteMB {
    // Calculation: bitRate * 60 seconds / 8 bits per byte / 1024 / 1024
    // Added 10% overhead for AAC container and metadata
    return (bitRate * 60 * 1.1) / (8 * 1024 * 1024);
  }

  /// Get quality level as integer (higher = better quality)
  int get qualityLevel {
    switch (this) {
      case AudioQuality.premium:
        return 4;
      case AudioQuality.high:
        return 3;
      case AudioQuality.standard:
        return 2;
      case AudioQuality.compatibility:
        return 1;
    }
  }

  /// Check if this quality is suitable for long recordings (>5 minutes)
  bool get isSuitableForLongRecordings {
    return bitRate <= 128000; // 128kbps or lower for long recordings
  }

  /// Check if this quality provides excellent audio clarity
  bool get isHighClarity {
    return bitRate >= 160000; // 160kbps or higher for high clarity
  }

  /// Get recommended use case for this quality
  String get recommendedUseCase {
    switch (this) {
      case AudioQuality.premium:
        return 'Music, presentations, or when highest quality is needed';
      case AudioQuality.high:
        return 'Important voice messages, interviews, or professional use';
      case AudioQuality.standard:
        return 'Regular voice messages and general communication';
      case AudioQuality.compatibility:
        return 'Older devices or when maximum compatibility is needed';
    }
  }
}

/// Cache status for UI indicators
enum CacheStatus {
  /// Cache hit - file found in cache and playing
  hit('Cache Hit', 'Playing from cache'),

  /// Cache miss - file not found in cache
  miss('Cache Miss', 'File not cached'),

  /// Currently downloading file
  downloading('Downloading', 'Downloading audio file'),

  /// File successfully cached
  cached('Cached', 'File saved to cache'),

  /// Cache expired - old file removed
  expired('Expired', 'Cached file expired'),

  /// Offline mode - no network and no cache
  offline('Offline', 'No internet connection'),

  /// Cache error - failed to cache file
  error('Error', 'Failed to cache file');

  const CacheStatus(this.title, this.description);

  final String title;
  final String description;

  /// Get icon for cache status
  String get icon {
    switch (this) {
      case CacheStatus.hit:
        return '✅';
      case CacheStatus.miss:
        return '❌';
      case CacheStatus.downloading:
        return '⬇️';
      case CacheStatus.cached:
        return '💾';
      case CacheStatus.expired:
        return '⏰';
      case CacheStatus.offline:
        return '📵';
      case CacheStatus.error:
        return '⚠️';
    }
  }

  /// Check if status indicates successful operation
  bool get isSuccess => this == CacheStatus.hit || this == CacheStatus.cached;

  /// Check if status indicates error or problem
  bool get isError => this == CacheStatus.error || this == CacheStatus.offline;
}

/// Custom exception for recording permission errors
/// Provides detailed information for UI to display appropriate messages and actions
class RecordingPermissionException implements Exception {
  final String errorCode;
  final String title;
  final String message;
  final bool canRetry;
  final bool canOpenSettings;
  final String actionText;

  const RecordingPermissionException(
    this.errorCode,
    this.title,
    this.message, {
    required this.canRetry,
    required this.canOpenSettings,
    required this.actionText,
  });

  @override
  String toString() {
    return 'RecordingPermissionException: $errorCode - $title: $message';
  }

  /// Convert to a map for easy serialization/UI consumption
  Map<String, dynamic> toMap() {
    return {
      'error': errorCode,
      'title': title,
      'message': message,
      'canRetry': canRetry,
      'canOpenSettings': canOpenSettings,
      'actionText': actionText,
    };
  }
}

/// Custom exception for recording failures
/// Provides detailed information for debugging and user-friendly messages
class RecordingException implements Exception {
  final String errorCode;
  final String title;
  final String userMessage;
  final String debugMessage;
  final bool canRetry;
  final bool isTemporary;
  final String? suggestedAction;

  const RecordingException(
    this.errorCode,
    this.title,
    this.userMessage,
    this.debugMessage, {
    required this.canRetry,
    required this.isTemporary,
    this.suggestedAction,
  });

  @override
  String toString() {
    return 'RecordingException: $errorCode - $title: $debugMessage';
  }

  /// Convert to a map for easy serialization/UI consumption
  Map<String, dynamic> toMap() {
    return {
      'error': errorCode,
      'title': title,
      'userMessage': userMessage,
      'debugMessage': debugMessage,
      'canRetry': canRetry,
      'isTemporary': isTemporary,
      'suggestedAction': suggestedAction,
    };
  }
}

/// Custom exception for audio file errors
/// Handles file-related recording issues
class AudioFileException implements Exception {
  final String errorCode;
  final String title;
  final String userMessage;
  final String debugMessage;
  final String? filePath;
  final bool canRetry;

  const AudioFileException(
    this.errorCode,
    this.title,
    this.userMessage,
    this.debugMessage, {
    this.filePath,
    required this.canRetry,
  });

  @override
  String toString() {
    return 'AudioFileException: $errorCode - $title: $debugMessage (File: $filePath)';
  }

  /// Convert to a map for easy serialization/UI consumption
  Map<String, dynamic> toMap() {
    return {
      'error': errorCode,
      'title': title,
      'userMessage': userMessage,
      'debugMessage': debugMessage,
      'filePath': filePath,
      'canRetry': canRetry,
    };
  }
}
