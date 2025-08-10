import React, { useState, useRef, useEffect } from 'react';
import { FaPlay, FaPause } from 'react-icons/fa';
import { BASE_URL, fixLocalIpUrl, IMG_BASE_URL } from '../configs/app-global';
import './AudioWaveform.css';

/**
 * A dedicated audio player component that handles multiple formats and fallbacks
 *
 * @param {Object} props - Component props
 * @param {string} props.audioUrl - The URL of the audio file
 * @param {number} props.duration - The duration of the audio in seconds
 * @param {string} props.color - The color of the waveform
 * @param {Function} props.onError - Callback function when an error occurs
 */
const AudioPlayer = ({ audioUrl, duration = 0, color = '#4a76a8', onError }) => {
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [isLoaded, setIsLoaded] = useState(false);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  const audioRef = useRef(null);
  const progressBarRef = useRef(null);

  // Format duration in M:SS format (consistent with customer side)
  const formatTime = (seconds) => {
    if (typeof seconds !== 'number' || isNaN(seconds)) {
      seconds = 0;
    }
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  // Initialize audio element
  useEffect(() => {
    // Create audio element if it doesn't exist
    if (!audioRef.current) {
      audioRef.current = new Audio();

      // Set up event listeners
      audioRef.current.addEventListener('timeupdate', handleTimeUpdate);
      audioRef.current.addEventListener('ended', handleEnded);
      audioRef.current.addEventListener('canplaythrough', () => setIsLoaded(true));
      audioRef.current.addEventListener('error', handleError);
    }

    // Clean up on unmount
    return () => {
      if (audioRef.current) {
        audioRef.current.pause();
        audioRef.current.removeEventListener('timeupdate', handleTimeUpdate);
        audioRef.current.removeEventListener('ended', handleEnded);
        audioRef.current.removeEventListener('canplaythrough', () => setIsLoaded(true));
        audioRef.current.removeEventListener('error', handleError);
        audioRef.current = null;
      }
    };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Load audio when URL changes
  useEffect(() => {
    if (audioRef.current && audioUrl) {
      // Reset state
      setIsPlaying(false);
      setCurrentTime(0);
      setIsLoaded(false);
      setError(null);
      setLoading(false);

      // Validate URL before trying to load
      if (typeof audioUrl === 'string' && (audioUrl.startsWith('http://') || audioUrl.startsWith('https://'))) {
        console.log('Loading valid audio URL:', audioUrl);

        loadAudio(audioUrl);
      } else {
        console.error('Invalid audio URL:', audioUrl);
        setError('Invalid audio URL');
      }
    }
  }, [audioUrl]);

  // Handle time update
  const handleTimeUpdate = () => {
    if (audioRef.current) {
      setCurrentTime(audioRef.current.currentTime);
    }
  };

  // Handle playback ended
  const handleEnded = () => {
    setIsPlaying(false);
    setCurrentTime(0);
    if (audioRef.current) {
      audioRef.current.currentTime = 0;
    }
  };

  // Handle errors
  const handleError = (e) => {
    console.log('Audio error:', e);
    setError('Could not play audio');
    setIsLoaded(false);

    // Call the onError callback if provided
    if (typeof onError === 'function') {
      onError(e);
    }
  };

  // Load audio from URL with fallback logic
  const loadAudio = async (url) => {
    console.log('Loading audio from URL:', url);
    setLoading(true);
    setError(null); // Clear previous errors

    try {
      // Validate URL
      if (!url || typeof url !== 'string') {
        console.error('Invalid URL provided to loadAudio:', url);
        setError('Invalid audio URL');
        setLoading(false);
        return;
      }

      // Log the URL for debugging
      console.log('Original URL:', url);

      // Fix local storage URLs with incorrect IP
      if (url.includes('192.168.0.102:8000') || url.includes('192.168.0.106:8000') || url.includes('192.168.0.105:8000')) {
        // Use the fixLocalIpUrl function to handle IP address changes
        url = fixLocalIpUrl(url);

        // If the URL still contains an old IP, extract the path and use the current BASE_URL
        if (url.includes('192.168.0.102:8000') || url.includes('192.168.0.106:8000') || url.includes('192.168.0.105:8000')) {
          // Extract the path part after the domain
          const pathMatch = url.match(/\/storage\/(.+)/);
          if (pathMatch && pathMatch[1]) {
            const newUrl = `${BASE_URL}/storage/${pathMatch[1]}`;
            console.log('Corrected local URL:', newUrl);
            url = newUrl;
          }
        }
      }

      // Check file extension and add if missing (default to mp3)
      if (!url.match(/\.(mp3|aac|wav|m4a|ogg)($|\?)/i)) {
        console.log('URL has no audio extension, adding .mp3');
        url = url.includes('?') ? url.replace('?', '.mp3?') : `${url}.mp3`;
      }

      console.log('Final URL after format check:', url);

      // If URL is a pre-signed URL (contains Signature parameter), use fetch + blob approach
      if (url && (url.includes('Signature=') || url.includes('X-Amz-Signature'))) {
        console.log('Detected pre-signed URL, using fetch + blob approach');

        // Extract the base URL without query parameters
        let baseUrl = url;
        let queryParams = '';

        if (url.includes('?')) {
          baseUrl = url.split('?')[0];
          queryParams = url.substring(url.indexOf('?'));
        }

        // Ensure the URL has .mp3 extension
        if (!baseUrl.toLowerCase().endsWith('.mp3')) {
          baseUrl = baseUrl.replace(/\.[^.]+$/, '.mp3');
          if (!baseUrl.toLowerCase().endsWith('.mp3')) {
            baseUrl = `${baseUrl}.mp3`;
          }
        }

        // Reconstruct the URL with the MP3 extension and original query parameters
        const finalUrl = baseUrl + queryParams;
        console.log('Final pre-signed URL with MP3 extension:', finalUrl);

        // Use fetch to download the file
        try {
          setLoading(true);

          // Fetch the file
          fetch(finalUrl, {
            method: 'GET',
            headers: {
              'Accept': '*/*',
              'Origin': window.location.origin,
              'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            },
            mode: 'cors',
            cache: 'no-cache',
          })
          .then(response => {
            if (!response.ok) {
              throw new Error(`Failed to fetch audio: ${response.status} ${response.statusText}`);
            }
            return response.blob();
          })
          .then(blob => {
            console.log('Received blob:', blob.type, blob.size, 'bytes');

            // Create a new blob with explicit MIME type
            const audioBlob = new Blob([blob], { type: 'audio/mpeg' });
            console.log('Created audio blob with explicit MIME type:', audioBlob.type, audioBlob.size, 'bytes');

            // Create a blob URL
            const blobUrl = URL.createObjectURL(audioBlob);
            console.log('Created blob URL from pre-signed URL:', blobUrl);

            // Create a new audio element to test the blob
            const testAudio = new Audio();
            testAudio.src = blobUrl;

            // Test if the audio can be played
            testAudio.addEventListener('canplaythrough', () => {
              console.log('Test audio can play through, using blob URL');

              // Set the audio source to the blob URL
              audioRef.current.src = blobUrl;
              audioRef.current.load();

              // Set loaded state
              setIsLoaded(true);
              setLoading(false);
            });

            testAudio.addEventListener('error', (e) => {
              console.error('Test audio error:', e);

              // Fallback to direct URL
              console.log('Falling back to direct URL approach');
              audioRef.current.crossOrigin = 'anonymous';

              // Extract the base URL without query parameters
              let baseUrl = url;
              if (url.includes('?')) {
                baseUrl = url.split('?')[0];
              }

              // Add cache buster
              const cacheBuster = Date.now();
              const directUrl = `${baseUrl}?cb=${cacheBuster}`;

              console.log('Using direct URL with cache buster:', directUrl);
              audioRef.current.src = directUrl;
              audioRef.current.load();

              // Set loaded state
              setIsLoaded(true);
              setLoading(false);
            });

            // Load the test audio
            testAudio.load();

            // Set a timeout to avoid hanging forever
            setTimeout(() => {
              console.log('Setting loaded state after timeout for blob URL');
              setIsLoaded(true);
              setLoading(false);
            }, 3000);
          })
          .catch(error => {
            console.error('Error fetching audio:', error);
            setError('Failed to load audio');
            setIsLoaded(false);
            setLoading(false);
          });
        } catch (e) {
          console.error('Error in fetch + blob approach:', e);
          setError('Failed to load audio');
          setIsLoaded(false);
          setLoading(false);
        }

        return;
      }

      // For S3 URLs, use fetch + blob approach (same as pre-signed URLs)
      if (url && (url.includes('s3.') || url.includes('amazonaws.com'))) {
        console.log('Detected S3 URL, using fetch + blob approach');

        // Make sure the URL has MP3 extension
        let baseUrl = url;

        // Extract the base URL without query parameters
        if (url.includes('?')) {
          baseUrl = url.substring(0, url.indexOf('?'));
        }

        // Ensure the URL has .mp3 extension
        if (!baseUrl.toLowerCase().endsWith('.mp3')) {
          baseUrl = baseUrl.replace(/\.[^.]+$/, '.mp3');
          if (!baseUrl.toLowerCase().endsWith('.mp3')) {
            baseUrl = `${baseUrl}.mp3`;
          }
        }

        // Add cache buster to avoid caching issues
        const cacheBuster = Date.now();
        const finalUrl = `${baseUrl}?cb=${cacheBuster}`;

        console.log('Final S3 URL with MP3 extension and cache buster:', finalUrl);

        // Use fetch to download the file
        try {
          setLoading(true);

          // Fetch the file
          fetch(finalUrl, {
            method: 'GET',
            headers: {
              'Accept': '*/*',
              'Origin': window.location.origin,
              'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            },
            mode: 'cors',
            cache: 'no-cache',
          })
          .then(response => {
            if (!response.ok) {
              throw new Error(`Failed to fetch audio: ${response.status} ${response.statusText}`);
            }
            console.log('S3 fetch successful, getting blob...');
            return response.blob();
          })
          .then(blob => {
            console.log('Received blob from S3:', blob.type, blob.size, 'bytes');

            // Create a new blob with explicit MIME type
            const audioBlob = new Blob([blob], { type: 'audio/mpeg' });
            console.log('Created audio blob with explicit MIME type:', audioBlob.type, audioBlob.size, 'bytes');

            // Create a blob URL
            const blobUrl = URL.createObjectURL(audioBlob);
            console.log('Created blob URL from S3 URL:', blobUrl);

            // Create a new audio element to test the blob
            const testAudio = new Audio();
            testAudio.src = blobUrl;

            // Test if the audio can be played
            testAudio.addEventListener('canplaythrough', () => {
              console.log('Test audio can play through, using blob URL');

              // Set the audio source to the blob URL
              audioRef.current.src = blobUrl;
              audioRef.current.load();

              // Set loaded state
              setIsLoaded(true);
              setLoading(false);
            });

            testAudio.addEventListener('error', (e) => {
              console.error('Test audio error:', e);

              // Fallback to direct URL
              console.log('Falling back to direct URL approach');
              audioRef.current.crossOrigin = 'anonymous';

              // Extract the base URL without query parameters
              let baseUrl = url;
              if (url.includes('?')) {
                baseUrl = url.split('?')[0];
              }

              // Add cache buster
              const cacheBuster = Date.now();
              const directUrl = `${baseUrl}?cb=${cacheBuster}`;

              console.log('Using direct URL with cache buster:', directUrl);
              audioRef.current.src = directUrl;
              audioRef.current.load();

              // Set loaded state
              setIsLoaded(true);
              setLoading(false);
            });

            // Load the test audio
            testAudio.load();

            // Set a timeout to avoid hanging forever
            setTimeout(() => {
              console.log('Setting loaded state after timeout for blob URL');
              setIsLoaded(true);
              setLoading(false);
            }, 3000);
          })
          .catch(error => {
            console.error('Error fetching audio from S3:', error);

            // Fallback to direct URL approach
            console.log('Falling back to direct URL approach');
            audioRef.current.crossOrigin = 'anonymous';
            audioRef.current.src = finalUrl;
            audioRef.current.load();

            // Set a timeout to avoid hanging forever
            setTimeout(() => {
              console.log('Setting loaded state after timeout for direct URL fallback');
              setIsLoaded(true);
              setLoading(false);
            }, 3000);
          });
        } catch (e) {
          console.error('Error in fetch + blob approach for S3:', e);
          setError('Failed to load audio');
          setIsLoaded(false);
          setLoading(false);
        }

        return;
      }

      // For non-S3 URLs, handle local URLs specially
      const directUrl = url;
      const isLocalUrl = directUrl.includes('localhost') || directUrl.includes('192.168.') || directUrl.includes('/storage/');
      const directUrlWithCacheBuster = `${directUrl}${directUrl.includes('?') ? '&' : '?'}cb=${Date.now()}`;

      console.log('Trying direct access:', directUrlWithCacheBuster);

      // For local URLs, try to use a proxy approach
      if (isLocalUrl) {
        try {
          // Try to access the file directly first with a GET request
          const response = await fetch(directUrlWithCacheBuster, {
            mode: 'cors',
            headers: {
              'Cache-Control': 'no-cache',
              'Accept': '*/*'
            }
          });

          if (response.ok) {
            console.log('Direct access successful');

            try {
              const blob = await response.blob();
              const blobUrl = URL.createObjectURL(new Blob([blob], { type: 'audio/mpeg' }));
              console.log('Created blob URL from local URL:', blobUrl);

              audioRef.current.src = blobUrl;
              audioRef.current.load();
              setIsLoaded(true);
              setLoading(false);
              return;
            } catch (blobError) {
              console.error('Error creating blob URL:', blobError);
              // Fall back to direct URL if blob creation fails
            }
          } else {
            console.error('Direct access failed with status:', response.status);

            // If the URL contains /storage/, try to modify it to use the correct base URL
            if (directUrl.includes('/storage/')) {
              // Extract the path after /storage/
              const storagePath = directUrl.split('/storage/')[1];

              // Try different base URLs
              const baseUrls = [
                `${BASE_URL}/storage/`,
                `${window.location.origin}/storage/`,
                `${BASE_URL}/storage/`, // Use centralized BASE_URL instead of hardcoded IP
                `${BASE_URL}/storage/`  // Use centralized BASE_URL instead of hardcoded IP
              ];

              console.log('Trying alternative base URLs for storage path:', storagePath);

              for (const baseUrl of baseUrls) {
                const alternativeUrl = `${baseUrl}${storagePath}`;
                console.log('Trying alternative URL:', alternativeUrl);

                try {
                  const altResponse = await fetch(alternativeUrl, {
                    mode: 'cors',
                    headers: {
                      'Cache-Control': 'no-cache',
                      'Accept': '*/*'
                    }
                  });

                  if (altResponse.ok) {
                    console.log('Alternative URL access successful');

                    const blob = await altResponse.blob();
                    const blobUrl = URL.createObjectURL(new Blob([blob], { type: 'audio/mpeg' }));
                    console.log('Created blob URL from alternative URL:', blobUrl);

                    audioRef.current.src = blobUrl;
                    audioRef.current.load();
                    setIsLoaded(true);
                    setLoading(false);
                    return;
                  }
                } catch (altError) {
                  console.error('Alternative URL access failed:', altError);
                }
              }
            }
          }
        } catch (directError) {
          console.error('Direct access failed:', directError);
        }
      } else {
        // For non-local URLs, use standard approach
        try {
          // Try to access the file directly
          const response = await fetch(directUrlWithCacheBuster, {
            mode: 'cors',
            headers: {
              'Cache-Control': 'no-cache',
              'Accept': '*/*'
            }
          });

          if (response.ok) {
            console.log('Direct access successful for non-local URL');

            audioRef.current.src = directUrlWithCacheBuster;
            audioRef.current.load();
            setIsLoaded(true);
            setLoading(false);
            return;
          }
        } catch (directError) {
          console.error('Direct access failed for non-local URL:', directError);
        }
      }

      // If all methods fail, show error
      console.error('All access methods failed for audio URL:', url);
      setError('Failed to load audio file. Please try again later.');
      setIsLoaded(false);
      setLoading(false);

      // Call the onError callback if provided
      if (typeof onError === 'function') {
        onError(new Error('Failed to load audio file'));
      }
    } catch (error) {
      console.error('Error loading audio:', error);
      setError('Failed to load audio file. Please try again later.');
      setIsLoaded(false);
      setLoading(false);

      // Call the onError callback if provided
      if (typeof onError === 'function') {
        onError(error);
      }
    }
  };

  // Toggle play/pause
  const togglePlay = () => {
    if (!audioRef.current) {
      console.error('Audio element not initialized');
      return;
    }

    if (isPlaying) {
      audioRef.current.pause();
      setIsPlaying(false);
    } else {
      try {
        // Check if the audio element has a valid source
        if (!audioRef.current.src) {
          console.error('Audio element has no source');
          setError('Audio source not available');
          return;
        }

        // Check if the audio element is ready to play
        if (audioRef.current.readyState === 0) {
          console.log('Audio not ready, trying to load first');
          audioRef.current.load();

          // Wait for the audio to be loaded
          audioRef.current.oncanplay = () => {
            console.log('Audio can play now, playing...');
            const playPromise = audioRef.current.play();
            if (playPromise !== undefined) {
              playPromise
                .then(() => {
                  console.log('Audio playing successfully');
                  setIsPlaying(true);
                })
                .catch(error => {
                  console.error('Error playing audio after load:', error);
                  setError('Failed to play audio');

                  // Try one more time with a direct URL
                  tryDirectUrlFallback();
                });
            }
          };

          // Set a timeout in case oncanplay never fires
          setTimeout(() => {
            if (!isPlaying) {
              console.log('Audio load timeout, trying to play anyway');
              const playPromise = audioRef.current.play();
              if (playPromise !== undefined) {
                playPromise
                  .then(() => {
                    console.log('Audio playing successfully after timeout');
                    setIsPlaying(true);
                  })
                  .catch(error => {
                    console.error('Error playing audio after timeout:', error);
                    setError('Failed to play audio');

                    // Try one more time with a direct URL
                    tryDirectUrlFallback();
                  });
              }
            }
          }, 2000);
        } else {
          // Audio is ready, play it
          const playPromise = audioRef.current.play();
          if (playPromise !== undefined) {
            playPromise
              .then(() => {
                console.log('Audio playing successfully');
                setIsPlaying(true);
              })
              .catch(error => {
                console.error('Error playing audio:', error);
                setError('Failed to play audio');

                // Try one more time with a direct URL
                tryDirectUrlFallback();
              });
          }
        }
      } catch (error) {
        console.error('Unexpected error in togglePlay:', error);
        setError('Unexpected error playing audio');
      }
    }
  };

  // Try to play audio with a direct URL as a last resort
  const tryDirectUrlFallback = () => {
    try {
      console.log('Trying direct URL fallback');

      // Get the original URL
      let originalUrl = audioUrl;

      // Make sure it has MP3 extension
      if (!originalUrl.toLowerCase().endsWith('.mp3')) {
        originalUrl = originalUrl.replace(/\.[^.]+$/, '.mp3');
        if (!originalUrl.toLowerCase().endsWith('.mp3')) {
          originalUrl = `${originalUrl}.mp3`;
        }
      }

      // Add cache buster
      const cacheBuster = Date.now();
      const directUrl = `${originalUrl}${originalUrl.includes('?') ? '&' : '?'}cb=${cacheBuster}`;

      console.log('Using direct URL fallback:', directUrl);

      // Create a new audio element
      const newAudio = new Audio();
      newAudio.crossOrigin = 'anonymous';
      newAudio.src = directUrl;

      // Try to play it
      newAudio.oncanplay = () => {
        console.log('Fallback audio can play, replacing current audio');

        // Replace the current audio
        if (audioRef.current) {
          audioRef.current.src = directUrl;
          audioRef.current.load();
          audioRef.current.play()
            .then(() => {
              console.log('Fallback audio playing successfully');
              setIsPlaying(true);
            })
            .catch(error => {
              console.error('Error playing fallback audio:', error);
              setError('Failed to play audio after all attempts');
            });
        }
      };

      newAudio.onerror = (error) => {
        console.error('Error with fallback audio:', error);
        setError('Failed to play audio after all attempts');
      };

      newAudio.load();
    } catch (error) {
      console.error('Error in direct URL fallback:', error);
      setError('Failed to play audio after all attempts');
    }
  };

  // Handle progress bar click
  const handleProgressClick = (e) => {
    if (!audioRef.current || !progressBarRef.current) return;

    const rect = progressBarRef.current.getBoundingClientRect();
    const clickPosition = (e.clientX - rect.left) / rect.width;
    const newTime = clickPosition * (duration || audioRef.current.duration || 0);

    audioRef.current.currentTime = newTime;
    setCurrentTime(newTime);
  };

  // Calculate progress percentage
  const progressPercentage = () => {
    if (!audioRef.current) return 0;

    const audioDuration = duration || audioRef.current.duration || 0;
    if (audioDuration <= 0) return 0;

    return (currentTime / audioDuration) * 100;
  };

  // Generate waveform bars
  const generateWaveform = () => {
    const barCount = 30;
    const bars = [];

    for (let i = 0; i < barCount; i++) {
      // Create a pattern of bar heights that looks like a waveform
      const position = i / barCount;

      // Calculate a height based on position and a sine wave pattern
      const wave1 = Math.sin(position * Math.PI * 5) * 0.5 + 0.5;
      const wave2 = Math.sin(position * Math.PI * 7) * 0.3 + 0.5;
      const wave3 = Math.sin(position * Math.PI * 13) * 0.2 + 0.5;

      // Combine waves for a more natural look
      let heightPercentage = 0.3 + 0.7 * ((wave1 + wave2 + wave3) / 3);

      // Make some random variations to look more natural
      if (i % 5 === 0) heightPercentage *= 0.7;
      if (i % 7 === 0) heightPercentage *= 1.3;

      // Clamp height to reasonable values
      heightPercentage = Math.max(0.2, Math.min(1.0, heightPercentage));

      // Calculate if this bar should be highlighted (for playback progress)
      const isHighlighted = (i / barCount) <= (progressPercentage() / 100);

      bars.push(
        <div
          key={i}
          className={`audio-waveform__bar ${isHighlighted ? 'audio-waveform__bar--highlighted' : ''}`}
          style={{
            height: `${28 * heightPercentage}px`,
            backgroundColor: isHighlighted ? '#000000' : color, // Black for played portion, white for unplayed portion
          }}
        />
      );
    }

    return bars;
  };

  return (
    <div className="voice-message-bubble">
      <button
        className="voice-message-bubble__play-button"
        onClick={togglePlay}
        disabled={!isLoaded && !error}
        aria-label={isPlaying ? 'Pause' : 'Play'}
      >
        {isPlaying ? <FaPause /> : <FaPlay />}
      </button>

      <div className="voice-message-bubble__content">
        <div
          className="voice-message-bubble__waveform-container"
          ref={progressBarRef}
          onClick={handleProgressClick}
        >
          <div
            className="voice-message-bubble__progress-bar"
            style={{ width: `${progressPercentage()}%` }}
          />
          <div className="voice-message-bubble__waveform">
            {generateWaveform()}
          </div>
        </div>

        <div className="voice-message-bubble__duration" style={{ fontSize: '10px', fontWeight: '500' }}>
          {formatTime(currentTime)} / {formatTime(duration || (audioRef.current?.duration || 0))}
        </div>
      </div>

      {error && (
        <div className="voice-message-bubble__error" style={{ color: 'red', fontSize: '10px' }}>
          {error}
        </div>
      )}
    </div>
  );
};

export default AudioPlayer;
