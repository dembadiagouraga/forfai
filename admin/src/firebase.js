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
            hasDurationField: 'duration' in message
          });

          // If it's a voice message but has no duration, set a default duration of 6 seconds
          if (message.duration === undefined || message.duration === null) {
            console.log('Voice message has no duration, setting default of 6 seconds');
            message.duration = 6;
          } else if (message.duration === 0) {
            console.log('Voice message has zero duration, setting default of 6 seconds');
            message.duration = 6;
          }
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
          duration: message.duration || 0, // Include duration field for voice messages
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

      reduxBatch(() => {
        store.dispatch(setMessagesLoading(false));
        store.dispatch(setMessages(fetchedMessages));
      });

      // Log the Redux store state after dispatching
      setTimeout(() => {
        console.log('Redux store state after dispatch:', store.getState().chat.messages);
      }, 100);
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

    if (isDevelopment) {
      // In development, skip the actual upload and use a dummy URL
      console.log('Development mode detected, skipping actual upload to Firebase Storage');
      audioUrl = 'https://example.com/dummy-voice-message.aac';
      console.log('Using dummy audio URL:', audioUrl);
    } else {
      // In production, upload to Firebase Storage as normal
      console.log('Starting voice message upload to Firebase Storage');
      // Upload audio to Firebase Storage
      const audioRef = ref(storage, `voice_messages/${chatId}/${Date.now()}.aac`);
      console.log('Created storage reference:', audioRef.fullPath);

      const uploadTask = uploadBytesResumable(audioRef, audioBlob);
      console.log('Upload task started');

      // Get download URL after upload
      console.log('Waiting for upload to complete...');
      const snapshot = await uploadTask;
      console.log('Upload completed, bytes transferred:', snapshot.bytesTransferred);

      audioUrl = await getDownloadURL(snapshot.ref);
      console.log('Got download URL:', audioUrl);
    }

    // Format duration for display (mm:ss)
    // Use the actual duration as provided
    const actualDuration = duration || 0;
    const minutes = Math.floor(actualDuration / 60);
    const seconds = Math.floor(actualDuration % 60);
    const formattedDuration = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    console.log('Formatted duration:', formattedDuration, 'from actual duration:', actualDuration);

    // Update chat document with duration in the last message
    console.log('Updating chat document with last message');
    const chatRef = doc(db, 'chat', chatId);
    await updateDoc(chatRef, {
      lastMessage: `🎤 ${formattedDuration}`, // Microphone icon with duration
      time: serverTimestamp(),
    });
    console.log('Chat document updated successfully');

    // Add message document
    const body = {
      read: false,
      time: new Date().toISOString(),
      senderId: currentUserId,
      message: audioUrl,
      type: "voice",
      duration: actualDuration, // Use the actual duration
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
