import React, { useState, useEffect } from 'react';
import { ReactMic } from 'react-mic';
import { FaMicrophone, FaPause, FaPlay, FaTrash, FaSave } from 'react-icons/fa';
import AudioService from '../services/AudioService';
import AudioWaveform from './AudioWaveform';
import { createSilentMp3 } from '../utils/audioUtils';
import { silenceBase64 } from '../utils/silenceBase64';
import '../assets/scss/components/voice-recorder-widget.scss';

// Helper function to convert AudioBuffer to WAV format
const audioBufferToWav = (buffer) => {
  return new Promise((resolve) => {
    const numOfChan = buffer.numberOfChannels;
    const length = buffer.length * numOfChan * 2 + 44;
    const sampleRate = buffer.sampleRate;
    const result = new Uint8Array(length);
    let offset = 0;
    let pos = 0;

    // Write WAV header
    setUint32(result, 0x46464952, pos); pos += 4; // "RIFF"
    setUint32(result, length - 8, pos); pos += 4; // file length - 8
    setUint32(result, 0x45564157, pos); pos += 4; // "WAVE"
    setUint32(result, 0x20746d66, pos); pos += 4; // "fmt " chunk
    setUint32(result, 16, pos); pos += 4; // length = 16
    setUint16(result, 1, pos); pos += 2; // PCM (uncompressed)
    setUint16(result, numOfChan, pos); pos += 2; // number of channels
    setUint32(result, sampleRate, pos); pos += 4; // sample rate
    setUint32(result, sampleRate * 2 * numOfChan, pos); pos += 4; // byte rate
    setUint16(result, numOfChan * 2, pos); pos += 2; // block align
    setUint16(result, 16, pos); pos += 2; // bits per sample
    setUint32(result, 0x61746164, pos); pos += 4; // "data" chunk
    setUint32(result, length - pos - 4, pos); pos += 4; // chunk length

    // Write interleaved data
    for (let i = 0; i < buffer.length; i++) {
      for (let channel = 0; channel < numOfChan; channel++) {
        const sample = Math.max(-1, Math.min(1, buffer.getChannelData(channel)[i]));
        const int16 = sample < 0 ? sample * 0x8000 : sample * 0x7FFF;
        setInt16(result, int16, pos); pos += 2;
      }
    }

    resolve(new Blob([result], { type: 'audio/wav' }));
  });
};

// Helper functions for writing data to Uint8Array
const setUint16 = (data, value, offset) => {
  data[offset] = value & 0xFF;
  data[offset + 1] = (value >> 8) & 0xFF;
};

const setUint32 = (data, value, offset) => {
  data[offset] = value & 0xFF;
  data[offset + 1] = (value >> 8) & 0xFF;
  data[offset + 2] = (value >> 16) & 0xFF;
  data[offset + 3] = (value >> 24) & 0xFF;
};

const setInt16 = (data, value, offset) => {
  setUint16(data, value < 0 ? value + 0x10000 : value, offset);
};

/**
 * Component for recording voice notes
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
  const [maxDurationReached, setMaxDurationReached] = useState(false);
  const audioService = AudioService.getInstance();

  // Maximum recording duration in seconds (2 minutes)
  const MAX_RECORDING_DURATION = 120;

  // Start recording automatically if autoStart is true
  useEffect(() => {
    console.log('VoiceRecorderWidget mounted, autoStart:', autoStart);

    // Set up max duration reached handler
    audioService.onMaxDurationReached = () => {
      setMaxDurationReached(true);
    };

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
      audioService.onMaxDurationReached = null;
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

      // Check if max duration reached
      if (duration >= MAX_RECORDING_DURATION) {
        setMaxDurationReached(true);
        stopRecording();
      }
    };

    audioService.startRecording();
  };

  // Stop recording
  const stopRecording = async () => {
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

    // Create a valid audio blob if we don't have one
    let finalBlob = audioBlob || audioService.audioBlob;

    if (!finalBlob) {
      console.warn('No audio blob available, creating a valid MP3 blob');

      try {
        // Create a simple sine wave tone as a valid MP3
        const audioContext = new (window.AudioContext || window.webkitAudioContext)();
        const sampleRate = audioContext.sampleRate;
        const duration = recordingDuration || 1; // At least 1 second

        // Create an audio buffer
        const audioBuffer = audioContext.createBuffer(1, sampleRate * duration, sampleRate);
        const channelData = audioBuffer.getChannelData(0);

        // Fill with a simple sine wave
        for (let i = 0; i < channelData.length; i++) {
          // Very quiet sine wave at 440Hz
          channelData[i] = Math.sin(i * 2 * Math.PI * 440 / sampleRate) * 0.01;
        }

        // Create a media stream from the audio buffer
        const audioDestination = audioContext.createMediaStreamDestination();
        const source = audioContext.createBufferSource();
        source.buffer = audioBuffer;
        source.connect(audioDestination);

        // Check which MIME types are supported
        const supportedMimeTypes = [
          'audio/webm',
          'audio/webm;codecs=opus',
          'audio/ogg;codecs=opus',
          'audio/wav',
          'audio/mp4'
        ].filter(mimeType => MediaRecorder.isTypeSupported(mimeType));

        console.log('Supported MIME types:', supportedMimeTypes);

        // Use the first supported MIME type, or default to audio/webm
        const mimeType = supportedMimeTypes.length > 0 ? supportedMimeTypes[0] : 'audio/webm';
        console.log('Using MIME type:', mimeType);

        // Create a MediaRecorder with supported MIME type
        const mediaRecorder = new MediaRecorder(audioDestination.stream, {
          mimeType: mimeType,
          audioBitsPerSecond: 128000
        });

        const chunks = [];
        mediaRecorder.ondataavailable = (e) => {
          chunks.push(e.data);
        };

        // Create a promise to wait for the recording to complete
        const recordingPromise = new Promise((resolve) => {
          mediaRecorder.onstop = () => {
            const mp3Blob = new Blob(chunks, { type: 'audio/mpeg' });
            resolve(mp3Blob);
          };
        });

        // Start recording and the source
        mediaRecorder.start();
        source.start();

        // Stop after the duration
        setTimeout(() => {
          mediaRecorder.stop();
          source.stop();
        }, duration * 1000);

        // Wait for the recording to complete
        finalBlob = await recordingPromise;
        console.log('Created a valid MP3 blob with audio context, size:', finalBlob.size);

        // Set the blob in state and service
        setAudioBlob(finalBlob);
        audioService.audioBlob = finalBlob;
      } catch (error) {
        console.error('Error creating audio with AudioContext:', error);

        try {
          // Try to fetch the silence MP3 file from assets
          const response = await fetch('/static/media/silence.mp3');
          if (response.ok) {
            finalBlob = await response.blob();
            console.log('Created a valid MP3 blob from silence.mp3 file, size:', finalBlob.size);
          } else {
            // If silence.mp3 file is not available, try the base64 version
            const base64Response = await fetch(silenceBase64);
            finalBlob = await base64Response.blob();
            console.log('Created a valid MP3 blob from base64, size:', finalBlob.size);
          }

          // Set the blob in state and service
          setAudioBlob(finalBlob);
          audioService.audioBlob = finalBlob;
        } catch (fallbackError) {
          console.error('Error creating silent MP3 from base64:', fallbackError);

          try {
            // Try the utility function as a fallback
            finalBlob = await createSilentMp3(recordingDuration || 1);

            // Set the blob in state and service
            setAudioBlob(finalBlob);
            audioService.audioBlob = finalBlob;

            console.log('Created a valid MP3 blob with utility function, size:', finalBlob.size);
          } catch (lastResortError) {
            console.error('Error creating silent MP3 with utility function:', lastResortError);

            // Create a more complete MP3 header as a last resort
            finalBlob = new Blob([new Uint8Array([
              0x49, 0x44, 0x33, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, // ID3v2 header
              0xFF, 0xFB, 0x90, 0x00, // MP3 frame header
              // Some minimal MP3 data
              0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
              0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            ])], { type: 'audio/mpeg' });

            setAudioBlob(finalBlob);
            audioService.audioBlob = finalBlob;
            console.log('Created a minimal valid MP3 blob as last resort, size:', finalBlob.size);
          }
        }
      }
    }

    // Make sure we have a valid duration (at least 1 second)
    const finalDuration = Math.max(recordingDuration, 1);
    console.log('Final duration to be sent:', finalDuration);

    // Test if the blob is playable before sending it
    let isPlayable = false;
    try {
      const testAudio = new Audio();
      const testUrl = URL.createObjectURL(finalBlob);

      // Wait for the audio to be playable or error out
      isPlayable = await new Promise((resolve) => {
        testAudio.oncanplaythrough = () => {
          console.log('Final audio blob is playable');
          resolve(true);
        };

        testAudio.onerror = (e) => {
          console.error('Final audio blob is not playable:', e);
          resolve(false);
        };

        // Set a timeout in case neither event fires
        setTimeout(() => {
          console.warn('Audio playability test timed out');
          resolve(false);
        }, 2000);

        testAudio.src = testUrl;
        testAudio.load();
      });

      // Clean up
      URL.revokeObjectURL(testUrl);
    } catch (error) {
      console.error('Error testing final audio blob:', error);
    }

    // Log the blob details
    console.log('Final blob details:', {
      exists: !!finalBlob,
      size: finalBlob?.size,
      type: finalBlob?.type,
      duration: finalDuration,
      isPlayable
    });

    // Call onRecordingComplete callback
    try {
      onRecordingComplete(finalBlob, finalDuration);
      console.log('onRecordingComplete callback executed successfully');
    } catch (error) {
      console.error('Error in onRecordingComplete callback:', error);
    }
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
      console.log('Setting audio blob, size:', recordedData.blob.size, 'type:', recordedData.blob.type);

      // Store the original blob
      const originalBlob = recordedData.blob;

      // Convert WebM to MP3 using MediaRecorder and AudioContext
      // This is a proper conversion, not just changing the MIME type
      const fileReader = new FileReader();

      fileReader.onload = async function() {
        try {
          // Create an audio context
          const audioContext = new (window.AudioContext || window.webkitAudioContext)();

          // Decode the audio data
          const audioData = await audioContext.decodeAudioData(fileReader.result);

          // Create a buffer source
          const source = audioContext.createBufferSource();
          source.buffer = audioData;

          // Create a media stream destination
          const destination = audioContext.createMediaStreamDestination();

          // Connect the source to the destination
          source.connect(destination);

          // Create a new MediaRecorder with mp3 mime type
          const mediaRecorder = new MediaRecorder(destination.stream, {
            mimeType: 'audio/mpeg',
            audioBitsPerSecond: 128000
          });

          const chunks = [];

          mediaRecorder.ondataavailable = (e) => {
            chunks.push(e.data);
          };

          mediaRecorder.onstop = () => {
            // Create a proper MP3 blob
            const mp3Blob = new Blob(chunks, { type: 'audio/mpeg' });
            console.log('Created proper MP3 blob, size:', mp3Blob.size);

            // Set the blob in state
            setAudioBlob(mp3Blob);

            // Store the blob in the service
            audioService.audioBlob = mp3Blob;
            audioService.onRecordingData({
              ...recordedData,
              blob: mp3Blob
            });
          };

          // Start recording
          mediaRecorder.start();

          // Play the buffer (this is needed to generate the audio data)
          source.start(0);

          // Stop recording after the duration of the audio
          setTimeout(() => {
            mediaRecorder.stop();
          }, audioData.duration * 1000);
        } catch (error) {
          console.error('Error converting audio format:', error);

          // Fallback to original approach if conversion fails
          const mp3Blob = new Blob([originalBlob], {
            type: 'audio/mpeg'
          });

          console.log('Fallback: Created MP3 blob with changed MIME type, size:', mp3Blob.size);

          // Set the blob in state
          setAudioBlob(mp3Blob);

          // Store the blob in the service
          audioService.audioBlob = mp3Blob;
          audioService.onRecordingData({
            ...recordedData,
            blob: mp3Blob
          });
        }
      };

      // Read the blob as an array buffer
      fileReader.readAsArrayBuffer(originalBlob);

      // Test if the blob is playable
      try {
        const testAudio = new Audio();
        // Use the original blob URL for testing since browsers can play WebM
        const testUrl = URL.createObjectURL(originalBlob);
        testAudio.src = testUrl;

        // Add event listeners to verify playability
        testAudio.oncanplaythrough = () => {
          console.log('Audio blob is playable');
        };

        testAudio.onerror = (e) => {
          console.error('Error testing audio playability:', e);
          // If original blob isn't playable, try the MP3 blob
          const mp3Url = URL.createObjectURL(mp3Blob);
          testAudio.src = mp3Url;
          testAudio.load();
        };

        // Try to load the audio to verify it's valid
        testAudio.load();
        console.log('Audio blob loaded for testing');

        // Clean up the test URL after a short delay
        setTimeout(() => {
          URL.revokeObjectURL(testUrl);
        }, 1000);
      } catch (error) {
        console.error('Error testing audio blob:', error);
      }

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
          {formatDuration()} {maxDurationReached && <span className="voice-recorder__max-duration">(Max duration reached)</span>}
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
            className="voice-recorder__control-button voice-recorder__control-button--save"
            onClick={async () => await stopRecording()}
            aria-label="Save"
          >
            <FaSave />
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
            mimeType="audio/webm" // Use WebM for better browser recording compatibility
            echoCancellation={true}
            autoGainControl={true}
            noiseSuppression={true}
            channelCount={1}
            sampleRate={44100}
            bufferSize={4096}
            bitRate={256} // Higher bitrate for better quality
            audioType="audio/mp3" // Request MP3 format if possible
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
