import React, { useState, useEffect } from 'react';
import { ReactMic } from 'react-mic';
import { FaMicrophone, FaPause, FaPlay, FaTrash } from 'react-icons/fa';
import { IoSend } from 'react-icons/io5';
import AudioService from '../services/AudioService';
import AudioWaveform from './AudioWaveform';
import '../assets/scss/components/voice-recorder-widget.scss';

/**
 * Component for recording voice messages
 *
 * @param {Object} props - Component props
 * @param {Function} props.onRecordingComplete - Callback when recording is complete
 * @param {boolean} props.whatsAppStyle - Whether to use WhatsApp style UI
 * @param {boolean} props.autoStart - Whether to start recording automatically
 */
const VoiceRecorderWidget = ({
  onRecordingComplete,
  whatsAppStyle = false,
  autoStart = false
}) => {
  const [isRecording, setIsRecording] = useState(false);
  const [isPaused, setIsPaused] = useState(false);
  const [recordingDuration, setRecordingDuration] = useState(0);
  const [audioBlob, setAudioBlob] = useState(null);
  const audioService = AudioService.getInstance();

  // Start recording automatically if autoStart is true
  useEffect(() => {
    console.log('VoiceRecorderWidget mounted, autoStart:', autoStart);
    if (autoStart) {
      console.log('Auto-starting recording...');
      setTimeout(() => {
        startRecording();
      }, 500); // Add a small delay to ensure component is fully mounted
    }

    // Clean up on unmount
    return () => {
      console.log('VoiceRecorderWidget unmounting, cleaning up...');
      if (isRecording) {
        stopRecording();
      }
    };
  }, []);

  // Start recording
  const startRecording = () => {
    // If recording was paused, resume it
    if (isPaused) {
      return resumeRecording();
    }

    setIsRecording(true);
    setIsPaused(false);
    setRecordingDuration(0);

    // Start duration timer
    audioService.onDurationChange = (duration) => {
      setRecordingDuration(duration);
    };

    audioService.startRecording();
  };

  // Stop recording
  const stopRecording = () => {
    console.log('stopRecording called, current state:', { isRecording, isPaused, recordingDuration });

    if (!isRecording && !isPaused) {
      console.log('Not recording or paused, returning early');
      return;
    }

    setIsRecording(false);
    setIsPaused(false);

    console.log('Stopping audio recording...');
    audioService.stopRecording();
    console.log('Audio recording stopped');

    // Wait a moment for the onStop event to fire and set the audioBlob
    setTimeout(() => {
      // Try to get the audioBlob from state or from the audioService
      const blob = audioBlob || audioService.audioBlob;

      // Make sure we have a valid duration (at least 1 second)
      const finalDuration = Math.max(recordingDuration, 1);
      console.log('Final duration to be sent:', finalDuration);

      // Call onRecordingComplete callback
      if (blob) {
        console.log('Calling onRecordingComplete with audioBlob size:', blob.size, 'and duration:', finalDuration);
        try {
          onRecordingComplete(blob, finalDuration);
          console.log('onRecordingComplete callback executed successfully');
        } catch (error) {
          console.error('Error in onRecordingComplete callback:', error);
        }
      } else {
        console.error('No audioBlob available, cannot complete recording');
        // Create a dummy blob with silence to avoid errors
        const silenceBlob = new Blob([new ArrayBuffer(1000)], { type: 'audio/webm' });
        console.log('Created a dummy silence blob as fallback');
        onRecordingComplete(silenceBlob, finalDuration);
      }
    }, 500); // Wait 500ms for the onStop event to fire
  };

  // Pause recording
  const pauseRecording = () => {
    if (!isRecording) return;

    setIsRecording(false);
    setIsPaused(true);

    audioService.pauseRecording();
  };

  // Resume recording
  const resumeRecording = () => {
    if (!isPaused) return;

    setIsRecording(true);
    setIsPaused(false);

    audioService.resumeRecording();
  };

  // Cancel recording
  const cancelRecording = () => {
    setIsRecording(false);
    setIsPaused(false);
    setRecordingDuration(0);
    setAudioBlob(null);

    audioService.onDurationChange = null;

    // Call onRecordingComplete with null to indicate cancellation
    onRecordingComplete(null, 0);
  };

  // Handle recording data
  const onRecordingData = (recordedData) => {
    console.log('Recording data received:', recordedData);
    if (recordedData && recordedData.blob) {
      console.log('Setting audio blob, size:', recordedData.blob.size);
      setAudioBlob(recordedData.blob);
      audioService.onRecordingData(recordedData);

      // Store the blob in a ref so we can access it in stopRecording
      audioService.audioBlob = recordedData.blob;

      // If we have a blob and duration, we can complete the recording
      if (recordingDuration > 0) {
        console.log('We have audio data and duration, can complete recording if needed');
      }
    } else {
      console.error('No valid recording data received');
    }
  };

  // Format duration
  const formatDuration = () => {
    // Ensure we're using the audioService's formatDuration method for consistency
    const formattedTime = audioService.formatDuration(recordingDuration);
    console.log('Formatted recording duration:', formattedTime, 'from seconds:', recordingDuration);
    return formattedTime;
  };

  // Render recording state
  const renderRecordingState = () => {
    return (
      <div className="voice-recorder__recording">
        <div className="voice-recorder__timer">
          {formatDuration()}
        </div>

        <div className="voice-recorder__waveform">
          <AudioWaveform
            durationSeconds={recordingDuration + 30}
            color="#4a76a8"
            isPlaying={true}
            currentPosition={recordingDuration}
          />
        </div>

        <div className="voice-recorder__controls">
          <button
            className="voice-recorder__control-button voice-recorder__control-button--cancel"
            onClick={cancelRecording}
            aria-label="Cancel"
          >
            <FaTrash />
          </button>

          {isRecording ? (
            <button
              className="voice-recorder__control-button voice-recorder__control-button--pause"
              onClick={pauseRecording}
              aria-label="Pause"
            >
              <FaPause />
            </button>
          ) : (
            <button
              className="voice-recorder__control-button voice-recorder__control-button--resume"
              onClick={resumeRecording}
              aria-label="Resume"
            >
              <FaPlay />
            </button>
          )}

          <button
            className="voice-recorder__control-button voice-recorder__control-button--send"
            onClick={stopRecording}
            aria-label="Send"
          >
            <IoSend />
          </button>
        </div>

        {/* ReactMic component */}
        <div style={{ display: 'none' }}>
          <ReactMic
            record={isRecording}
            className="voice-recorder__reactmic"
            onStop={onRecordingData}
            onData={(data) => {
              // Log that we're receiving audio data
              console.log('Receiving audio data...');
            }}
            onError={(err) => {
              console.error('Microphone error:', err);
              // If there's a microphone error, show a message and close the modal
              alert('Microphone access error. Please check your microphone permissions and try again.');
              setIsRecording(false);
              setIsPaused(false);
              // Call onRecordingComplete with null to indicate error
              onRecordingComplete(null, 0);
            }}
            strokeColor="#4a76a8"
            backgroundColor="#f5f5f5"
            mimeType="audio/webm"
            echoCancellation={true}
            autoGainControl={true}
            noiseSuppression={true}
            channelCount={1}
            sampleRate={44100}
          />
        </div>
      </div>
    );
  };

  // Render mic button
  const renderMicButton = () => {
    return (
      <button
        className="voice-recorder__mic-button"
        onClick={startRecording}
        aria-label="Record"
      >
        <FaMicrophone />
      </button>
    );
  };

  return (
    <div className={`voice-recorder ${whatsAppStyle ? 'voice-recorder--whatsapp' : ''}`}>
      {isRecording || isPaused ? renderRecordingState() : renderMicButton()}
    </div>
  );
};

export default VoiceRecorderWidget;
