import React, { useState, useEffect, useRef } from 'react';
import { FaMicrophone, FaPause, FaPlay, FaTrash, FaSave } from 'react-icons/fa';
import AudioWaveform from './AudioWaveform';
import '../assets/scss/components/voice-recorder-widget.scss';

/**
 * Component for recording voice notes using RecordRTC
 *
 * @param {Object} props - Component props
 * @param {Function} props.onRecordingComplete - Callback when recording is complete
 * @param {boolean} props.whatsAppStyle - Whether to use WhatsApp style UI
 * @param {boolean} props.autoStart - Whether to start recording automatically
 */
const RecordRTCVoiceRecorder = ({
  onRecordingComplete,
  whatsAppStyle = false,
  autoStart = false
}) => {
  const [isRecording, setIsRecording] = useState(false);
  const [isPaused, setIsPaused] = useState(false);
  const [recordingDuration, setRecordingDuration] = useState(0);
  // eslint-disable-next-line no-unused-vars
  const [audioBlob, setAudioBlob] = useState(null);
  const [maxDurationReached, setMaxDurationReached] = useState(false);

  const recorder = useRef(null);
  const stream = useRef(null);
  const timerInterval = useRef(null);

  // Maximum recording duration in seconds (2 minutes)
  const MAX_RECORDING_DURATION = 120;

  // Start recording automatically if autoStart is true
  useEffect(() => {
    console.log('RecordRTCVoiceRecorder mounted, autoStart:', autoStart);

    if (autoStart) {
      console.log('Auto-starting recording...');
      setTimeout(() => {
        startRecording();
      }, 500); // Add a small delay to ensure component is fully mounted
    }

    // Clean up on unmount
    return () => {
      console.log('RecordRTCVoiceRecorder unmounting, cleaning up...');
      if (isRecording) {
        stopRecording();
      }
      clearInterval(timerInterval.current);

      // Stop and release media stream
      if (stream.current) {
        stream.current.getTracks().forEach(track => track.stop());
      }
    };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Start recording
  const startRecording = async () => {
    try {
      // If recording was paused, resume it
      if (isPaused && recorder.current) {
        return resumeRecording();
      }

      console.log('Starting recording...');

      // Get user media
      stream.current = await navigator.mediaDevices.getUserMedia({
        audio: {
          echoCancellation: true,
          noiseSuppression: true,
          autoGainControl: true
        }
      });

      // ✅ FIXED: Force WAV recording for better compatibility
      // Check which MIME types are supported by the browser
      const supportedMimeTypes = [
        'audio/wav',                    // ✅ Prioritize WAV for compatibility
        'audio/webm;codecs=pcm',       // ✅ PCM codec for better quality
        'audio/webm',
        'audio/webm;codecs=opus',
        'audio/ogg;codecs=opus',
        'audio/mp4',
        'audio/mpeg'
      ].filter(mimeType => {
        try {
          return MediaRecorder.isTypeSupported(mimeType);
        } catch (e) {
          return false;
        }
      });

      // Log all supported MIME types for debugging
      console.log('All supported MIME types by this browser:',
        ['audio/wav', 'audio/webm;codecs=pcm', 'audio/webm', 'audio/webm;codecs=opus', 'audio/ogg;codecs=opus', 'audio/wav', 'audio/mp4', 'audio/mpeg']
          .map(type => ({ type, supported: MediaRecorder.isTypeSupported(type) }))
      );

      console.log('Supported MIME types:', supportedMimeTypes);

      // ✅ FIXED: Prefer WAV or PCM for better compatibility
      let mimeType = 'audio/webm'; // fallback
      if (supportedMimeTypes.includes('audio/wav')) {
        mimeType = 'audio/wav';
      } else if (supportedMimeTypes.includes('audio/webm;codecs=pcm')) {
        mimeType = 'audio/webm;codecs=pcm';
      } else if (supportedMimeTypes.length > 0) {
        mimeType = supportedMimeTypes[0];
      }

      console.log('Using MIME type:', mimeType);

      // Create MediaRecorder instance with better settings
      recorder.current = new MediaRecorder(stream.current, {
        mimeType: mimeType,
        audioBitsPerSecond: 128000,
        // ✅ Add better audio constraints
        ...(mimeType.includes('wav') && {
          sampleRate: 44100,
          channelCount: 1
        })
      });

      const chunks = [];

      // Handle data available event
      recorder.current.ondataavailable = (e) => {
        if (e.data.size > 0) {
          chunks.push(e.data);
          console.log('Data available:', e.data.size);
        }
      };

      // Handle recording stop event
      recorder.current.onstop = () => {
        console.log('MediaRecorder stopped');

        // ✅ FIXED: Create blob with proper format handling
        const blob = new Blob(chunks, { type: mimeType });
        console.log('Created blob:', {
          size: blob.size,
          type: blob.type,
          mimeType: mimeType,
          isWAV: mimeType.includes('wav'),
          isWebM: mimeType.includes('webm'),
          hasPCM: mimeType.includes('pcm')
        });

        // ✅ FIXED: Handle format conversion if needed
        if (mimeType.includes('webm') && !mimeType.includes('pcm')) {
          console.log('⚠️ WebM format detected - may need conversion for better compatibility');
          // For now, keep original but log the issue
          setAudioBlob(blob);
        } else {
          console.log('✅ Compatible format detected:', mimeType);
          setAudioBlob(blob);
        }

        // Use the actual duration, ensure minimum 1 second for very short recordings
        // Convert to number first to ensure we're working with a numeric value
        const durationNum = typeof recordingDuration === 'number' ? recordingDuration : parseFloat(recordingDuration) || 0;
        const finalDuration = Math.max(durationNum, 1); // Ensure at least 1 second

        // 🔍 COMPREHENSIVE RECORDING DEBUG
        console.group('🎙️ RECORDING COMPLETION ANALYSIS');
        console.log('⏱️ Timer Duration:', recordingDuration, 'seconds');
        console.log('⏱️ Processed Duration:', durationNum, 'seconds');
        console.log('⏱️ Final Duration (with minimum):', finalDuration, 'seconds');
        console.log('📦 Blob Details:', {
          size: blob?.size,
          type: blob?.type,
          isValid: blob?.size > 0,
          sizeKB: Math.round(blob?.size / 1024)
        });
        console.log('🎯 Audio Format:', mimeType);
        console.groupEnd();

        // Call onRecordingComplete callback
        try {
          onRecordingComplete(blob, finalDuration);
          console.log('onRecordingComplete callback executed successfully');
        } catch (error) {
          console.error('Error in onRecordingComplete callback:', error);
        }

        // Stop and release media stream
        if (stream.current) {
          stream.current.getTracks().forEach(track => track.stop());
        }
      };

      // Start recording
      recorder.current.start(1000); // Capture data every second

      setIsRecording(true);
      setIsPaused(false);
      setRecordingDuration(0);

      // Start duration timer
      timerInterval.current = setInterval(() => {
        setRecordingDuration(prev => {
          const newDuration = prev + 1;

          // Check if max duration reached
          if (newDuration >= MAX_RECORDING_DURATION) {
            setMaxDurationReached(true);
            stopRecording();
            clearInterval(timerInterval.current);
          }

          return newDuration;
        });
      }, 1000);
    } catch (error) {
      console.error('Error starting recording:', error);
      alert('Microphone access error. Please check your microphone permissions and try again.');
    }
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
    clearInterval(timerInterval.current);

    console.log('Stopping audio recording...');

    if (recorder.current && recorder.current.state !== 'inactive') {
      try {
        // Stop the MediaRecorder
        recorder.current.stop();
        console.log('MediaRecorder stop called');

        // Note: The actual processing happens in the onstop event handler
        // that we set up in startRecording
      } catch (error) {
        console.error('Error stopping MediaRecorder:', error);

        // If there's an error, make sure we clean up
        if (stream.current) {
          stream.current.getTracks().forEach(track => track.stop());
        }

        // Call onRecordingComplete with null to indicate error
        onRecordingComplete(null, 0);
      }
    } else {
      console.warn('MediaRecorder not available or already inactive');

      // Call onRecordingComplete with null
      onRecordingComplete(null, 0);
    }
  };

  // Pause recording
  const pauseRecording = () => {
    if (!isRecording || !recorder.current || recorder.current.state !== 'recording') return;

    try {
      console.log('Pausing recording...');

      // Check if pause is supported
      if (typeof recorder.current.pause === 'function') {
        recorder.current.pause();
        clearInterval(timerInterval.current);

        setIsRecording(false);
        setIsPaused(true);
      } else {
        console.warn('MediaRecorder pause not supported in this browser');
      }
    } catch (error) {
      console.error('Error pausing recording:', error);
    }
  };

  // Resume recording
  const resumeRecording = () => {
    if (!isPaused || !recorder.current || recorder.current.state !== 'paused') return;

    try {
      console.log('Resuming recording...');

      // Check if resume is supported
      if (typeof recorder.current.resume === 'function') {
        recorder.current.resume();

        // Restart duration timer
        timerInterval.current = setInterval(() => {
          setRecordingDuration(prev => {
            const newDuration = prev + 1;

            // Check if max duration reached
            if (newDuration >= MAX_RECORDING_DURATION) {
              setMaxDurationReached(true);
              stopRecording();
              clearInterval(timerInterval.current);
            }

            return newDuration;
          });
        }, 1000);

        setIsRecording(true);
        setIsPaused(false);
      } else {
        console.warn('MediaRecorder resume not supported in this browser');

        // If resume is not supported, stop and start a new recording
        stopRecording();
        setTimeout(() => startRecording(), 500);
      }
    } catch (error) {
      console.error('Error resuming recording:', error);
    }
  };

  // Cancel recording
  const cancelRecording = () => {
    console.log('Cancelling recording...');

    if (recorder.current && recorder.current.state !== 'inactive') {
      try {
        // Stop the MediaRecorder
        recorder.current.stop();
        console.log('MediaRecorder stopped for cancellation');
      } catch (error) {
        console.error('Error stopping MediaRecorder for cancellation:', error);
      }
    }

    // Stop and release media stream
    if (stream.current) {
      stream.current.getTracks().forEach(track => track.stop());
    }

    clearInterval(timerInterval.current);
    setIsRecording(false);
    setIsPaused(false);
    setRecordingDuration(0);
    setAudioBlob(null);

    // Call onRecordingComplete with null to indicate cancellation
    onRecordingComplete(null, 0);
  };

  // Format duration in M:SS format (without leading zero for minutes)
  const formatDuration = () => {
    const minutes = Math.floor(recordingDuration / 60);
    const seconds = recordingDuration % 60;
    const formattedTime = `${minutes}:${seconds.toString().padStart(2, '0')}`;
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
            onClick={stopRecording}
            aria-label="Save"
          >
            <FaSave />
          </button>
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

export default RecordRTCVoiceRecorder;
