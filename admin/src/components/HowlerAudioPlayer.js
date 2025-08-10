import React, { useState, useEffect, useRef } from 'react';
import { Howl } from 'howler';
import { FaPlay, FaPause } from 'react-icons/fa';
import { BASE_URL } from '../configs/app-global';
import './AudioWaveform.css';
import './VoiceLoadingStates.css';

/**
 * A dedicated audio player component using Howler.js
 *
 * @param {Object} props - Component props
 * @param {string} props.url - URL of the audio file
 * @param {number} props.duration - Duration of the audio in seconds
 * @param {string} props.color - Color of the waveform
 * @param {Function} props.onError - Callback when an error occurs
 */
// Professional Voice Message Caching System
class VoiceMessageCache {
  constructor() {
    this.cache = new Map();
    this.maxCacheSize = 50; // Maximum 50 voice messages in cache
    this.maxCacheAge = 24 * 60 * 60 * 1000; // 24 hours in milliseconds
  }

  generateCacheKey(url) {
    // Create a unique key based on URL
    return btoa(url).replace(/[^a-zA-Z0-9]/g, '').substring(0, 32);
  }

  async cacheVoiceMessage(url, audioBlob) {
    try {
      const cacheKey = this.generateCacheKey(url);
      const cacheData = {
        blob: audioBlob,
        timestamp: Date.now(),
        url: url,
        size: audioBlob.size
      };

      // Store in memory cache
      this.cache.set(cacheKey, cacheData);

      // Clean up old cache entries
      this.cleanupCache();

      // Try to store in IndexedDB for persistent storage
      if ('indexedDB' in window) {
        await this.storeInIndexedDB(cacheKey, cacheData);
      }

      console.log(`✅ Voice message cached: ${cacheKey} (${(audioBlob.size / 1024).toFixed(1)}KB)`);
      return true;
    } catch (error) {
      console.error('❌ Failed to cache voice message:', error);
      return false;
    }
  }

  async getCachedVoiceMessage(url) {
    try {
      const cacheKey = this.generateCacheKey(url);
      
      // First check memory cache
      let cacheData = this.cache.get(cacheKey);
      
      // If not in memory, try IndexedDB
      if (!cacheData && 'indexedDB' in window) {
        cacheData = await this.getFromIndexedDB(cacheKey);
        if (cacheData) {
          // Add back to memory cache
          this.cache.set(cacheKey, cacheData);
        }
      }

      // Check if cache is still valid
      if (cacheData) {
        const age = Date.now() - cacheData.timestamp;
        if (age > this.maxCacheAge) {
          console.log('🗑️ Cache expired, removing:', cacheKey);
          this.removeCachedMessage(cacheKey);
          return null;
        }

        console.log(`✅ Voice message found in cache: ${cacheKey}`);
        return URL.createObjectURL(cacheData.blob);
      }

      return null;
    } catch (error) {
      console.error('❌ Failed to get cached voice message:', error);
      return null;
    }
  }

  cleanupCache() {
    // Remove oldest entries if cache is too large
    if (this.cache.size > this.maxCacheSize) {
      const entries = Array.from(this.cache.entries());
      entries.sort((a, b) => a[1].timestamp - b[1].timestamp);
      
      const entriesToRemove = entries.slice(0, entries.length - this.maxCacheSize);
      entriesToRemove.forEach(([key]) => {
        this.cache.delete(key);
        console.log('🗑️ Removed old cache entry:', key);
      });
    }
  }

  async storeInIndexedDB(cacheKey, cacheData) {
    return new Promise((resolve, reject) => {
      const request = indexedDB.open('VoiceMessageCache', 1);
      
      request.onerror = () => reject(request.error);
      request.onsuccess = () => {
        const db = request.result;
        const transaction = db.transaction(['voiceMessages'], 'readwrite');
        const store = transaction.objectStore('voiceMessages');
        
        const storeData = {
          id: cacheKey,
          ...cacheData
        };
        
        store.put(storeData);
        transaction.oncomplete = () => resolve();
        transaction.onerror = () => reject(transaction.error);
      };
      
      request.onupgradeneeded = (event) => {
        const db = event.target.result;
        if (!db.objectStoreNames.contains('voiceMessages')) {
          const store = db.createObjectStore('voiceMessages', { keyPath: 'id' });
          store.createIndex('timestamp', 'timestamp', { unique: false });
        }
      };
    });
  }

  async getFromIndexedDB(cacheKey) {
    return new Promise((resolve, reject) => {
      const request = indexedDB.open('VoiceMessageCache', 1);
      
      request.onerror = () => reject(request.error);
      request.onsuccess = () => {
        const db = request.result;
        const transaction = db.transaction(['voiceMessages'], 'readonly');
        const store = transaction.objectStore('voiceMessages');
        const getRequest = store.get(cacheKey);
        
        getRequest.onsuccess = () => {
          const result = getRequest.result;
          if (result) {
            resolve({
              blob: result.blob,
              timestamp: result.timestamp,
              url: result.url,
              size: result.size
            });
          } else {
            resolve(null);
          }
        };
        
        getRequest.onerror = () => reject(getRequest.error);
      };
    });
  }

  removeCachedMessage(cacheKey) {
    this.cache.delete(cacheKey);
    
    // Remove from IndexedDB too
    if ('indexedDB' in window) {
      const request = indexedDB.open('VoiceMessageCache', 1);
      request.onsuccess = () => {
        const db = request.result;
        const transaction = db.transaction(['voiceMessages'], 'readwrite');
        const store = transaction.objectStore('voiceMessages');
        store.delete(cacheKey);
      };
    }
  }
}

// Global cache instance
const voiceCache = new VoiceMessageCache();

// 🎯 GLOBAL MESSAGE LOADING TRACKER: Prevent duplicate loading
const loadedVoiceMessages = new Set();

// 🎯 HELPER FUNCTION: Check if message should load
const shouldLoadVoiceMessage = (messageId, url) => {
  const uniqueKey = `${messageId}_${url}`;
  
  if (!loadedVoiceMessages.has(uniqueKey)) {
    loadedVoiceMessages.add(uniqueKey);
    console.log('🆕 New voice message will load:', uniqueKey);
    return true;
  }
  
  console.log('✅ Voice message already loaded, skipping:', uniqueKey);
  return false;
};

const HowlerAudioPlayer = ({ url, duration = 0, color = '#ADFF2F', onError, onLoad, messageId }) => {
  const [isPlaying, setIsPlaying] = useState(false);
  const [isLoaded, setIsLoaded] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [isDownloading, setIsDownloading] = useState(false);
  const [downloadProgress, setDownloadProgress] = useState(0);
  const [currentTime, setCurrentTime] = useState(0);
  const [error, setError] = useState(null);
  const [howl, setHowl] = useState(null);
  const [actualDuration, setActualDuration] = useState(duration);
  const [cachedUrl, setCachedUrl] = useState(null); // Track cached URL
  const progressBarRef = useRef(null);
  const requestRef = useRef(null);
  const soundId = useRef(null);
  const isMountedRef = useRef(true);
  const loadingTimeoutRef = useRef(null);

  // Format time in M:SS format (consistent with customer side)
  const formatTime = (seconds) => {
    if (isNaN(seconds) || seconds < 0) return '0:00';
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  // Professional audio loading with caching support
  const loadAudioWithCache = async (audioUrl) => {
    try {
      console.log('🎵 Loading audio:', audioUrl);
      
      // Check cache first (only for remote URLs)
      if (audioUrl.startsWith('http')) {
        setIsDownloading(true);
        const cachedUrl = await voiceCache.getCachedVoiceMessage(audioUrl);
        
        if (cachedUrl) {
          console.log('⚡ Using cached audio');
          setIsDownloading(false);
          return cachedUrl;
        }
        
        // Download and cache the audio
        console.log('📥 Downloading audio for caching...');
        try {
          const response = await fetch(audioUrl);
          if (response.ok) {
            const audioBlob = await response.blob();
            const blobUrl = URL.createObjectURL(audioBlob);
            
            // Cache the audio blob for future use
            await voiceCache.cacheVoiceMessage(audioUrl, audioBlob);
            console.log('💾 Audio cached successfully');
            
            setIsDownloading(false);
            return blobUrl;
          }
        } catch (downloadError) {
          console.warn('⚠️ Cache download failed, using direct URL:', downloadError);
          setIsDownloading(false);
        }
      }
      
      // Use original URL if caching fails or for local URLs
      return audioUrl;
    } catch (error) {
      console.error('❌ Error in loadAudioWithCache:', error);
      setIsDownloading(false);
      return audioUrl;
    }
  };

  // Professional loading state manager
  const loadingStateRef = useRef({
    isLoading: false,
    url: null,
    sound: null
  });

  // Load audio when URL changes
  useEffect(() => {
    if (!url) {
      setIsLoading(false);
      setError('No audio URL provided');
      return;
    }

    // 🚫 PREVENT DUPLICATE LOADING: Check if same URL is already loading
    if (loadingStateRef.current.isLoading && loadingStateRef.current.url === url) {
      console.log('⚠️ Audio already loading for this URL, skipping duplicate request');
      return;
    }

    // 🚫 PREVENT RE-LOADING: Check if same URL is already loaded successfully
    if (isLoaded && howl && loadingStateRef.current.url === url && !error) {
      console.log('✅ Audio already loaded for this URL, skipping reload');
      return;
    }

    // 🔒 CRITICAL: Preserve loaded state for old messages during Redux updates
    if (howl && loadingStateRef.current.url === url && isLoaded && !isLoading) {
      console.log('🔒 Preserving loaded state for already loaded message:', url);
      return;
    }

    console.log('🎵 Starting fresh audio load for:', url);
    
    // Mark as loading to prevent duplicates
    loadingStateRef.current.isLoading = true;
    loadingStateRef.current.url = url;

    // Reset all states properly
    setIsLoading(true);
    setIsDownloading(false);
    setDownloadProgress(0);
    setError(null);
    setIsPlaying(false);
    setCurrentTime(0);
    setActualDuration(duration);
    setCachedUrl(null);
    setIsLoaded(false);

    // Clear any existing timeouts
    if (loadingTimeoutRef.current) {
      clearTimeout(loadingTimeoutRef.current);
      loadingTimeoutRef.current = null;
    }

    // Clean up previous Howl instance
    if (howl) {
      try {
        howl.unload();
        setHowl(null);
      } catch (error) {
        console.error('Error unloading previous Howl instance:', error);
      }
    }

    // ✅ SIMPLIFIED: Determine the best URL to use
    let primaryUrl = url;
    let fallbackUrl = null;

    // For S3 URLs - use directly as primary
    if (url.includes('amazonaws.com') || url.includes('s3.')) {

      primaryUrl = url;

      // Extract chat ID and filename for proxy fallback
      const s3Match = url.match(/media\/voice_messages\/([^\/]+)\/([^\/]+)/);
      if (s3Match && s3Match.length >= 3) {
        const chatId = s3Match[1];
        const filename = s3Match[2];
        fallbackUrl = `${BASE_URL}/api/proxy/voice-message/${chatId}/${filename}`;

      }
    }
    // For local storage paths - use proxy as primary
    else if (url.includes('/storage/voice_messages/')) {
      const localMatch = url.match(/\/storage\/voice_messages\/([^\/]+)\/([^\/]+)/);
      if (localMatch && localMatch.length >= 3) {
        const chatId = localMatch[1];
        const filename = localMatch[2];
        primaryUrl = `${BASE_URL}/api/proxy/voice-message/${chatId}/${filename}`;
        console.log('✅ Local storage detected - using proxy as primary:', primaryUrl);
      }
    }
    // For other URLs - use as is
    else {
      console.log('✅ Using original URL as-is:', url);
      primaryUrl = url;
    }

    // ✅ ADD CACHE BUSTING FOR FRESH UPLOADS
    const addCacheBuster = (url) => {
      if (!url) return url;
      const separator = url.includes('?') ? '&' : '?';
      return `${url}${separator}cb=${Date.now()}&t=${Math.random()}`;
    };

    // ✅ SIMPLIFIED: Create sources array with primary and fallback
    const sources = [addCacheBuster(primaryUrl)];
    if (fallbackUrl) {
      sources.push(addCacheBuster(fallbackUrl));
    }



    // ✅ SIMPLIFIED: Create Howler instance with minimal configuration
    const sound = new Howl({
      src: sources,
      html5: true,
      format: ['wav', 'mp3', 'm4a', 'ogg'],
      onload: () => {
        if (!isMountedRef.current) return;

        console.log('🎵 Audio successfully loaded for URL:', primaryUrl);

        // ✅ CLEAR TIMEOUT ON SUCCESSFUL LOAD
        if (loadingTimeoutRef.current) {
          clearTimeout(loadingTimeoutRef.current);
          loadingTimeoutRef.current = null;
        }

        // ✅ MARK LOADING COMPLETE
        loadingStateRef.current.isLoading = false;
        loadingStateRef.current.sound = sound;

        // ✅ CRITICAL FIX: Force state updates to ensure UI refreshes
        setIsLoading(false);
        setIsLoaded(true);
        setError(null);
        setIsDownloading(false); // Ensure download state is cleared
        
        // ✅ FIXED: Get actual audio duration when loaded
        if (sound && sound.duration() > 0) {
          const audioDuration = sound.duration();
          setActualDuration(audioDuration);
          console.log('✅ Audio loaded with duration:', audioDuration);
        } else {
          console.warn('⚠️ Audio loaded but duration is 0 or invalid');
        }

        // ✅ FORCE RE-RENDER: Trigger a small state change to ensure component updates
        setTimeout(() => {
          if (isMountedRef.current) {
            console.log('🔄 Forcing component re-render after successful load');
            setCurrentTime(0); // This will trigger a re-render
          }
        }, 100);
      },
      onloaderror: (_, error) => {
        if (!isMountedRef.current) return;
        
        // ✅ CLEAR TIMEOUT ON ERROR
        if (loadingTimeoutRef.current) {
          clearTimeout(loadingTimeoutRef.current);
          loadingTimeoutRef.current = null;
        }
        
        // ✅ MARK LOADING COMPLETE (WITH ERROR)
        loadingStateRef.current.isLoading = false;
        
        console.error('Audio load failed:', error);
        setError('Failed to load audio');
        setIsLoading(false);
        if (onError) onError(error);
      },
      onplayerror: (_, error) => {
        if (!isMountedRef.current) return;
        console.error('❌ Audio play error:', error);
        setError('Failed to play audio');
        setIsPlaying(false);
        if (onError) onError(error);
      },
      onplay: () => {
        if (!isMountedRef.current) return;
        console.log('✅ Audio playback started');
        setIsPlaying(true);
      },
      onstop: () => {
        if (!isMountedRef.current) return;
        setIsPlaying(false);
      },
      onpause: () => {
        if (!isMountedRef.current) return;
        setIsPlaying(false);
      },
      onend: () => {
        if (!isMountedRef.current) return;
        setIsPlaying(false);
        setCurrentTime(0);
      }
    });

    setHowl(sound);

    // Set a timeout to check if loading succeeded (enhanced with comprehensive fallback)
    loadingTimeoutRef.current = setTimeout(() => {
      if (isMountedRef.current && loadingStateRef.current.isLoading && loadingStateRef.current.url === url) {
        console.warn('✋ Audio load timeout after 20 seconds for URL:', url);
        
        // 🔍 DEEP DIAGNOSIS: Check if this is a metadata/duration issue
        if (duration <= 1) {
          console.error('🚨 METADATA ISSUE: Duration is', duration, 'seconds - likely corrupted file');
        }
        
        // Strategy 1: Try with different audio formats and settings
        const retryUrl = url + (url.includes('?') ? '&' : '?') + 'retry=' + Date.now();
        console.log('🔄 Retry Strategy 1: Cache bust + format fallback:', retryUrl);
        
        // Create new Howl instance with enhanced fallback configuration
        const retrySound = new Howl({
          src: [retryUrl],
          format: ['mp3', 'wav', 'm4a', 'aac', 'ogg'], // Extended format support
          html5: false, // Try Web Audio API instead of HTML5
          preload: true,
          onload: () => {
            console.log('✅ Retry Strategy 1 successful for:', url);
            const retryDuration = retrySound.duration();
            console.log('📏 Retry audio duration:', retryDuration);
            
            if (retryDuration > 0) {
              setActualDuration(retryDuration);
            }
            
            setIsLoading(false);
            setError(null);
            setIsLoaded(true);
            loadingStateRef.current.isLoading = false;
            // ✅ FIX: Use proper callback handling
            if (typeof onLoad === 'function') onLoad();
          },
          onloaderror: (id, error) => {
            console.error('❌ Retry Strategy 1 failed, trying Strategy 2:', error);
            
            // Strategy 2: Try HTML5 audio with different settings
            const html5RetrySound = new Howl({
              src: [url], // Original URL without cache bust
              html5: true, // Force HTML5 audio
              format: ['mp3', 'wav'],
              preload: false, // Don't preload, load on demand
              onload: () => {
                console.log('✅ Retry Strategy 2 (HTML5) successful for:', url);
                setIsLoading(false);
                setError(null);
                setIsLoaded(true);
                loadingStateRef.current.isLoading = false;
                // ✅ FIX: Use proper callback handling
                if (typeof onLoad === 'function') onLoad();
              },
              onloaderror: (id, error2) => {
                console.error('❌ All retry strategies failed for:', url, error2);
                loadingStateRef.current.isLoading = false;
                
                // Final fallback: Mark as playable but with warning
                if (duration <= 1) {
                  setError('Audio file may have corrupted metadata');
                } else {
                  setError('Audio loading failed - network or file issue');
                }
                setIsLoading(false);
                if (onError) onError(error2);
              }
            });
            
            setHowl(html5RetrySound);
          }
        });
        
        setHowl(retrySound);
      }
    }, 20000);

    return () => {
      isMountedRef.current = false;
      
      // Clear timeout properly
      if (loadingTimeoutRef.current) {
        clearTimeout(loadingTimeoutRef.current);
        loadingTimeoutRef.current = null;
      }
      
      // Mark loading as complete to prevent any lingering timeouts
      loadingStateRef.current.isLoading = false;
      
      if (requestRef.current) {
        cancelAnimationFrame(requestRef.current);
      }
      if (howl) {
        try {
          howl.unload();
        } catch (error) {
          console.error('Error unloading Howl instance on cleanup:', error);
        }
      }
    };
  // ✅ CRITICAL FIX: Only depend on URL to prevent old messages from reloading
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [url]); // Only URL dependency - prevents old messages from reloading on Redux updates

  // Update progress during playback
  const updateProgress = () => {
    if (howl && soundId.current !== null) {
      try {
        setCurrentTime(howl.seek(soundId.current) || 0);
        requestRef.current = requestAnimationFrame(updateProgress);
      } catch (error) {
        console.error('Error updating progress:', error);
        cancelAnimationFrame(requestRef.current);
      }
    }
  };

  // Toggle play/pause
  const togglePlay = () => {
    if (!howl) {
      console.error('Howl not initialized');
      return;
    }

    if (isPlaying) {
      try {
        howl.pause(soundId.current);
        setIsPlaying(false);
        cancelAnimationFrame(requestRef.current);
      } catch (error) {
        console.error('Error pausing audio:', error);
        setError('Failed to pause audio');
      }
    } else {
      try {
        if (soundId.current === null) {
          soundId.current = howl.play();
        } else {
          howl.play(soundId.current);
        }
        requestRef.current = requestAnimationFrame(updateProgress);
        setIsPlaying(true);
      } catch (error) {
        console.error('Error playing audio:', error);
        setError('Failed to play audio');
      }
    }
  };

  // Handle progress bar click
  const handleProgressClick = (e) => {
    if (!howl || !progressBarRef.current) return;

    try {
      const rect = progressBarRef.current.getBoundingClientRect();
      const clickPosition = (e.clientX - rect.left) / rect.width;

      // Get the duration based on what's available
      const audioDuration = duration || howl.duration(soundId.current) || 0;
      const newTime = clickPosition * audioDuration;

      // Set the new time
      howl.seek(newTime, soundId.current);
      setCurrentTime(newTime);
    } catch (error) {
      console.error('Error handling progress click:', error);
    }
  };

  // Calculate progress percentage
  const progressPercentage = () => {
    try {
      const audioDuration = actualDuration > 0 ? actualDuration : (duration > 0 ? duration : 1);
      if (audioDuration <= 0) return 0;
      return (currentTime / audioDuration) * 100;
    } catch (error) {
      console.error('Error calculating progress percentage:', error);
      return 0;
    }
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
            backgroundColor: isHighlighted ? color : `${color}80`, // Use passed color for played portion, with 50% transparency for unplayed portion
          }}
        />
      );
    }

    return bars;
  };



  // Render play button with states
  const renderPlayButton = () => {
    if (isLoading && url && url.startsWith('http')) {
      // Show download indicator for remote URLs
      return (
        <div className="voice-download-indicator">
          <div className="voice-download-spinner"></div>
          <svg className="voice-download-icon" viewBox="0 0 24 24">
            <path d="M19 9h-4V3H9v6H5l7 7 7-7zM5 18v2h14v-2H5z" fill="currentColor"/>
          </svg>
        </div>
      );
    }
    
    if (isLoading) {
      // Show generic loading for local files
      return (
        <div className="voice-loading-indicator">
          <div className="voice-loading-spinner"></div>
        </div>
      );
    }
    
    if (error) {
      // Show error state
      return (
        <div className="voice-error-indicator">
          <svg viewBox="0 0 24 24" className="voice-error-icon">
            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z" fill="currentColor"/>
          </svg>
        </div>
      );
    }
    
    // Show play/pause button
    return isPlaying ? <FaPause /> : <FaPlay />;
  };

  return (
    <div className="voice-message-bubble">
      <button
        className={`voice-message-bubble__play-button ${
          isLoading ? 'voice-message-bubble__play-button--loading' : ''
        } ${
          error ? 'voice-message-bubble__play-button--error' : ''
        }`}
        onClick={togglePlay}
        disabled={!isLoaded && !error}
        aria-label={
          isLoading ? 'Loading audio...' : 
          error ? 'Error loading audio' :
          isPlaying ? 'Pause' : 'Play'
        }
      >
        {renderPlayButton()}
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
          {formatTime(currentTime)} / {formatTime(actualDuration > 0 ? actualDuration : (duration > 0 ? duration : 1))}
        </div>
      </div>

      {error && (
        <div className="voice-message-bubble__error" style={{ color: 'red', fontSize: '10px' }}>
          {error}

        </div>
      )}

      {isLoading && !error && (
        <div className="voice-message-bubble__loading" style={{ fontSize: '10px' }}>
          Loading...
        </div>
      )}
    </div>
  );
};

export default HowlerAudioPlayer;
