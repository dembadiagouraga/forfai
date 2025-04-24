import React, { useState, useRef, useEffect } from 'react';
import { FaPlay, FaPause } from 'react-icons/fa';
import AudioService from '../services/AudioService';
import AudioWaveform from './AudioWaveform';
import '../assets/scss/components/voice-message-bubble.scss';

/**
 * Component for displaying and playing voice messages
 *
 * @param {Object} props - Component props
 * @param {string} props.audioUrl - URL of the audio file
 * @param {number} props.duration - Duration of the audio in seconds
 * @param {boolean} props.isAdmin - Whether the message is from admin
 */
const VoiceMessageBubble = ({ audioUrl, duration = 0, isAdmin = false }) => {
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentPosition, setCurrentPosition] = useState(0);
  const waveformRef = useRef(null);
  const audioService = AudioService.getInstance();

  // Initialize audio service
  useEffect(() => {
    if (waveformRef.current) {
      audioService.initWaveSurfer(waveformRef.current);

      // Set up event listeners
      audioService.onPlaybackStart = () => {
        setIsPlaying(true);
      };

      audioService.onPlaybackStop = () => {
        setIsPlaying(false);
        setCurrentPosition(0);
      };

      audioService.onPlaybackProgress = (position) => {
        setCurrentPosition(position);
      };
    }

    // Clean up on unmount
    return () => {
      audioService.stopAudio();
      audioService.onPlaybackStart = null;
      audioService.onPlaybackStop = null;
      audioService.onPlaybackProgress = null;
    };
  }, []);

  // Toggle play/pause
  const togglePlay = () => {
    // Log the audio URL for debugging
    console.log('VoiceMessageBubble: Playing audio URL:', audioUrl);

    if (isPlaying) {
      audioService.pauseAudio();
      setIsPlaying(false);
    } else {
      audioService.playAudio(audioUrl);
      setIsPlaying(true);
    }
  };

  // Format duration - ensure we have a valid duration
  console.log('VoiceMessageBubble: Received duration:', duration);
  // Use a minimum of 1 second duration to avoid division by zero in progress calculation
  const validDuration = (duration !== undefined && duration !== null && duration > 0) ? duration : 6;
  const formattedDuration = audioService.formatDuration(validDuration);
  console.log('VoiceMessageBubble: Using duration:', validDuration, 'Formatted:', formattedDuration);

  // Calculate progress percentage for styling
  const progressPercentage = isPlaying ? (currentPosition / validDuration) * 100 : 0;

  return (
    <div className={`voice-message-bubble ${isAdmin ? 'admin' : 'user'}`}>
      <button
        className="voice-message-bubble__play-button"
        onClick={togglePlay}
        aria-label={isPlaying ? 'Pause' : 'Play'}
      >
        {isPlaying ? <FaPause /> : <FaPlay />}
      </button>

      <div className="voice-message-bubble__content">
        <div className="voice-message-bubble__waveform-container">
          <div
            className="voice-message-bubble__progress-bar"
            style={{ width: `${progressPercentage}%` }}
          />
          <div className="voice-message-bubble__waveform" ref={waveformRef}>
            <AudioWaveform
              durationSeconds={validDuration}
              color={isAdmin ? '#4a76a8' : '#6c757d'}
              isPlaying={isPlaying}
              currentPosition={currentPosition}
            />
          </div>
        </div>

        <div className="voice-message-bubble__duration" style={{ fontSize: '10px', fontWeight: '500' }}>
          {formattedDuration}
        </div>
      </div>
    </div>
  );
};

export default VoiceMessageBubble;
