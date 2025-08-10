// AudioService.js - Service for audio recording and playback

import WaveSurfer from 'wavesurfer.js';
import { ReactMic } from 'react-mic';
import { toast } from 'react-toastify';

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
    this.maxRecordingDuration = 120; // Maximum recording duration in seconds (2 minutes)

    // Event listeners
    this.onRecordingStart = null;
    this.onRecordingStop = null;
    this.onDurationChange = null;
    this.onPlaybackStart = null;
    this.onPlaybackStop = null;
    this.onPlaybackProgress = null;
    this.onMaxDurationReached = null;
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

        // Check if max duration reached
        if (this.recordingDuration >= this.maxRecordingDuration) {
          console.log('AudioService: Maximum recording duration reached');
          if (this.onMaxDurationReached) {
            this.onMaxDurationReached();
          }
          this.stopRecording();
          return;
        }

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

        // Check if max duration reached
        if (this.recordingDuration >= this.maxRecordingDuration) {
          console.log('AudioService: Maximum recording duration reached');
          if (this.onMaxDurationReached) {
            this.onMaxDurationReached();
          }
          this.stopRecording();
          return;
        }

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
    let originalBlob = null;

    // If source is a Blob, create an object URL
    if (source instanceof Blob) {
      originalBlob = source;

      // Check if we need to convert the blob format
      if (source.type !== 'audio/mpeg' && source.type !== 'audio/mp3') {
        console.log('AudioService: Converting blob to MP3 format');
        // Create a new blob with MP3 MIME type
        const mp3Blob = new Blob([source], { type: 'audio/mpeg' });
        audioUrl = URL.createObjectURL(mp3Blob);
        console.log('AudioService: Created MP3 blob URL:', audioUrl);
      } else {
        audioUrl = URL.createObjectURL(source);
        console.log('AudioService: Created object URL for blob:', audioUrl);
      }
    }

    // Create or reuse audio element
    if (!this.audioElement) {
      console.log('AudioService: Creating new HTML5 Audio element');
      this.audioElement = new Audio();

      // Set up event listeners
      this.audioElement.onplay = () => {
        console.log('AudioService: Playback started');
        if (this.onPlaybackStart) this.onPlaybackStart();
      };

      this.audioElement.onpause = () => {
        console.log('AudioService: Playback paused');
        if (this.onPlaybackStop) this.onPlaybackStop();
      };

      this.audioElement.onended = () => {
        console.log('AudioService: Playback ended');
        if (this.onPlaybackStop) this.onPlaybackStop();
      };

      this.audioElement.ontimeupdate = () => {
        const progress = this.audioElement.currentTime;
        if (this.onPlaybackProgress) this.onPlaybackProgress(progress);
      };

      this.audioElement.onerror = (e) => {
        console.error('AudioService: HTML5 Audio error:', e);
        console.log('AudioService: Error details:', e.target.error);

        // If there's an error with the audio URL, try different formats
        if (typeof audioUrl === 'string') {
          // First try: If it's a blob URL and we have the original blob, try with the original format
          if (audioUrl.startsWith('blob:') && originalBlob) {
            console.log('AudioService: Trying with original blob format');
            const originalUrl = URL.createObjectURL(originalBlob);
            this.audioElement.src = originalUrl;
            this.audioElement.type = originalBlob.type;
            this.audioElement.play().catch(error => {
              console.error('AudioService: Original blob format error:', error);

              // Second try: Try with WebM format
              if (originalBlob.type !== 'audio/webm') {
                const webmBlob = new Blob([originalBlob], { type: 'audio/webm' });
                const webmUrl = URL.createObjectURL(webmBlob);
                console.log('AudioService: Trying WebM format');
                this.audioElement.src = webmUrl;
                this.audioElement.type = 'audio/webm';
                this.audioElement.play().catch(err => {
                  console.error('AudioService: WebM fallback error:', err);
                  this.tryProxyFallback(audioUrl);
                });
              } else {
                this.tryProxyFallback(audioUrl);
              }
            });
            return;
          }

          // Check if the URL is an AAC file and try to convert it to MP3
          if (audioUrl.endsWith('.aac')) {
            const mp3Url = audioUrl.replace('.aac', '.mp3');
            console.log('AudioService: Trying MP3 URL instead:', mp3Url);
            this.audioElement.src = mp3Url;
            this.audioElement.type = "audio/mpeg";
            this.audioElement.play().catch(error => {
              console.error('AudioService: MP3 fallback error:', error);
              this.tryProxyFallback(audioUrl);
            });
            return;
          }

          // If it's already MP3 but still failing, try proxy
          if (audioUrl.endsWith('.mp3')) {
            this.tryProxyFallback(audioUrl);
            return;
          }
        }

        // If all else fails, show error
        toast.error('Error playing audio file');
      };
    }

    // Set the source and play
    // Add a cache-busting parameter to avoid browser caching issues
    const cacheBuster = `?cb=${Date.now()}`;
    const finalUrl = typeof audioUrl === 'string' ? audioUrl + cacheBuster : audioUrl;
    this.audioElement.src = finalUrl;
    this.audioElement.crossOrigin = "anonymous"; // Add CORS support for cross-origin audio

    // Set MIME type explicitly to help browser identify the content
    // Default to MP3 for URLs, use the blob's type for blobs
    if (originalBlob) {
      this.audioElement.type = originalBlob.type;
    } else {
      this.audioElement.type = "audio/mpeg";
    }

    // Play with a small delay to ensure the src is set
    setTimeout(() => {
      const playPromise = this.audioElement.play();

      // Handle play promise (required for modern browsers)
      if (playPromise !== undefined) {
        playPromise.catch(error => {
          console.error('AudioService: Play promise error:', error);

          // Try different approaches to play the audio
          if (originalBlob) {
            // Try with WebM format if we have the original blob
            const webmBlob = new Blob([originalBlob], { type: 'audio/webm' });
            const webmUrl = URL.createObjectURL(webmBlob);
            console.log('AudioService: Trying WebM format');
            this.audioElement.src = webmUrl;
            this.audioElement.type = 'audio/webm';
            this.audioElement.play().catch(err => {
              console.error('AudioService: WebM fallback error:', err);
              toast.error('Error playing audio file');
            });
          } else if (typeof audioUrl === 'string') {
            // First approach: Try with MP3 extension if it's AAC
            if (audioUrl.endsWith('.aac')) {
              const mp3Url = audioUrl.replace('.aac', '.mp3');
              console.log('AudioService: Trying MP3 URL instead:', mp3Url);
              this.audioElement.src = mp3Url + `?cb=${Date.now()}`;
              this.audioElement.type = "audio/mpeg";
              this.audioElement.play().catch(err => {
                console.error('AudioService: MP3 fallback error:', err);
                this.tryProxyFallback(audioUrl);
              });
            }
            // If it's already MP3 but still failing, try proxy
            else if (audioUrl.endsWith('.mp3')) {
              this.tryProxyFallback(audioUrl);
            }
            else {
              toast.error('Error playing audio file');
            }
          } else {
            toast.error('Error playing audio file');
          }
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
   * Format duration in seconds to m:ss format (without leading zero for minutes)
   * @param {number} seconds - Duration in seconds
   * @returns {string} Formatted duration
   */
  formatDuration(seconds) {
    // Ensure seconds is a valid number
    if (typeof seconds !== 'number' || isNaN(seconds) || seconds < 0) {
      console.warn('Invalid duration value:', seconds);
      // Default to 0 instead of throwing an error
      seconds = 0;
    }

    // Convert to number if it's a string
    if (typeof seconds === 'string') {
      seconds = parseFloat(seconds);
    }

    // Round to nearest integer to avoid floating point issues
    seconds = Math.round(seconds);

    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;

    // Format as m:ss without leading zero for minutes
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  }

  /**
   * Try to play audio through a proxy to avoid CORS issues
   * @param {string} audioUrl - The original audio URL
   */
  tryProxyFallback(audioUrl) {
    console.log('AudioService: Trying proxy fallback for URL:', audioUrl);

    // Create a Blob from the audio URL using fetch
    fetch(audioUrl, {
      mode: 'cors',
      cache: 'no-cache',
      headers: {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return response.blob();
    })
    .then(blob => {
      // Create a local URL from the blob
      const blobUrl = URL.createObjectURL(blob);
      console.log('AudioService: Created blob URL:', blobUrl);

      // Play the local blob URL
      this.audioElement.src = blobUrl;
      this.audioElement.type = "audio/mpeg";
      return this.audioElement.play();
    })
    .catch(error => {
      console.error('AudioService: Proxy fallback error:', error);

      // Final fallback: Try to use a server-side proxy if available
      const proxyUrl = `/api/proxy-audio?url=${encodeURIComponent(audioUrl)}`;
      console.log('AudioService: Trying server proxy:', proxyUrl);

      this.audioElement.src = proxyUrl;
      this.audioElement.play().catch(err => {
        console.error('AudioService: Server proxy error:', err);
        toast.error('Error playing audio file');
      });
    });
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
