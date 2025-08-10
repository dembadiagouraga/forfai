import React, { useEffect, useState, useMemo } from 'react';
import { useSelector } from 'react-redux';
import HowlerAudioPlayer from './HowlerAudioPlayer';
import VoiceUploadProgress, { UPLOAD_STATES } from './VoiceUploadProgress';
import { BASE_URL, IMG_BASE_URL } from '../configs/app-global';
import '../assets/scss/components/voice-message-bubble.scss';
import '../assets/scss/components/voice-upload-progress.scss';

/**
 * Component for displaying and playing voice messages
 *
 * @param {Object} props - Component props
 * @param {string} props.audioUrl - URL of the audio file
 * @param {number} props.duration - Duration of the audio in seconds
 * @param {boolean} props.isAdmin - Whether the message is from admin
 * @param {string} props.messageId - ID of the message
 * @param {string} props.tempMessageId - Temporary message ID for upload tracking
 * @param {Function} props.onRetryUpload - Callback for retry upload
 */
const VoiceMessageBubble = ({
  audioUrl,
  duration = 0,
  isAdmin = false,
  messageId = '',
  tempMessageId = null,
  onRetryUpload = null
}) => {
  const [validUrl, setValidUrl] = useState(null);
  const [audioError, setAudioError] = useState(false);
  const [isLoading, setIsLoading] = useState(true);

  // Get upload progress from Redux store
  const voiceUploads = useSelector(state => state.chat.voiceUploads);
  const uploadInfo = tempMessageId ? voiceUploads[tempMessageId] : null;

  // ✅ ADDED: Format time function for consistent duration display
  const formatTime = (seconds) => {
    if (isNaN(seconds) || seconds < 0) return '0:00';
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  // ✅ ENHANCED: Validate audio URL and distinguish between placeholder and real S3 URLs
  const urlValidation = useMemo(() => {
    const validation = {
      audioUrl,
      messageId,
      tempMessageId,
      uploadInfo,
      isS3Url: false,
      isPlaceholder: false,
      isValid: false,
      hasDurationIssue: false,
      hasMetadataIssue: false
    };

    if (!audioUrl || typeof audioUrl !== 'string') {
      validation.isPlaceholder = true;
      return validation;
    }

    // Check if it's a placeholder text
    if (audioUrl === 'Voice message' || audioUrl.includes('Voice message')) {
      validation.isPlaceholder = true;
      return validation;
    }

    // ✅ CRITICAL: Check for duration and metadata issues
    if (duration <= 1) {
      validation.hasDurationIssue = true;
      validation.hasMetadataIssue = true;
      console.warn('🚨 VOICE MESSAGE METADATA ISSUE:', {
        messageId,
        audioUrl,
        duration,
        issue: 'Duration <= 1 second indicates corrupted metadata'
      });
    }

    // Check if it's a valid S3 URL
    if (audioUrl.includes('amazonaws.com') || audioUrl.includes('s3.')) {
      validation.isS3Url = true;
      validation.isValid = true;
      return validation;
    }

    // Check if it's a valid HTTP URL
    if (audioUrl.startsWith('http://') || audioUrl.startsWith('https://')) {
      validation.isValid = true;
      return validation;
    }

    return validation;
  }, [audioUrl, messageId, tempMessageId, uploadInfo, duration]);

  // ✅ ENHANCED: URL validation with Redux state change detection
  useEffect(() => {
    console.log('🔍 VoiceMessageBubble URL validation:', urlValidation);
    
    // 🔒 CRITICAL: Preserve loaded state for already processed messages
    if (validUrl && validUrl === audioUrl && !isLoading && !audioError) {
      console.log('🔒 Preserving loaded state for already loaded message:', audioUrl);
      return; // Exit early to prevent re-processing
    }
    
    // ✅ METADATA ISSUE HANDLING
    if (urlValidation.hasMetadataIssue) {
      console.error('🚨 METADATA CORRUPTION DETECTED:', {
        messageId: urlValidation.messageId,
        audioUrl: urlValidation.audioUrl,
        duration,
        recommendation: 'File may need re-upload or backend duration extraction fix'
      });
    }
    
    setIsLoading(true);
    setAudioError(false);

    if (!audioUrl) {
      console.error('VoiceMessageBubble: No audio URL provided');
      setValidUrl(null);
      setAudioError(true);
      setIsLoading(false);
      return;
    }

    // ✅ PRIORITY 1: Check if it's a valid S3 URL first
    if (audioUrl.includes('amazonaws.com') || audioUrl.includes('s3.')) {
      console.log('✅ Valid S3 URL detected:', audioUrl);
      setValidUrl(audioUrl);
      setIsLoading(false);
      setAudioError(false);
      return;
    }

    // ✅ PRIORITY 2: Handle placeholder text during upload
    if (audioUrl === "Voice message" || audioUrl === "voice message") {
      // If we have upload info and it's still uploading, show loading state
      if (uploadInfo && (uploadInfo.uploadState === UPLOAD_STATES.UPLOADING || uploadInfo.uploadState === UPLOAD_STATES.RETRYING)) {
        console.log('📤 Voice message uploading, showing loading state...');
        setValidUrl(null);
        setAudioError(false);
        setIsLoading(true); // Keep loading during upload
        return;
      }
      
      // ✅ ENHANCED FIX: Better handling for placeholder text during Firebase updates
      console.warn('⚠️ Voice message has placeholder text but no active upload. Checking upload completion...');
      
      // Check if this is a recently uploaded message (has tempMessageId but no active upload)
      if (tempMessageId && !uploadInfo) {
        console.log('📤 Recently uploaded message detected, waiting longer for Firebase update...');
        
        // For recently uploaded messages, wait longer and keep loading state
        setValidUrl(null);
        setAudioError(false);
        setIsLoading(true);
        
        // Extended timeout for newly uploaded messages
        const extendedTimeout = setTimeout(() => {
          console.error('❌ Recently uploaded voice message URL still not updated after extended timeout');
          setValidUrl(null);
          setAudioError(true);
          setIsLoading(false);
        }, 8000); // Wait 8 seconds for recently uploaded messages
        
        return () => clearTimeout(extendedTimeout);
      } else {
        // For older messages, use shorter timeout
        console.log('📜 Older message with placeholder text, using standard timeout...');
        
        setValidUrl(null);
        setAudioError(false);
        setIsLoading(true);
        
        const standardTimeout = setTimeout(() => {
          console.error('❌ Voice message URL still not updated after standard timeout:', audioUrl);
          setValidUrl(null);
          setAudioError(true);
          setIsLoading(false);
        }, 4000); // Wait 4 seconds for older messages
        
        return () => clearTimeout(standardTimeout);
      }
    }

    // Check if it's a local file path from Flutter
    if (typeof audioUrl === 'string' && (audioUrl.startsWith('/data/') || audioUrl.startsWith('/storage/'))) {
      console.log('VoiceMessageBubble: Local file path detected, attempting to convert to S3 URL');

      // Extract filename from path
      const filename = audioUrl.split('/').pop();

      // If we have a message ID, use it to construct an S3 URL
      if (messageId) {
        // Try to extract chat ID from message ID or use a default
        const chatId = messageId.includes('_') ? messageId.split('_')[0] : 'default';
        const s3Url = `${IMG_BASE_URL}/media/voice_messages/${chatId}/${filename}`;

        setValidUrl(s3Url);
        setIsLoading(false);
      } else {
        console.error('Voice message path conversion failed - missing message ID');
        setValidUrl(null);
        setAudioError(true);
        setIsLoading(false);
      }
      return;
    }

    // Check if it's a valid URL
    if (typeof audioUrl === 'string' && (audioUrl.startsWith('http://') || audioUrl.startsWith('https://'))) {


      // Extract the base URL without query parameters
      let baseUrl = audioUrl;
      let queryParams = '';

      if (audioUrl.includes('?')) {
        baseUrl = audioUrl.substring(0, audioUrl.indexOf('?'));
        queryParams = audioUrl.substring(audioUrl.indexOf('?'));
      }

      // Replace old IP addresses with current one
      if (baseUrl.includes('192.168.0.100') && BASE_URL.includes('192.168.0.105')) {
        baseUrl = baseUrl.replace('192.168.0.100', '192.168.0.110');
        console.log('VoiceMessageBubble: Replaced old IP with current IP:', baseUrl);
      }

      // Check if it's an S3 URL
      const isS3Url = baseUrl.includes('s3.') || baseUrl.includes('amazonaws.com');

      // Check if it's a voice message URL
      const isVoiceMessage = baseUrl.includes('voice_messages') || baseUrl.includes('media/voice_messages');

      console.log('VoiceMessageBubble: URL analysis:', { isS3Url, isVoiceMessage });

      // For S3 URLs, ensure they have the correct path structure
      if (isS3Url && isVoiceMessage) {
        // S3 URLs are already properly formatted, use as is
        console.log('VoiceMessageBubble: Using S3 URL as is');
      }
      // For local URLs, ensure they have .mp3 extension for better compatibility
      else if (!baseUrl.toLowerCase().endsWith('.mp3') && isVoiceMessage) {
        baseUrl = baseUrl.replace(/\.[^.]+$/, '.mp3');
        if (!baseUrl.toLowerCase().endsWith('.mp3')) {
          baseUrl = `${baseUrl}.mp3`;
        }
        console.log('VoiceMessageBubble: Added MP3 extension to URL');
      }

      // Reconstruct the URL with any modifications and original query parameters
      const finalUrl = baseUrl + queryParams;

      console.log('VoiceMessageBubble: Final normalized URL:', finalUrl);

      // Always set the URL and let the AudioPlayer handle the rest
      setValidUrl(finalUrl);
      setIsLoading(false);
    } else {
      console.error('VoiceMessageBubble: Invalid URL format:', audioUrl);
      setValidUrl(null);
      setAudioError(true);
    }

    setIsLoading(false);
  }, [audioUrl]); // ✅ CRITICAL FIX: Only audioUrl dependency to prevent old messages from reloading

  // Convert duration to number if it's a string
  let numericDuration = duration;
  if (typeof duration === 'string') {
    numericDuration = parseFloat(duration);
  }

  // Use the actual duration for display, but ensure it's valid
  // ✅ FIXED: Better duration handling with proper fallbacks
  const audioDuration = (() => {
    // First try the passed duration
    if (numericDuration !== undefined && numericDuration !== null && !isNaN(numericDuration) && numericDuration > 0) {
      return numericDuration;
    }
    
    // If duration is 0 or invalid, try to get from message data
    if (messageId) {
      // Try to find the message in Firebase data
      const message = window.messages?.find(msg => msg.id === messageId);
      if (message && message.duration && message.duration > 0) {
        return message.duration;
      }
    }
    
    // Fallback to minimum duration for very short recordings
    return 1; // Minimum 1 second instead of 0
  })();

  // Debug voice message issues
  if (audioDuration <= 0) {
    console.warn('Voice message has invalid duration:', audioDuration, 'for message:', messageId);
  }

  // Determine upload state
  const getUploadState = () => {
    if (!uploadInfo) {
      return UPLOAD_STATES.SUCCESS; // No upload info means it's already uploaded
    }
    return uploadInfo.uploadState || UPLOAD_STATES.SUCCESS;
  };

  const uploadState = getUploadState();
  const uploadProgress = uploadInfo?.progress || 0;

  // Handle retry upload
  const handleRetryUpload = () => {
    if (onRetryUpload && tempMessageId) {
      onRetryUpload(tempMessageId);
    }
  };

  return (
    <div className={`voice-message-bubble-wrapper ${isAdmin ? 'admin' : 'user'}`}>
      {isLoading ? (
        <div className="voice-message-loading">
          Loading audio...
        </div>
      ) : uploadState === UPLOAD_STATES.SUCCESS && validUrl ? (
        <HowlerAudioPlayer
          url={validUrl}
          duration={audioDuration}
          color="#ADFF2F" /* Green-yellow color for all waveforms */
          onError={() => setAudioError(true)}
          messageId={messageId}
        />
      ) : uploadState !== UPLOAD_STATES.SUCCESS ? (
        <div className="voice-message-upload-progress">
          <VoiceUploadProgress
            uploadState={uploadState}
            uploadProgress={uploadProgress}
            isPlaying={false}
            onRetry={handleRetryUpload}
            disabled={false}
          />
          <div className="voice-message-upload-info">
            <div className="voice-message-duration">
              {formatTime(audioDuration)}
            </div>
            <div className="voice-message-status">
              {uploadState === UPLOAD_STATES.UPLOADING && 'Uploading...'}
              {uploadState === UPLOAD_STATES.RETRYING && 'Retrying...'}
              {uploadState === UPLOAD_STATES.FAILED && 'Upload failed'}
            </div>
          </div>
        </div>
      ) : (
        <div className="voice-message-error">
          {audioError ? 'Error loading audio file' : 'Unable to play voice message'}
        </div>
      )}
    </div>
  );
};

export default React.memo(VoiceMessageBubble);
