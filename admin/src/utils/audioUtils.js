/**
 * Utility functions for audio handling
 */
import silenceMP3 from '../assets/audio/silence.mp3';

// Cache for the silence MP3 blob
let silenceBlob = null;

/**
 * Creates a valid MP3 file with silence
 * @param {number} durationSeconds - Duration of silence in seconds (not actually used, but kept for API compatibility)
 * @returns {Promise<Blob>} - MP3 blob
 */
export const createSilentMp3 = async (durationSeconds = 1) => {
  // If we already have the silence blob, return it
  if (silenceBlob) {
    return silenceBlob;
  }

  try {
    // Fetch the silence MP3 file
    const response = await fetch(silenceMP3);
    if (!response.ok) {
      throw new Error(`Failed to fetch silence MP3: ${response.status} ${response.statusText}`);
    }

    // Get the blob from the response
    silenceBlob = await response.blob();

    // Return the blob
    return silenceBlob;
  } catch (error) {
    console.error('Error creating silent MP3:', error);

    // Fallback to a simple blob
    return new Blob([new Uint8Array([
      0x49, 0x44, 0x33, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, // ID3v2 header
      0xFF, 0xFB, 0x90, 0x00, // MP3 frame header
      // Some minimal MP3 data
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    ])], { type: 'audio/mpeg' });
  }
};

/**
 * Converts a blob to a data URL
 * @param {Blob} blob - The blob to convert
 * @returns {Promise<string>} - A promise that resolves to the data URL
 */
export const blobToDataUrl = (blob) => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onloadend = () => resolve(reader.result);
    reader.onerror = reject;
    reader.readAsDataURL(blob);
  });
};

/**
 * Converts a blob to an array buffer
 * @param {Blob} blob - The blob to convert
 * @returns {Promise<ArrayBuffer>} - A promise that resolves to the array buffer
 */
export const blobToArrayBuffer = (blob) => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onloadend = () => resolve(reader.result);
    reader.onerror = reject;
    reader.readAsArrayBuffer(blob);
  });
};

/**
 * Converts a blob to an MP3 blob
 * @param {Blob} blob - The blob to convert
 * @returns {Promise<Blob>} - A promise that resolves to the MP3 blob
 */
export const convertToMp3Blob = async (blob) => {
  try {
    // If it's already an MP3, just return it
    if (blob.type === 'audio/mpeg') {
      return blob;
    }

    // Convert to array buffer
    const arrayBuffer = await blobToArrayBuffer(blob);

    // Create a new blob with MP3 MIME type
    return new Blob([arrayBuffer], { type: 'audio/mpeg' });
  } catch (error) {
    console.error('Error converting to MP3:', error);
    // Fallback to simple conversion
    return new Blob([blob], { type: 'audio/mpeg' });
  }
};

/**
 * Checks if a blob is a valid audio file
 * @param {Blob} blob - The blob to check
 * @returns {Promise<boolean>} - A promise that resolves to true if the blob is a valid audio file
 */
export const isValidAudioBlob = async (blob) => {
  try {
    // Convert to data URL
    const dataUrl = await blobToDataUrl(blob);

    // Create an audio element
    const audio = new Audio();
    audio.src = dataUrl;

    // Try to load the audio
    return new Promise((resolve) => {
      audio.oncanplaythrough = () => resolve(true);
      audio.onerror = () => resolve(false);

      // Set a timeout in case the audio never loads
      setTimeout(() => resolve(false), 2000);

      audio.load();
    });
  } catch (error) {
    console.error('Error checking audio blob:', error);
    return false;
  }
};
