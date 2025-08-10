import React from 'react';
import '../assets/scss/components/audio-waveform.scss';

/**
 * A component that displays an audio waveform similar to WhatsApp
 *
 * @param {Object} props - Component props
 * @param {number} props.durationSeconds - The duration of the audio in seconds
 * @param {string} props.color - The color of the waveform
 * @param {number} props.barCount - The number of bars to display
 * @param {boolean} props.isPlaying - Whether the audio is currently playing
 * @param {number} props.currentPosition - The current playback position in seconds
 */
const AudioWaveform = ({
  durationSeconds,
  color = '#2E8B57', // Changed to sea green
  barCount = 30,
  isPlaying = false,
  currentPosition = 0
}) => {
  /**
   * Get a height value between 0.0 and 1.0 for a given position
   * @param {number} position - Position between 0 and 1
   * @returns {number} Height value between 0 and 1
   */
  const getHeightForPosition = (position) => {
    // Use a sine wave to create a natural looking waveform
    // This creates a pattern that resembles audio waves
    return 0.5 + 0.5 * Math.sin(position * 15);
  };

  return (
    <div className="audio-waveform" style={{ '--waveform-color': color }}>
      {Array.from({ length: barCount }).map((_, index) => {
        // Create a pattern of bar heights that looks like a waveform
        const position = index / barCount;

        // Calculate a height based on position and a sine wave pattern
        // Use multiple sine waves with different frequencies for a more natural look
        const wave1 = Math.sin(position * Math.PI * 5) * 0.5 + 0.5;
        const wave2 = Math.sin(position * Math.PI * 7) * 0.3 + 0.5;
        const wave3 = Math.sin(position * Math.PI * 13) * 0.2 + 0.5;

        // Combine waves for a more natural look
        let heightPercentage = 0.3 + 0.7 * ((wave1 + wave2 + wave3) / 3);

        // Make some random variations to look more natural
        if (index % 5 === 0) heightPercentage *= 0.7;
        if (index % 7 === 0) heightPercentage *= 1.3;

        // Clamp height to reasonable values
        heightPercentage = Math.max(0.2, Math.min(1.0, heightPercentage));

        // Calculate if this bar should be highlighted (for playback progress)
        const isHighlighted = isPlaying &&
          (index / barCount) <= (currentPosition / Math.max(1, durationSeconds));

        return (
          <div
            key={index}
            className={`audio-waveform__bar ${isHighlighted ? 'audio-waveform__bar--highlighted' : ''}`}
            style={{
              height: `${28 * heightPercentage}px`,
              '--bar-color': color,
              '--bar-highlight-color': color,
            }}
          />
        );
      })}
    </div>
  );
};

export default AudioWaveform;
