import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/message_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/audio_service.dart';

/// Helper class for voice chat functionality
/// This class is used to handle voice message operations without modifying the existing BLoC structure
class VoiceChatHelper {
  // Singleton pattern
  static final VoiceChatHelper _instance = VoiceChatHelper._internal();
  factory VoiceChatHelper() => _instance;
  VoiceChatHelper._internal();

  // Audio service for recording and playback
  final AudioService _audioService = AudioService();

  // Currently playing message ID
  String? _currentlyPlayingMessageId;

  // Global state notifier for currently playing message
  static final ValueNotifier<String?> currentlyPlayingMessageId = ValueNotifier<String?>(null);

  // Check if a specific message is currently playing
  bool isMessagePlaying(String messageId) {
    return _currentlyPlayingMessageId == messageId;
  }

  /// Send a voice message
  ///
  /// [context] - BuildContext for showing error messages
  /// [chatId] - ID of the chat to send the message to
  /// [audioPath] - Path to the recorded audio file
  /// [audioDuration] - Duration of the recording in seconds
  /// [product] - Optional product to attach to the message
  /// [onSuccess] - Callback for successful message sending
  /// [onError] - Callback for error handling
  Future<void> sendVoiceMessage({
    required BuildContext context,
    required String chatId,
    required String audioPath,
    required int audioDuration,
    ProductData? product,
    Function? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      debugPrint('Sending voice message. Chat ID: $chatId, Audio path: $audioPath, Duration: $audioDuration');

      // Verify the audio file exists
      final audioFile = File(audioPath);
      if (!await audioFile.exists()) {
        debugPrint('Audio file not found: $audioPath');
        if (onError != null) onError(AppHelpers.getTranslation(TrKeys.audioFileNotFound));
        return;
      }

      debugPrint('Audio file exists, size: ${await audioFile.length()} bytes');

      // Check if chat ID is valid
      if (chatId.isEmpty) {
        debugPrint('Chat ID is empty');
        if (onError != null) onError(AppHelpers.getTranslation(TrKeys.invalidChatId));
        return;
      }

      // Send the voice message using the repository
      debugPrint('Calling repository to send voice message');
      final res = await chatRepository.sendVoiceMessage(
        chatDocId: chatId,
        audioPath: audioPath,
        audioDuration: audioDuration,
        product: product,
      );

      res.fold((message) {
        debugPrint('Voice message sent successfully: $message');
        if (onSuccess != null) onSuccess();
      }, (error) {
        debugPrint('Error sending voice message: $error');
        if (onError != null) onError(error);
      });
    } catch (e) {
      debugPrint('Exception sending voice message: $e');
      if (onError != null) onError(e.toString());
    }
  }

  /// Play a voice message
  ///
  /// [messageId] - ID of the message to play
  /// [audioUrl] - URL or local path of the audio file to play
  Future<void> playVoiceMessage({
    required String messageId,
    required String audioUrl,
  }) async {
    try {
      debugPrint("Playing voice message: $messageId, path: $audioUrl");

      // Check if this is the same message that was paused
      if (_currentlyPlayingMessageId == messageId) {
        // This message was paused (internal ID exists)
        debugPrint("Resuming paused message: $messageId");
        final playerState = _audioService.getPlayerState();

        // Don't update UI state here - let the UI handle that

        if (playerState == AudioPlayerState.paused) {
          await _audioService.resumeAudio();
          debugPrint("Resumed paused message");
        } else {
          // If not paused, restart playback
          await _audioService.stopAudio();
          await _audioService.playAudio(audioUrl);
          debugPrint("Restarted playback for message: $messageId");
        }
        return;
      }
      // Check if this is the same message that's already playing
      else if (currentlyPlayingMessageId.value == messageId) {
        debugPrint("Message already playing: $messageId");
        return;
      }
      // If another message is playing, stop it
      else if (_currentlyPlayingMessageId != null) {
        debugPrint("Stopping previous message: $_currentlyPlayingMessageId before playing: $messageId");
        await _audioService.stopAudio();
      }

      // Update internal state before starting playback
      _currentlyPlayingMessageId = messageId;

      // Don't update UI state here - let the UI handle that
      debugPrint("Internal state updated, messageId: $messageId");

      // Check if the audio file exists locally
      if (!audioUrl.startsWith('http')) {
        final file = File(audioUrl);
        if (await file.exists()) {
          debugPrint("Playing local audio file");
          await _audioService.playAudio(audioUrl);

          // Listen for playback completion
          _audioService.playbackStateStream.listen((state) {
            if (state.processingState == ProcessingState.completed) {
              _currentlyPlayingMessageId = null;
              currentlyPlayingMessageId.value = null;
            }
          });

          return;
        } else {
          debugPrint("Local audio file not found: $audioUrl");
          throw Exception(AppHelpers.getTranslation(TrKeys.audioFileNotFound));
        }
      }

      // If it's a URL, play it normally
      await _audioService.playAudio(audioUrl);

      // Listen for playback completion
      _audioService.playbackStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _currentlyPlayingMessageId = null;
          currentlyPlayingMessageId.value = null;
        }
      });
    } catch (e) {
      debugPrint("Error playing voice message: $e");
      // Reset state on error
      _currentlyPlayingMessageId = null;
      currentlyPlayingMessageId.value = null;
    }
  }

  /// Pause the currently playing voice message
  Future<void> pauseVoiceMessage() async {
    try {
      // Pause the audio playback
      await _audioService.pauseAudio();

      // Get the current message ID from internal state
      final currentId = _currentlyPlayingMessageId;

      // Only proceed if there's a message playing internally
      if (currentId != null) {
        // Keep track of the paused message ID internally
        // Don't update UI state here - let the UI handle that

        // Verify the player state
        final playerState = _audioService.getPlayerState();
        debugPrint("Voice message $currentId paused, player state: $playerState");
      } else {
        debugPrint("No message currently playing to pause");
      }
    } catch (e) {
      debugPrint("Error pausing voice message: $e");
    }
  }

  /// Stop the currently playing voice message
  Future<void> stopVoiceMessage() async {
    try {
      // Store the current message ID for logging
      final currentId = _currentlyPlayingMessageId;

      // Stop audio playback
      await _audioService.stopAudio();

      // Clear internal state
      _currentlyPlayingMessageId = null;

      // Don't update UI state here - let the UI handle that
      debugPrint("Voice message stopped: $currentId");
    } catch (e) {
      debugPrint("Error stopping voice message: $e");
    }
  }

  /// Start recording a voice message
  /// [preserveDuration] - If provided, will preserve this duration when starting recording
  /// [isNewRecording] - If true, clears previous recording segments
  Future<String?> startRecording({int? preserveDuration, bool isNewRecording = true}) async {
    try {
      return await _audioService.startRecording(
        preserveDuration: preserveDuration,
        isNewRecording: isNewRecording,
      );
    } catch (e) {
      debugPrint("Error starting recording: $e");
      return null;
    }
  }

  /// Stop recording and return the file path
  Future<String?> stopRecording() async {
    try {
      return await _audioService.stopRecording();
    } catch (e) {
      debugPrint("Error stopping recording: $e");
      return null;
    }
  }

  /// Cancel recording and delete the file
  Future<void> cancelRecording() async {
    try {
      await _audioService.cancelRecording();
    } catch (e) {
      debugPrint("Error canceling recording: $e");
    }
  }

  /// Get the current recording duration
  Stream<int> get recordingDurationStream => _audioService.durationStream;

  /// Get the current playback position
  Stream<Duration> get playbackPositionStream =>
      _audioService.playbackPositionStream;

  /// Get the current playback state
  Stream<dynamic> get playbackStateStream => _audioService.playbackStateStream;

  /// Format duration in mm:ss format
  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Check if a message is a voice message
  bool isVoiceMessage(MessageModel message) {
    return message.type == "voice";
  }

  /// Get current player state - public method for UI
  AudioPlayerState getCurrentPlayerState() {
    return _audioService.getPlayerState();
  }

  /// Dispose resources
  void dispose() {
    _audioService.dispose();
  }
}
