import 'package:flutter/material.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:quick/presentation/pages/chat/widget/audio_waveform.dart';
import 'dart:async';

/// A widget for recording voice messages in the chat
class VoiceRecorderWidget extends StatefulWidget {
  /// Callback when recording is complete
  final Function(String audioPath, int duration) onRecordingComplete;

  /// Whether to use WhatsApp style UI
  final bool whatsAppStyle;

  /// Whether to start recording automatically when widget is initialized
  final bool autoStart;

  /// Constructor
  const VoiceRecorderWidget({
    super.key,
    required this.onRecordingComplete,
    this.whatsAppStyle = false,
    this.autoStart = false,
  });

  @override
  State<VoiceRecorderWidget> createState() => _VoiceRecorderWidgetState();
}

class _VoiceRecorderWidgetState extends State<VoiceRecorderWidget> with SingleTickerProviderStateMixin {
  final VoiceChatHelper _voiceChatHelper = VoiceChatHelper();
  bool _isRecording = false;
  bool _isPaused = false; // Track if recording is paused
  String? _currentRecordingPath;
  Timer? _pauseTimer; // Timer to track duration during pause
  int _recordingDuration = 0;

  @override
  void initState() {
    super.initState();

    // Listen to recording duration updates
    _voiceChatHelper.recordingDurationStream.listen((duration) {
      setState(() {
        _recordingDuration = duration;
      });
    });

    // Start recording automatically if autoStart is true
    if (widget.autoStart) {
      // Use a small delay to ensure the widget is fully initialized
      Future.delayed(const Duration(milliseconds: 100), () {
        _startRecording();
      });
    }
  }

  @override
  void dispose() {
    // Cancel recording if still in progress when widget is disposed
    if (_isRecording) {
      _voiceChatHelper.cancelRecording();
    }
    super.dispose();
  }

  /// Start recording a voice message
  Future<void> _startRecording() async {
    // If recording was paused, resume it
    if (_isPaused && _currentRecordingPath != null) {
      return _resumeRecording();
    }

    try {
      final path = await _voiceChatHelper.startRecording();
      if (path != null) {
        setState(() {
          _isRecording = true;
          _isPaused = false;
          _recordingDuration = 0;
          _currentRecordingPath = path;
        });
      } else {
        // Silently handle recording failure without showing any UI
        debugPrint('Failed to start recording');
      }
    } catch (e) {
      // Silently log error without showing any UI
      debugPrint('Error starting recording: $e');
    }
  }

  /// Stop recording and send the voice message
  Future<void> _stopRecording() async {
    if (!_isRecording && !_isPaused) return;

    try {
      // If recording is currently paused, use the saved path
      final path = _isPaused ? _currentRecordingPath : await _voiceChatHelper.stopRecording();
      setState(() {
        _isRecording = false;
        _isPaused = false;
      });

      if (path != null) {
        // Call onRecordingComplete callback and dismiss bottom sheet
        widget.onRecordingComplete(path, _recordingDuration);
        // Close the bottom sheet immediately after sending
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      // Silently log error without showing any UI
      debugPrint('Error stopping recording: $e');

      // Make sure to dismiss the bottom sheet even on error
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  /// Cancel recording and discard the voice message silently
  Future<void> _cancelRecording() async {
    if (!_isRecording && !_isPaused) return;

    try {
      await _voiceChatHelper.cancelRecording();
      setState(() {
        _isRecording = false;
        _isPaused = false;
        _currentRecordingPath = null;
      });

      // Close the bottom sheet when canceling
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      // Silently log error without showing any UI
      debugPrint('Error canceling recording: $e');

      // Still close the bottom sheet even on error
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  /// Pause the current recording - WhatsApp style
  Future<void> _pauseRecording() async {
    if (!_isRecording || _isPaused) return;

    try {
      // Since VoiceChatHelper doesn't have pause functionality,
      // we'll just update the UI state here while maintaining the recording UI

      // Save the current path for later continuation
      final tempPath = _currentRecordingPath;

      // Stop recording without sending
      await _voiceChatHelper.stopRecording();

      // Important: Set isPaused to true but maintain the UI
      setState(() {
        _isPaused = true;
        _isRecording = false; // Not recording but UI should still show
        _currentRecordingPath = tempPath;
      });

      // For debugging
      debugPrint('Recording paused, UI should show mic button now');
    } catch (e) {
      // Silently log error without showing any UI
      debugPrint('Error pausing recording: $e');
    }
  }

  /// Resume recording after pause - WhatsApp style
  Future<void> _resumeRecording() async {
    if (!_isPaused) return;

    try {
      // Save the current duration before starting new recording
      final currentDuration = _recordingDuration;

      // Start a new recording segment but preserve the duration
      // Pass isNewRecording=false to indicate this is a continuation
      final path = await _voiceChatHelper.startRecording(
        preserveDuration: currentDuration,
        isNewRecording: false,
      );

      if (path != null) {
        setState(() {
          _isPaused = false;
          _isRecording = true;
          _currentRecordingPath = path;
          // Duration is preserved in the VoiceChatHelper
        });

        // For debugging
        debugPrint('Recording resumed from $currentDuration seconds, UI should show pause button now');
      }
    } catch (e) {
      // Silently log error without showing any UI
      debugPrint('Error resuming recording: $e');
    }
  }

  /// Format the recording duration as mm:ss
  String _formatDuration() {
    return _voiceChatHelper.formatDuration(_recordingDuration);
  }

  /// Build audio waveform similar to WhatsApp
  Widget _buildWaveform() {
    // Get theme colors
    final waveColor = Colors.grey.shade500; // Similar to WhatsApp

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: AudioWaveform(
        durationSeconds: _recordingDuration + 30, // Add some extra duration for animation
        color: waveColor,
        barCount: 30,
        isPlaying: true, // Always "playing" during recording
        currentPosition: _recordingDuration, // Current position is the recording duration
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (_isRecording || _isPaused) ? _buildRecordingState() : _buildMicButton();
  }

  /// Build the microphone button for starting recording
  Widget _buildMicButton() {
    return IconButton(
      icon: const Icon(Icons.mic, color: Colors.white),
      onPressed: _startRecording,
      tooltip: AppHelpers.getTranslation(TrKeys.recordVoiceMessage),
    );
  }

  /// Build the recording state UI with timer and control buttons - WhatsApp style
  Widget _buildRecordingState() {
    if (widget.whatsAppStyle) {
      // Get theme colors
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final bgColor = isDark ? Colors.black : Color(0xFF1E2428); // Dark background for both themes like WhatsApp
      final textColor = Colors.white;

      return Container(
        width: double.infinity,
        color: bgColor,
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Timer and waveform row
            Row(
              children: [
                // Timer
                Text(
                  _formatDuration(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Expanded(
                  child: _buildWaveform(),
                ),

                // Animated timer indicator like WhatsApp
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade600),
                  ),
                  child: Center(
                    // Animated icon that pulses/rotates in sync with recording
                    child: AnimatedBuilder(
                      animation: AlwaysStoppedAnimation(_recordingDuration),
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: (_recordingDuration % 4) * 0.5,
                          child: Icon(Icons.autorenew, color: textColor, size: 20.r),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.r),

            // Controls row - exactly like WhatsApp UI image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Trash/Delete button (left side)
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red, size: 28.r),
                    onPressed: _cancelRecording,
                    tooltip: 'Delete recording',
                  ),
                ),

                // Center button - changes between pause and mic based on state
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red, // Red color for both pause and mic buttons
                  ),
                  child: IconButton(
                    icon: _isPaused
                      ? Icon(Icons.mic, color: Colors.white, size: 22.r) // Mic icon when paused
                      : Icon(Icons.pause, color: Colors.white, size: 22.r), // Pause icon when recording
                    onPressed: _isPaused ? _resumeRecording : _pauseRecording,
                    tooltip: _isPaused ? AppHelpers.getTranslation(TrKeys.resumeRecording) : AppHelpers.getTranslation(TrKeys.pauseRecording),
                  ),
                ),

                // Send button (right side) - BLUE button with send icon
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomStyle.primary, // Blue color from app theme (like mic button)
                  ),
                  child: IconButton(
                    icon: Icon(Remix.send_plane_fill, color: Colors.white, size: 20.r),
                    onPressed: _stopRecording,
                    tooltip: AppHelpers.getTranslation(TrKeys.sendRecording),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // Original non-WhatsApp UI
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Recording indicator
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),

            // Timer text
            Text(
              _formatDuration(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(width: 12),

            // Cancel button
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: _cancelRecording,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: AppHelpers.getTranslation(TrKeys.cancelRecording),
            ),

            const SizedBox(width: 12),

            // Stop button
            IconButton(
              icon: const Icon(Icons.stop, size: 20),
              onPressed: _stopRecording,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: 'Stop recording',
            ),
          ],
        ),
      );
    }
  }
}