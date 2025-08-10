import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A widget that displays an audio waveform similar to WhatsApp
class AudioWaveform extends StatelessWidget {
  /// The duration of the audio in seconds
  final int durationSeconds;

  /// The color of the waveform
  final Color color;

  /// The number of bars to display
  final int barCount;

  /// Whether the audio is currently playing
  final bool isPlaying;

  /// The current playback position in seconds
  final int currentPosition;

  const AudioWaveform({
    Key? key,
    required this.durationSeconds,
    required this.color,
    this.barCount = 30,
    this.isPlaying = false,
    this.currentPosition = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.r, // Increased height for better visibility
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(barCount, (index) {
          // Create a pattern of bar heights that looks like a waveform
          // This is a simplified version of what WhatsApp does
          final position = index / barCount;

          // Calculate a height based on position and a sine wave pattern
          double heightPercentage = 0.3 + 0.7 * _getHeightForPosition(position);

          // Make some random variations to look more natural
          if (index % 3 == 0) heightPercentage *= 0.8;
          if (index % 2 == 0) heightPercentage *= 1.2;

          // Clamp height to reasonable values
          heightPercentage = heightPercentage.clamp(0.2, 1.0);

          // Calculate if this bar should be highlighted (for playback progress)
          // WhatsApp-style progressive highlighting
          double progressRatio = 0;

          if (isPlaying && durationSeconds > 0) {
            // Use actual position and duration for accurate progress
            final clampedPosition = currentPosition.clamp(0, durationSeconds);
            progressRatio = clampedPosition / durationSeconds;

            // Ensure progress doesn't exceed 100%
            progressRatio = progressRatio.clamp(0.0, 1.0);
          }

          // WhatsApp-style highlighting: bars before current position are highlighted
          final barPosition = index / barCount;
          final isHighlighted = isPlaying && barPosition <= progressRatio;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 100), // Smooth animation
            width: 2.5.r, // Slightly wider bars like WhatsApp
            height: 28.r * heightPercentage,
            margin: EdgeInsets.symmetric(horizontal: 0.5.r), // Tighter spacing
            decoration: BoxDecoration(
              color: isHighlighted
                ? color // Full color for played portion
                : color.withOpacity(0.3), // More transparent for unplayed portion
              borderRadius: BorderRadius.circular(1.5.r), // Rounded bars
            ),
          );
        }),
      ),
    );
  }

  /// Get a height value between 0.0 and 1.0 for a given position
  double _getHeightForPosition(double position) {
    // Use a sine wave to create a natural looking waveform
    // This creates a pattern that resembles audio waves
    return 0.5 + 0.5 * sin(position * 15);
  }

  /// Simple sine function that works with degrees
  double sin(double x) {
    return (0.5 + 0.5 * (x - x.truncate())) * 2 - 1;
  }
}
