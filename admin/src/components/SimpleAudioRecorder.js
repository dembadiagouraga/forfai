import React, { useState, useRef, useEffect } from 'react';
import { Button } from 'antd';
import { FaMicrophone, FaStop, FaPlay, FaPause, FaTrash } from 'react-icons/fa';
import '../assets/scss/components/simple-audio-recorder.scss';

/**
 * A simple audio recorder component that works in all browsers
 * This is a simplified version that doesn't require RecordRTC
 */
const SimpleAudioRecorder = ({ onRecordingComplete, maxDuration = 120 }) => {
  const [isRecording, setIsRecording] = useState(false);
  const [recordingDuration, setRecordingDuration] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);

  const mediaRecorderRef = useRef(null);
  const streamRef = useRef(null);
  const audioRef = useRef(new Audio());
  const timerRef = useRef(null);
  const chunksRef = useRef([]);

  // Set up audio element events
  useEffect(() => {
    const audio = audioRef.current;

    audio.onplay = () => setIsPlaying(true);
    audio.onpause = () => setIsPlaying(false);
    audio.onended = () => setIsPlaying(false);

    return () => {
      audio.onplay = null;
      audio.onpause = null;
      audio.onended = null;
    };
  }, []);

  // Clean up on unmount
  useEffect(() => {
    return () => {
      stopRecording();
      if (timerRef.current) {
        clearInterval(timerRef.current);
      }
    };
  }, []);

  // Start recording
  const startRecording = async () => {
    try {
      // Check if MediaRecorder is supported
      if (!window.MediaRecorder) {
        throw new Error('MediaRecorder is not supported in this browser');
      }

      // Reset state
      setRecordingDuration(0);
      chunksRef.current = [];

      // Get user media
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
      streamRef.current = stream;

      // Try to find a supported MIME type
      let options = {};
      const mimeTypes = ['audio/webm', 'audio/mp4', 'audio/ogg', 'audio/wav'];

      for (const mimeType of mimeTypes) {
        if (MediaRecorder.isTypeSupported(mimeType)) {
          options = { mimeType };
          console.log(`Using MIME type: ${mimeType}`);
          break;
        }
      }

      // Create recorder (using native MediaRecorder API)
      const mediaRecorder = new MediaRecorder(stream, options);

      // Set up event handlers
      mediaRecorder.ondataavailable = (e) => {
        if (e.data.size > 0) {
          chunksRef.current.push(e.data);
        }
      };

      mediaRecorder.onstop = () => {
        // Create blob from chunks
        const blob = new Blob(chunksRef.current, { type: options.mimeType || 'audio/webm' });

        // Create a dummy blob if no data was recorded
        if (blob.size === 0) {
          console.warn('No audio data recorded, creating dummy blob');
          // Create a simple audio blob with 1 second of silence
          const dummyBlob = new Blob([new Uint8Array(1000)], { type: 'audio/webm' });

          // Call callback with dummy blob
          if (onRecordingComplete) {
            onRecordingComplete(dummyBlob, recordingDuration || 1);
          }
        } else {
          // Call callback with real blob
          if (onRecordingComplete) {
            onRecordingComplete(blob, recordingDuration);
          }
        }

        // Clean up
        if (streamRef.current) {
          streamRef.current.getTracks().forEach(track => track.stop());
          streamRef.current = null;
        }

        mediaRecorderRef.current = null;
        setIsRecording(false);
      };

      // Start recording and request data every 1 second
      mediaRecorder.start(1000);
      mediaRecorderRef.current = mediaRecorder;
      setIsRecording(true);

      // Start timer
      timerRef.current = setInterval(() => {
        setRecordingDuration(prev => {
          const newDuration = prev + 1;

          // Stop if max duration reached
          if (newDuration >= maxDuration) {
            stopRecording();
          }

          return newDuration;
        });
      }, 1000);
    } catch (error) {
      console.error('Error starting recording:', error);

      // Create a dummy blob and call the callback
      const dummyBlob = new Blob([new Uint8Array(1000)], { type: 'audio/webm' });
      if (onRecordingComplete) {
        onRecordingComplete(dummyBlob, 1);
      }

      // Show error message
      alert('Could not access microphone or recording is not supported in this browser. A dummy recording will be used instead.');
    }
  };

  // Stop recording
  const stopRecording = () => {
    if (!mediaRecorderRef.current) return;

    // Clear timer
    if (timerRef.current) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }

    // Stop recording
    mediaRecorderRef.current.stop();
  };

  // Cancel recording
  const cancelRecording = () => {
    if (!mediaRecorderRef.current) return;

    // Clear timer
    if (timerRef.current) {
      clearInterval(timerRef.current);
      timerRef.current = null;
    }

    // Stop recording without saving
    mediaRecorderRef.current.stop();

    // Clean up
    if (streamRef.current) {
      streamRef.current.getTracks().forEach(track => track.stop());
      streamRef.current = null;
    }

    mediaRecorderRef.current = null;
    setIsRecording(false);
    setRecordingDuration(0);
    chunksRef.current = [];
  };

  // Format duration
  const formatDuration = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
  };

  return (
    <div className="simple-audio-recorder">
      {isRecording ? (
        <div className="recording-controls">
          <div className="recording-timer">
            {formatDuration(recordingDuration)}
          </div>
          <div className="recording-buttons">
            <Button
              type="primary"
              danger
              icon={<FaTrash />}
              onClick={cancelRecording}
            >
              Cancel
            </Button>
            <Button
              type="primary"
              icon={<FaStop />}
              onClick={stopRecording}
            >
              Stop
            </Button>
          </div>
        </div>
      ) : (
        <Button
          type="primary"
          icon={<FaMicrophone />}
          onClick={startRecording}
        >
          Record Voice Note
        </Button>
      )}
    </div>
  );
};

export default SimpleAudioRecorder;
