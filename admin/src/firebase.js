import { initializeApp } from 'firebase/app';
import { getMessaging, getToken, onMessage } from 'firebase/messaging';
import {
  getFirestore,
  collection,
  onSnapshot,
  query,
  orderBy,
  addDoc,
  serverTimestamp,
  updateDoc,
  doc,
  deleteDoc,
  where,
  writeBatch,
  deleteField,
} from 'firebase/firestore';
import { batch as reduxBatch } from 'react-redux';
import {
  API_KEY,
  APP_ID,
  AUTH_DOMAIN,
  MEASUREMENT_ID,
  MESSAGING_SENDER_ID,
  PROJECT_ID,
  STORAGE_BUCKET,
  VAPID_KEY,
} from './configs/app-global';
import { store } from './redux/store';
import { setChats, setMessages, setMessagesLoading } from './redux/slices/chat';
import { toast } from 'react-toastify';
import VoiceMessageService from './services/VoiceMessageService';
import {
  setVoiceUploadProgress,
  updateVoiceUploadProgress,
  setVoiceUploadState,
  removeVoiceUpload
} from './redux/slices/chat';
import { UPLOAD_STATES } from './components/VoiceUploadProgress';
import userService from './services/seller/user';
import { getStorage, ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';
import { setFirebaseToken } from './redux/slices/auth';
import chatService from './services/chat';

const firebaseConfig = {
  apiKey: API_KEY,
  authDomain: AUTH_DOMAIN,
  projectId: PROJECT_ID,
  storageBucket: STORAGE_BUCKET,
  messagingSenderId: MESSAGING_SENDER_ID,
  appId: APP_ID,
  measurementId: MEASUREMENT_ID,
};

const app = initializeApp(firebaseConfig);

const messaging = getMessaging();
const db = getFirestore(app);
export const storage = getStorage(app);

function buildChatList(userDataList, firebaseChatList) {
  console.log("Building chat list with users:", userDataList.length, "and chats:", firebaseChatList.length);

  // reverse array for searching from end to beginning;
  firebaseChatList.reverse();

  const result = [];

  // For each user, find their chats
  userDataList.forEach((userDataItem) => {
    console.log("Processing user:", userDataItem.id, userDataItem.firstname);

    // Find all chats for this user
    const userChats = firebaseChatList.filter((item) => {
      // Try different ways to match the ID
      const userId = userDataItem.id;
      return Array.isArray(item.ids) && item.ids.some(id =>
        id === userId ||
        (typeof id === 'number' && id === Number(userId)) ||
        (typeof id === 'string' && id === String(userId))
      );
    });

    console.log("Found chats for user:", userChats.length);

    // Process each chat
    userChats.forEach(chatItem => {
      // Convert Firestore timestamp to serializable format
      if (chatItem && chatItem.time) {
        // Check if it's a Firestore timestamp
        if (chatItem.time.seconds !== undefined && chatItem.time.nanoseconds !== undefined) {
          // Convert to JavaScript Date and then to ISO string
          chatItem.time = new Date(
            chatItem.time.seconds * 1000 + chatItem.time.nanoseconds / 1000000
          ).toISOString();
        }
      }

      // Add user data to chat
      chatItem.user = userDataItem;
      result.push(chatItem);
    });
  });

  console.log("Final chat list:", result.length);
  return result;
}

export function getChat(currentUserId) {
  console.log("Getting chats for user ID:", currentUserId);
  try {
    // Convert currentUserId to number if it's a string
    const userId = typeof currentUserId === 'string' ? parseInt(currentUserId) : currentUserId;
    console.log("Converted user ID:", userId);

    const chatCollectionRef = collection(db, 'chat');
    // Try without the where clause to see all chats
    const chatQuery = query(chatCollectionRef);

    return onSnapshot(chatQuery, (chatSnapshot) => {
      console.log("Chat snapshot received, docs:", chatSnapshot.docs.length);
      const firebaseChats = chatSnapshot.docs.map((doc) => {
        const data = doc.data();
        console.log("Chat doc:", doc.id, "ids:", data.ids);
        return {
          chatId: doc.id,
          ...data,
        };
      });

      // Filter chats manually to debug
      const filteredChats = firebaseChats.filter(chat =>
        Array.isArray(chat.ids) && chat.ids.some(id =>
          // Try both string and number comparison
          id === userId || id === currentUserId ||
          (typeof id === 'number' && id === Number(currentUserId)) ||
          (typeof id === 'string' && id === String(currentUserId))
        )
      );
      console.log("Filtered chats:", filteredChats.length);

      if (filteredChats.length > 0) {
        // Extract all other user IDs from the chats
        const userIds = [];
        filteredChats.forEach(chat => {
          if (Array.isArray(chat.ids)) {
            chat.ids.forEach(id => {
              if (id !== userId && id !== currentUserId &&
                  id !== Number(currentUserId) && id !== String(currentUserId)) {
                userIds.push(id);
              }
            });
          }
        });
        console.log("User IDs to fetch:", userIds);

        if (userIds.length > 0) {
          chatService
            .getUser({
              ids: [...new Set(userIds)],
            })
            .then((res) => {
              console.log("User data received:", res.data);
              store.dispatch(setChats(buildChatList(res.data, filteredChats)));
            })
            .catch(error => {
              console.error("Error fetching user data:", error);
            });
        } else {
          console.log("No user IDs found in chats");
        }
      } else {
        console.log("No chats found for user ID:", userId);
      }
    });
  } catch (error) {
    console.error("Error in getChat:", error);
  }
}

export function fetchMessages(chatId, userId) {
  if (!chatId) return null;
  try {
    // Use ascending order to keep chronological order (oldest first)
    const q = query(collection(db, 'chat', chatId, 'message'), orderBy('time'));

    return onSnapshot(q, async (querySnapshot) => {
      const fetchedMessages = [];
      const batch = writeBatch(db);
      querySnapshot.forEach((doc) => {
        const messageRef = doc.ref;
        const message = doc.data();

        // Log the raw message data for debugging
        console.log('Raw message data from Firebase:', { id: doc.id, ...message });

        // Check if this is a voice message and if it has a duration field
        if (message.type === 'voice') {
          console.log('Voice message found:', {
            id: doc.id,
            message: message.message,
            duration: message.duration,
            durationType: typeof message.duration,
            hasDurationField: 'duration' in message
          });

          // Ensure duration is a valid number
          let validDuration;

          if (message.duration === undefined || message.duration === null) {
            console.log('Voice message has no duration, setting default of 6 seconds');
            validDuration = 6;
          } else if (typeof message.duration === 'string') {
            // If duration is a string, convert to number
            validDuration = parseInt(message.duration) || 6;
            console.log('Voice message has string duration, converted to number:', validDuration);
          } else if (typeof message.duration === 'number') {
            // Use the actual numeric duration
            validDuration = message.duration;
            console.log('Voice message has numeric duration:', validDuration);
          } else {
            // Fallback to default
            validDuration = 6;
            console.log('Voice message has invalid duration type, using default:', validDuration);
          }

          // Update the message object with the valid duration
          message.duration = validDuration;
        }

        // Convert Firestore timestamp to serializable format
        let messageTime = message.time;
        if (messageTime && messageTime.seconds !== undefined && messageTime.nanoseconds !== undefined) {
          // Convert to JavaScript Date
          messageTime = new Date(
            messageTime.seconds * 1000 + messageTime.nanoseconds / 1000000
          ).toISOString();
        }

        fetchedMessages.push({
          id: doc.id,
          message: message.message,
          time: messageTime,
          read: message.read,
          senderId: message.senderId,
          type: message.type,
          replyDocId: message.replyDocId,
          duration: typeof message.duration === 'number' ? message.duration : parseFloat(message.duration) || 0, // Include duration field for voice messages as a number
          media: message.media, // Include media field for voice messages from customer app
          isLast: false,
        });

        if (message.senderId !== userId && !message.read) {
          batch.update(messageRef, {
            read: true,
          });
        }
      });
      // Sort messages in ascending order (oldest first)
      fetchedMessages.sort((a, b) => new Date(a.time) - new Date(b.time));
      if (fetchedMessages[querySnapshot.size - 1]) {
        fetchedMessages[querySnapshot.size - 1].isLast = true;
      }
      // Log the fetched messages before dispatching to Redux
      console.log('Messages to be dispatched to Redux:', fetchedMessages);
      
      // ✅ CRITICAL FIX: Add timestamp to force re-renders when message content changes
      const messagesWithTimestamp = fetchedMessages.map(msg => ({
        ...msg,
        _lastUpdated: Date.now() // Force re-render trigger
      }));

      reduxBatch(() => {
        store.dispatch(setMessagesLoading(false));
        store.dispatch(setMessages(messagesWithTimestamp));
      });
      
      console.log('✅ Messages dispatched to Redux with force re-render timestamp');


      await batch.commit();
    });
  } catch (error) {
    console.error(error);
  }
}

export async function sendMessage(currentUserId, chatId, payload) {
  if (!chatId || !currentUserId) return null;
  try {
    const chatRef = doc(db, 'chat', chatId);

    await updateDoc(chatRef, {
      lastMessage: payload.message,
      time: serverTimestamp(),
    });

    const body = {
      read: false,
      time: new Date().toISOString(),
      senderId: currentUserId,
      ...payload,
    };

    if (payload.type) {
      body.type = payload.type;
    }

    await addDoc(collection(db, 'chat', chatId, 'message'), body);
  } catch (error) {
    toast.error(error.message);
    console.error(error);
  }
}

export async function editMessage(
  currentUserId,
  chatId,
  payload,
  editingMessage,
) {
  if (!chatId || !currentUserId || !editingMessage || !payload) return null;
  try {
    const messageRef = doc(
      db,
      'chat',
      chatId,
      'message',
      editingMessage.message.id,
    );
    if (editingMessage.message.isLast) {
      await updateDoc(doc(db, 'chat', chatId), {
        lastMessage: payload.message,
        time: serverTimestamp(),
      });
    }
    await updateDoc(messageRef, {
      message: payload.message,
    });
  } catch (error) {
    toast.error(error.message);
    console.error(error);
  }
}

export async function deleteChat(currentChatId) {
  try {
    await deleteDoc(doc(db, 'chat', currentChatId));
  } catch (error) {
    toast.error(error);
  }
}

export async function deleteMessage(chatId, message, messageBeforeLastMessage) {
  if (!chatId || !message) return null;
  try {
    await deleteDoc(doc(db, 'chat', chatId, 'message', message.id));
    if (message.isLast) {
      await updateDoc(doc(db, 'chat', chatId), {
        lastMessage: messageBeforeLastMessage
          ? messageBeforeLastMessage.message
          : '',
        time: serverTimestamp(),
      });
    }
  } catch (error) {
    console.error(error);
    toast.error(error);
  }
}

export async function fetchRepliedMessage(
  messageId,
  currentChatId,
  setReplyMessage,
) {
  if (currentChatId) {
    const q = doc(db, 'chat', currentChatId, 'message', messageId);
    return onSnapshot(q, (snapshot) => {
      const message = snapshot.data();
      setReplyMessage({
        id: snapshot.id,
        message: message?.message,
        type: message?.type,
      });
    });
  }
}

export const requestForToken = () => {
  return getToken(messaging, { vapidKey: VAPID_KEY })
    .then((currentToken) => {
      if (currentToken) {
        store.dispatch(setFirebaseToken(currentToken));
        const payload = { firebase_token: currentToken };
        userService
          .profileFirebaseToken(payload)
          .then((res) => console.log('firebase token sent => ', res));
      } else {
        // Show permission request UI
        console.log(
          'No registration token available. Request permission to generate one.',
        );
      }
    })
    .catch((err) => {
      console.log('An error occurred while retrieving token. ', err);
    });
};

export const onMessageListener = () =>
  new Promise((resolve) => {
    onMessage(messaging, (payload) => {
      resolve(payload);
    });
  });

/**
 * Send a voice message
 * @param {string} currentUserId - ID of the current user
 * @param {string} chatId - ID of the chat
 * @param {Blob} audioBlob - Audio blob to upload
 * @param {number} duration - Duration of the audio in seconds
 */
export async function sendVoiceMessage(currentUserId, chatId, audioBlob, duration) {
  console.log('sendVoiceMessage called with:', { currentUserId, chatId, audioBlob, duration });

  if (!chatId || !currentUserId) {
    console.error('Missing required parameters:', { currentUserId, chatId });
    return null;
  }

  try {
    // Check if we're in development mode (localhost)
    const isDevelopment = window.location.hostname === 'localhost';
    let audioUrl = '';
    let actualDuration = duration;

    if (isDevelopment && process.env.REACT_APP_SKIP_UPLOAD === 'true') {
      // In development with skip upload flag, use a dummy URL
      console.log('Development mode with skip upload flag, using dummy URL');
      audioUrl = 'https://example.com/dummy-voice-message.aac';
      console.log('Using dummy audio URL:', audioUrl);
    } else {
      // Upload to AWS S3 via backend API
      console.log('Uploading voice message to AWS S3');
      const result = await VoiceMessageService.uploadVoiceMessage(audioBlob, chatId, duration);
      audioUrl = result.url;
      actualDuration = result.duration;
      console.log('Voice message uploaded successfully:', { audioUrl, actualDuration });
    }

    // Update chat document with last message
    const chatRef = doc(db, 'chat', chatId);
    await updateDoc(chatRef, {
      lastMessage: 'Voice message',
      time: new Date().toISOString(),
    });
    console.log('Chat document updated successfully');

    // Add message document
    // Ensure duration is a valid number and use the actual duration from recording
    let validDuration = typeof actualDuration === 'number'
      ? actualDuration
      : parseFloat(actualDuration) || 0;

    // Log the duration for debugging
    console.log('Storing voice message with duration:', validDuration, 'seconds');

    const body = {
      read: false,
      time: new Date().toISOString(),
      senderId: currentUserId,
      message: audioUrl,
      type: "voice",
      duration: validDuration, // Store as a number, not a string
    };
    console.log('Creating message document with body:', body);

    const messageRef = await addDoc(collection(db, 'chat', chatId, 'message'), body);
    console.log('Message document created successfully with ID:', messageRef.id);

    return messageRef.id; // Return the message ID for confirmation
  } catch (error) {
    console.error('Error in sendVoiceMessage:', error);
    toast.error(error.message || 'Error sending voice message');
    throw error; // Re-throw to allow caller to handle
  }
}

/**
 * Send a voice message with immediate display and upload progress tracking
 * @param {string} currentUserId - ID of the current user
 * @param {string} chatId - ID of the chat
 * @param {Blob} audioBlob - Audio blob to upload
 * @param {number} duration - Duration of the audio in seconds
 * @returns {Promise<string>} - Temporary message ID for tracking
 */
export async function sendVoiceMessageWithProgress(currentUserId, chatId, audioBlob, duration) {
  console.log('sendVoiceMessageWithProgress called with:', { currentUserId, chatId, audioBlob, duration });

  if (!chatId || !currentUserId) {
    console.error('Missing required parameters:', { currentUserId, chatId });
    return null;
  }

  // Generate temporary message ID for tracking
  const tempMessageId = `temp_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  console.log('Generated temporary message ID:', tempMessageId);

  try {
    // Immediately add a temporary message to Firebase for instant display
    const tempBody = {
      read: false,
      time: new Date().toISOString(),
      senderId: currentUserId,
      message: 'Voice message', // Temporary placeholder
      type: "voice",
      duration: duration, // Use actual recording duration, don't force minimum
      tempMessageId: tempMessageId, // Mark as temporary
      isUploading: true // Flag to indicate upload in progress
    };

    console.log('Creating temporary message document with body:', tempBody);
    const tempMessageRef = await addDoc(collection(db, 'chat', chatId, 'message'), tempBody);
    const actualMessageId = tempMessageRef.id;
    console.log('Temporary message created with ID:', actualMessageId);

    // Update chat document with last message
    const chatRef = doc(db, 'chat', chatId);
    await updateDoc(chatRef, {
      lastMessage: 'Voice message',
      time: new Date().toISOString(),
    });

    // Set initial upload state in Redux
    store.dispatch(setVoiceUploadProgress({
      tempMessageId: tempMessageId,
      uploadState: UPLOAD_STATES.UPLOADING,
      progress: 0
    }));

    // Start upload process with progress tracking
    try {
      console.log('Starting voice message upload to AWS S3');

      const result = await VoiceMessageService.uploadVoiceMessage(
        audioBlob,
        chatId,
        duration,
        (progress) => {
          // Update progress in Redux
          store.dispatch(updateVoiceUploadProgress({
            tempMessageId: tempMessageId,
            progress: progress
          }));
        }
      );

      const audioUrl = result.url;
      const actualDuration = result.duration;

      // 🔍 FIREBASE STORAGE ANALYSIS
      console.group('🔥 FIREBASE STORAGE ANALYSIS');
      console.log('✅ Upload Complete - S3 URL:', audioUrl);
      console.log('⏱️ Backend Duration:', actualDuration, typeof actualDuration);
      console.log('📦 Original Duration Sent:', duration, typeof duration);
      console.groupEnd();

      // ✅ CRITICAL FIX: Enhanced Firebase update with proper field management
      const updateData = {
        message: audioUrl, // Replace placeholder with real S3 URL
        duration: actualDuration, // Use actual duration from backend
        isUploading: false, // Remove upload flag
        uploadFailed: deleteField(), // Remove any failed upload flags
        tempMessageId: deleteField() // Remove temporary ID field
      };

      // 🔍 FIREBASE UPDATE ANALYSIS
      console.group('🔥 FIREBASE UPDATE ANALYSIS');
      console.log('📝 Updating Firebase with:', updateData);
      console.log('🌐 S3 URL:', audioUrl);
      console.log('⏱️ Final Duration to Store:', actualDuration, typeof actualDuration);
      console.log('🆔 Message ID:', actualMessageId);
      console.log('💬 Chat ID:', chatId);
      console.groupEnd();

      // ✅ ATOMIC UPDATE: Update Firebase document
      await updateDoc(doc(db, 'chat', chatId, 'message', actualMessageId), updateData);
      console.log('✅ Firebase message updated successfully with S3 URL');
      
      // ✅ FORCE IMMEDIATE UI UPDATE: Update chat's last message too
      await updateDoc(doc(db, 'chat', chatId), {
        lastMessage: 'Voice message',
        time: new Date().toISOString(),
      });
      console.log('✅ Chat document updated with voice message');

      // Set upload state to success and clean up after a delay
      store.dispatch(setVoiceUploadState({
        tempMessageId: tempMessageId,
        uploadState: UPLOAD_STATES.SUCCESS
      }));

      // ✅ DEFINITIVE FIX: Force immediate UI update with guaranteed re-render
      console.log('🔄 Implementing definitive UI refresh for new voice message...');
      
      // Strategy 1: Force immediate Redux update with re-render trigger
      const currentState = store.getState();
      const currentMessages = currentState.chat.messages;
      
      // Find and update the specific message
      const messageIndex = currentMessages.findIndex(msg => 
        msg.id === actualMessageId || msg.tempMessageId === tempMessageId
      );
      
      if (messageIndex !== -1) {
        const updatedMessages = [...currentMessages];
        updatedMessages[messageIndex] = {
          ...updatedMessages[messageIndex],
          message: audioUrl, // Replace placeholder with S3 URL
          duration: actualDuration,
          isUploading: false,
          uploadFailed: false,
          tempMessageId: undefined, // Remove temp ID
          _forceUpdate: Date.now() // Force re-render trigger
        };
        
        console.log('📝 Force updating message in Redux:', {
          messageId: actualMessageId,
          tempMessageId: tempMessageId,
          newUrl: audioUrl,
          duration: actualDuration,
          forceUpdate: updatedMessages[messageIndex]._forceUpdate
        });
        
        // Multiple dispatch strategy to ensure update
        store.dispatch(setMessagesLoading(true)); // Force loading state change
        setTimeout(() => {
          store.dispatch(setMessages(updatedMessages));
          store.dispatch(setMessagesLoading(false));
          console.log('✅ Redux state forcefully updated with S3 URL and re-render trigger');
        }, 50);
      } else {
        console.error('❌ Message not found in Redux state for update:', {
          actualMessageId,
          tempMessageId,
          totalMessages: currentMessages.length
        });
      }
      
      // Strategy 2: Verify update success
      setTimeout(() => {
        console.log('🔄 Verifying definitive UI update...');
        const newState = store.getState();
        const updatedMessage = newState.chat.messages.find(msg => msg.id === actualMessageId);
        
        if (updatedMessage && updatedMessage.message === audioUrl) {
          console.log('✅ DEFINITIVE SUCCESS: Message updated in UI with S3 URL');
        } else {
          console.error('❌ DEFINITIVE FAILURE: Message still not updated in UI');
        }
      }, 1500);

      // Clean up Redux state after a short delay
      setTimeout(() => {
        store.dispatch(removeVoiceUpload({ tempMessageId: tempMessageId }));
      }, 2000);

      return tempMessageId;

    } catch (uploadError) {
      console.error('Error uploading voice message:', uploadError);

      // Set upload state to failed
      store.dispatch(setVoiceUploadState({
        tempMessageId: tempMessageId,
        uploadState: UPLOAD_STATES.FAILED
      }));

      // Keep the temporary message but mark it as failed
      await updateDoc(doc(db, 'chat', chatId, 'message', actualMessageId), {
        isUploading: false,
        uploadFailed: true
      });

      throw uploadError;
    }

  } catch (error) {
    console.error('Error in sendVoiceMessageWithProgress:', error);

    // Clean up Redux state on error
    store.dispatch(removeVoiceUpload({ tempMessageId: tempMessageId }));

    toast.error(error.message || 'Error sending voice message');
    throw error;
  }
}

/**
 * Retry uploading a failed voice message
 * @param {string} tempMessageId - Temporary message ID for tracking
 * @param {string} chatId - ID of the chat
 * @param {string} messageId - Actual Firebase message ID
 * @param {Blob} audioBlob - Audio blob to upload (stored in memory or re-recorded)
 * @param {number} duration - Duration of the audio in seconds
 */
export async function retryVoiceMessageUpload(tempMessageId, chatId, messageId, audioBlob, duration) {
  console.log('retryVoiceMessageUpload called with:', { tempMessageId, chatId, messageId });

  if (!chatId || !messageId || !tempMessageId) {
    console.error('Missing required parameters for retry');
    return;
  }

  try {
    // Set upload state to retrying
    store.dispatch(setVoiceUploadState({
      tempMessageId: tempMessageId,
      uploadState: UPLOAD_STATES.RETRYING
    }));

    // Start upload process with progress tracking
    const result = await VoiceMessageService.uploadVoiceMessage(
      audioBlob,
      chatId,
      duration,
      (progress) => {
        // Update progress in Redux
        store.dispatch(updateVoiceUploadProgress({
          tempMessageId: tempMessageId,
          progress: progress
        }));
      }
    );

    const audioUrl = result.url;
    const actualDuration = result.duration;
    console.log('Voice message retry upload successful:', { audioUrl, actualDuration });

    // Update the message with the actual audio URL
    await updateDoc(doc(db, 'chat', chatId, 'message', messageId), {
      message: audioUrl,
      duration: actualDuration, // Use actual duration from backend
      uploadFailed: deleteField() // Remove failed flag
    });

    console.log('Message updated with actual audio URL after retry');

    // Set upload state to success and clean up after a delay
    store.dispatch(setVoiceUploadState({
      tempMessageId: tempMessageId,
      uploadState: UPLOAD_STATES.SUCCESS
    }));

    // Clean up Redux state after a short delay
    setTimeout(() => {
      store.dispatch(removeVoiceUpload({ tempMessageId: tempMessageId }));
    }, 2000);

  } catch (error) {
    console.error('Error retrying voice message upload:', error);

    // Set upload state back to failed
    store.dispatch(setVoiceUploadState({
      tempMessageId: tempMessageId,
      uploadState: UPLOAD_STATES.FAILED
    }));

    toast.error('Retry failed: ' + (error.message || 'Error uploading voice message'));
  }
}