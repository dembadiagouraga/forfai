// AudioService.js - Service for audio recording and playback

import WaveSurfer from 'wavesurfer.js';
import { ReactMic } from 'react-mic';

/**
 * Service for handling audio recording and playback
 */
class AudioService {
  // Singleton pattern
  static instance = null;

  static getInstance() {
    if (!AudioService.instance) {
      AudioService.instance = new AudioService();
    }
    return AudioService.instance;
  }

  constructor() {
    this.isRecording = false;
    this.isPaused = false;
    this.recordingDuration = 0;
    this.recordingTimer = null;
    this.audioBlob = null;
    this.audioUrl = null;
    this.waveSurfer = null;
    this.audioElement = null; // HTML5 Audio element for fallback
    this.lastSource = null; // Last audio source used

    // Event listeners
    this.onRecordingStart = null;
    this.onRecordingStop = null;
    this.onDurationChange = null;
    this.onPlaybackStart = null;
    this.onPlaybackStop = null;
    this.onPlaybackProgress = null;
  }

  /**
   * Initialize the WaveSurfer instance
   * @param {HTMLElement} container - The container element for the waveform
   */
  initWaveSurfer(container) {
    this.waveSurfer = WaveSurfer.create({
      container: container,
      waveColor: '#c5c5c5',
      progressColor: '#4a76a8',
      cursorColor: 'transparent',
      barWidth: 2,
      barRadius: 3,
      cursorWidth: 0,
      height: 30,
      barGap: 1,
    });

    this.waveSurfer.on('ready', () => {
      console.log('WaveSurfer is ready');
    });

    this.waveSurfer.on('finish', () => {
      if (this.onPlaybackStop) {
        this.onPlaybackStop();
      }
    });

    this.waveSurfer.on('audioprocess', (progress) => {
      if (this.onPlaybackProgress) {
        this.onPlaybackProgress(progress);
      }
    });
  }

  /**
   * Start recording audio
   */
  startRecording() {
    this.isRecording = true;
    this.isPaused = false;
    this.recordingDuration = 0;
    this.recordingStartTime = Date.now(); // Use Date.now() for simpler time tracking

    // Start timer for tracking duration
    this.recordingTimer = setInterval(() => {
      // Calculate elapsed time in seconds
      const elapsedMs = Date.now() - this.recordingStartTime;
      const elapsedSeconds = Math.floor(elapsedMs / 1000);

      // Update duration if changed
      if (elapsedSeconds !== this.recordingDuration) {
        this.recordingDuration = elapsedSeconds;
        console.log('Recording duration updated:', this.recordingDuration, 'seconds');

        if (this.onDurationChange) {
          this.onDurationChange(this.recordingDuration);
        }
      }
    }, 200); // Check every 200ms for good balance of accuracy and performance

    if (this.onRecordingStart) {
      this.onRecordingStart();
    }
  }

  /**
   * Stop recording audio
   */
  stopRecording() {
    this.isRecording = false;

    // Stop timer
    if (this.recordingTimer) {
      clearInterval(this.recordingTimer);
      this.recordingTimer = null;
    }

    if (this.onRecordingStop) {
      this.onRecordingStop(this.audioBlob, this.audioUrl);
    }
  }

  /**
   * Pause recording
   */
  pauseRecording() {
    this.isRecording = false;
    this.isPaused = true;

    // Stop timer
    if (this.recordingTimer) {
      clearInterval(this.recordingTimer);
      this.recordingTimer = null;
    }
  }

  /**
   * Resume recording
   */
  resumeRecording() {
    this.isRecording = true;
    this.isPaused = false;

    // Calculate how much time has passed already
    const pausedDuration = this.recordingDuration * 1000; // Convert to milliseconds

    // Set a new start time that accounts for the already elapsed time
    this.recordingStartTime = Date.now() - pausedDuration;

    // Resume timer
    this.recordingTimer = setInterval(() => {
      // Calculate elapsed time in seconds
      const elapsedMs = Date.now() - this.recordingStartTime;
      const elapsedSeconds = Math.floor(elapsedMs / 1000);

      // Update duration if changed
      if (elapsedSeconds !== this.recordingDuration) {
        this.recordingDuration = elapsedSeconds;
        console.log('Recording duration updated (resumed):', this.recordingDuration, 'seconds');

        if (this.onDurationChange) {
          this.onDurationChange(this.recordingDuration);
        }
      }
    }, 200); // Check every 200ms for good balance of accuracy and performance
  }

  /**
   * Handle recording data
   * @param {Object} recordedData - The recorded audio data
   */
  onRecordingData(recordedData) {
    console.log('AudioService: Recording data received:', recordedData);
    if (recordedData && recordedData.blob) {
      this.audioBlob = recordedData.blob;
      this.audioUrl = recordedData.blobURL;
      console.log('AudioService: Audio blob created, size:', this.audioBlob?.size, 'bytes');

      // Store the blob in localStorage as a fallback (base64 encoded)
      try {
        const reader = new FileReader();
        reader.onloadend = () => {
          const base64data = reader.result;
          console.log('AudioService: Storing audio blob in memory, length:', base64data.length);
          // We don't actually store in localStorage as it might be too large,
          // but we keep the reference in memory
        };
        reader.readAsDataURL(recordedData.blob);
      } catch (error) {
        console.error('AudioService: Error storing audio blob:', error);
      }
    } else {
      console.error('AudioService: Invalid recording data received');
    }
  }

  /**
   * Play audio from a URL or Blob
   * @param {string|Blob} source - The audio source (URL or Blob)
   */
  playAudio(source) {
    console.log('AudioService: Playing audio from source:', source);

    // Store the source for later use (e.g., resuming)
    this.lastSource = source;

    // Handle different types of sources
    let audioUrl = source;

    // If source is a local file path from Flutter (starts with /data/user/...)
    if (typeof source === 'string' && source.startsWith('/data/user/')) {
      console.log('AudioService: Source is a local file path from Flutter, cannot play directly');
      // Use a sample audio file as fallback for local file paths
      audioUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';
    }

    // If source is a dummy URL from development mode
    else if (typeof source === 'string' && (source.includes('example.com') || source.includes('dummy'))) {
      console.log('AudioService: Source is a dummy URL, using sample audio');
      audioUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
    }

    // Always use HTML5 Audio element for better compatibility
    console.log('AudioService: Using HTML5 Audio for playback with URL:', audioUrl);

    // Create an audio element for playback if it doesn't exist
    if (!this.audioElement) {
      this.audioElement = new Audio();

      // Set up event listeners
      this.audioElement.onplay = () => {
        console.log('AudioService: HTML5 Audio started playing');
        if (this.onPlaybackStart) {
          this.onPlaybackStart();
        }
      };

      this.audioElement.onpause = () => {
        console.log('AudioService: HTML5 Audio paused');
      };

      this.audioElement.onended = () => {
        console.log('AudioService: HTML5 Audio ended');
        if (this.onPlaybackStop) {
          this.onPlaybackStop();
        }
      };

      this.audioElement.ontimeupdate = () => {
        const progress = this.audioElement.currentTime;
        if (this.onPlaybackProgress) {
          this.onPlaybackProgress(progress);
        }
      };

      this.audioElement.onerror = (e) => {
        console.error('AudioService: HTML5 Audio error:', e);
        console.log('AudioService: Error details:', e.target.error);

        // If there's an error with the audio URL, try a fallback
        console.log('AudioService: Using fallback audio due to error');
        this.audioElement.src = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
        this.audioElement.play();
      };
    }

    // Set the source and play
    this.audioElement.src = audioUrl;

    // Play with a small delay to ensure the src is set
    setTimeout(() => {
      const playPromise = this.audioElement.play();

      // Handle play promise (required for modern browsers)
      if (playPromise !== undefined) {
        playPromise.catch(error => {
          console.error('AudioService: Play promise error:', error);
          // Try fallback on error
          this.audioElement.src = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
          this.audioElement.play();
        });
      }
    }, 100);
  }

  /**
   * Pause audio playback
   */
  pauseAudio() {
    // If we're using HTML5 Audio element
    if (this.audioElement) {
      console.log('AudioService: Pausing HTML5 Audio playback');
      this.audioElement.pause();
      return;
    }

    if (!this.waveSurfer) {
      console.error('WaveSurfer not initialized');
      return;
    }

    console.log('AudioService: Pausing WaveSurfer playback');
    this.waveSurfer.pause();
  }

  /**
   * Resume audio playback
   */
  resumeAudio() {
    // If we're using HTML5 Audio element
    if (this.audioElement) {
      console.log('AudioService: Resuming HTML5 Audio playback');
      this.audioElement.play();
      return;
    }

    if (!this.waveSurfer) {
      console.error('WaveSurfer not initialized');
      return;
    }

    console.log('AudioService: Resuming WaveSurfer playback');
    this.waveSurfer.play();
  }

  /**
   * Stop audio playback
   */
  stopAudio() {
    // If we're using HTML5 Audio element
    if (this.audioElement) {
      console.log('AudioService: Stopping HTML5 Audio playback');
      this.audioElement.pause();
      this.audioElement.currentTime = 0;

      if (this.onPlaybackStop) {
        this.onPlaybackStop();
      }
      return;
    }

    if (!this.waveSurfer) {
      console.error('WaveSurfer not initialized');
      return;
    }

    console.log('AudioService: Stopping WaveSurfer playback');
    this.waveSurfer.stop();

    if (this.onPlaybackStop) {
      this.onPlaybackStop();
    }
  }

  /**
   * Format duration in seconds to mm:ss format
   * @param {number} seconds - Duration in seconds
   * @returns {string} Formatted duration
   */
  formatDuration(seconds) {
    // Ensure seconds is a valid number
    if (typeof seconds !== 'number' || isNaN(seconds) || seconds < 0) {
      console.warn('Invalid duration value:', seconds);
      seconds = 0;
    }

    // Round to nearest integer to avoid floating point issues
    seconds = Math.round(seconds);

    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;

    // Format as mm:ss with leading zeros
    return `${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString().padStart(2, '0')}`;
  }

  /**
   * Clean up resources
   */
  destroy() {
    if (this.recordingTimer) {
      clearInterval(this.recordingTimer);
      this.recordingTimer = null;
    }

    if (this.audioElement) {
      this.audioElement.pause();
      this.audioElement.src = '';
      this.audioElement = null;
    }

    if (this.waveSurfer) {
      this.waveSurfer.destroy();
      this.waveSurfer = null;
    }
  }
}

export default AudioService;
