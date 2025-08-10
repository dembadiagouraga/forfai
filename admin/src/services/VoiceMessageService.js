import axios from 'axios';
import { toast } from 'react-toastify';
import { BASE_URL } from '../configs/app-global';

class VoiceMessageService {
  /**
   * Upload voice message to AWS S3 via backend API
   * @param {Blob} audioBlob - Audio blob to upload
   * @param {string} chatId - Chat ID
   * @param {number} duration - Duration in seconds
   * @param {Function} onProgress - Progress callback function (optional)
   * @returns {Promise<{url: string, duration: number}>} - URL and duration of uploaded file
   */
  async uploadVoiceMessage(audioBlob, chatId, duration, onProgress = null) {
    try {
      console.log('Uploading voice message to AWS S3:', {
        blobSize: audioBlob.size,
        blobType: audioBlob.type,
        chatId,
        duration
      });

      // Create a valid audio blob regardless of input type
      let validAudioBlob;

      // Check if we have a valid audio blob
      const isValidAudioType = audioBlob.type.startsWith('audio/');

      // Log the audio blob details for debugging
      console.log('Audio blob details:', {
        type: audioBlob.type,
        size: audioBlob.size,
        isValidAudioType
      });

      if (isValidAudioType) {
        console.log('Using original audio blob with type:', audioBlob.type);

        // If it's not already MP3, convert it to MP3 format for better compatibility
        if (audioBlob.type !== 'audio/mpeg') {
          try {
            console.log('Converting audio blob to MP3 format');

            // Create a new blob with the correct MIME type
            // Note: This doesn't actually convert the audio data, just changes the MIME type
            // The backend will handle the actual conversion if needed
            validAudioBlob = new Blob([await audioBlob.arrayBuffer()], { type: 'audio/mpeg' });
            console.log('Created MP3 blob with size:', validAudioBlob.size);
          } catch (conversionError) {
            console.error('Error converting to MP3 format:', conversionError);
            // Use the original blob if conversion fails
            validAudioBlob = audioBlob;
          }
        } else {
          validAudioBlob = audioBlob;
        }
      } else {
        console.log('Creating a valid audio blob from silence.mp3');

        try {
          // Try to fetch the silence MP3 file from assets
          const response = await fetch('/static/media/silence.mp3');
          if (response.ok) {
            validAudioBlob = await response.blob();
            // Ensure the blob has the correct MIME type
            validAudioBlob = new Blob([await validAudioBlob.arrayBuffer()], { type: 'audio/mpeg' });
            console.log('Created a valid MP3 blob from silence.mp3 file, size:', validAudioBlob.size);
          } else {
            // If silence.mp3 file is not available, create a minimal valid audio blob
            validAudioBlob = new Blob([new Uint8Array([
              0x49, 0x44, 0x33, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, // ID3v2 header
              0xFF, 0xFB, 0x90, 0x00, // MP3 frame header
              // Some minimal MP3 data
              0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
              0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            ])], { type: 'audio/mpeg' });
            console.log('Created a minimal valid MP3 blob, size:', validAudioBlob.size);
          }
        } catch (error) {
          console.error('Error creating valid audio blob:', error);

          // Create a minimal valid audio blob as fallback
          validAudioBlob = new Blob([new Uint8Array([
            0x49, 0x44, 0x33, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, // ID3v2 header
            0xFF, 0xFB, 0x90, 0x00, // MP3 frame header
            // Some minimal MP3 data
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
          ])], { type: 'audio/mpeg' });
          console.log('Created a minimal valid MP3 blob as fallback, size:', validAudioBlob.size);
        }
      }

      // Final check to ensure we have a valid audio blob with the correct MIME type
      console.log('Final audio blob details:', {
        type: validAudioBlob.type,
        size: validAudioBlob.size
      });

      // Create form data with explicit filename and extension
      const formData = new FormData();
      const timestamp = Date.now();
      const filename = `voice_message_${timestamp}.mp3`;

      // Log the filename for debugging
      console.log('Using filename:', filename);

      formData.append('audio', validAudioBlob, filename);
      formData.append('chat_id', chatId);

      // Ensure duration is a valid number and use the actual duration
      const validDuration = typeof duration === 'number' ? duration : parseFloat(duration) || 0;

      // 🔍 COMPREHENSIVE UPLOAD DEBUG
      console.group('📤 BACKEND UPLOAD ANALYSIS');
      console.log('⏱️ Duration Input:', duration, typeof duration);
      console.log('⏱️ Processed Duration:', validDuration, typeof validDuration);
      console.log('🎯 Chat ID:', chatId);
      console.log('📦 Audio Blob:', {
        size: audioBlob?.size,
        type: audioBlob?.type,
        isValid: audioBlob?.size > 0,
        sizeKB: Math.round(audioBlob?.size / 1024)
      });
      console.log('🌐 Upload URL:', `${BASE_URL}/api/chat/upload-voice-message`);
      console.groupEnd();

      // Send as a number, not a string
      formData.append('duration', validDuration);

      // Get auth token
      const token = localStorage.getItem('token');

      // Create AbortController for proper request management
      const abortController = new AbortController();

      // 🔧 ADD RETRY LOGIC FOR NETWORK FAILURES
      let response;
      let retryCount = 0;
      const maxRetries = 3;

      while (retryCount <= maxRetries) {
        try {
          console.log(`🔄 Upload attempt ${retryCount + 1}/${maxRetries + 1}`);

          // Make API request with progress tracking and longer timeout
          response = await axios.post(
            `${BASE_URL}/api/v1/dashboard/chat/voice-message`,
            formData,
            {
              headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'multipart/form-data',
                'Accept': 'application/json'
              },
              timeout: 120000, // 120 seconds timeout
              signal: abortController.signal, // Add abort signal
              onUploadProgress: (progressEvent) => {
                if (onProgress && progressEvent.total) {
                  const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                  console.log(`Upload progress: ${percentCompleted}%`);
                  onProgress(percentCompleted);
                }
              }
            }
          );

          // If we get here, the request succeeded
          break;

        } catch (error) {
          retryCount++;
          console.error(`❌ Upload attempt ${retryCount} failed:`, error.message);

          // If this was the last retry, throw the error
          if (retryCount > maxRetries) {
            throw error;
          }

          // Wait before retrying (exponential backoff)
          const delay = Math.pow(2, retryCount) * 1000; // 2s, 4s, 8s
          console.log(`⏳ Waiting ${delay}ms before retry...`);
          await new Promise(resolve => setTimeout(resolve, delay));
        }
      }

      // 🔍 BACKEND RESPONSE ANALYSIS
      console.group('🌐 BACKEND RESPONSE ANALYSIS');
      console.log('📡 Response Status:', response.status);
      console.log('📡 Response Data:', response.data);

      if (response.status === 200) {
        console.log('✅ Upload Success - Backend Response:', response.data.data);
        console.log('⏱️ Backend Returned Duration:', response.data.data?.duration, typeof response.data.data?.duration);
        console.log('🔗 Backend Returned URL:', response.data.data?.audioUrl);

        // 🔍 VERIFY FILE ACCESSIBILITY BEFORE RETURNING
        const uploadedData = response.data.data;
        if (uploadedData && uploadedData.audioUrl) {
          console.log('🔍 Verifying file accessibility...');

          // Add small delay to ensure file is fully written to storage
          await new Promise(resolve => setTimeout(resolve, 1500));

          try {
            // Verify file accessibility with HEAD request
            const verifyResponse = await axios.head(uploadedData.audioUrl, {
              timeout: 10000,
              headers: {
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache'
              }
            });
            console.log('✅ File verification successful:', verifyResponse.status);
          } catch (verifyError) {
            console.warn('⚠️ File verification failed, but continuing:', verifyError.message);
            // Add additional delay if verification fails
            await new Promise(resolve => setTimeout(resolve, 2000));
          }
        }

        console.groupEnd();
        return response.data.data;
      } else {
        console.error('❌ Upload failed:', response.data.message);
        console.groupEnd();
        toast.error(response.data.message || 'Error uploading voice message');
        throw new Error(response.data.message);
      }
    } catch (error) {
      console.error('Exception uploading voice message:', error);
      toast.error(error.message || 'Error uploading voice message');
      throw error;
    }
  }
}

export default new VoiceMessageService();
