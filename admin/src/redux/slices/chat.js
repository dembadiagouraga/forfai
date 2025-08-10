import { createSlice } from '@reduxjs/toolkit';

const initialState = {
  chats: [],
  messages: [],
  currentChat: null,
  messagesLoading: false,
  chatInitialized: false,
  authUserId: null,
  voiceUploads: {}, // Track voice message upload progress by temporary message ID
};

const chatSlice = createSlice({
  name: 'chat',
  initialState,
  reducers: {
    setChats(state, action) {
      state.chats = action.payload;
    },
    updateChat(state, action) {
      const { payload } = action;
      const staledChatItemIndex = state.chats.findIndex(
        (item) => item.chatId === payload.chatId,
      );
      state.chats[staledChatItemIndex] = {
        ...state.chats[staledChatItemIndex],
        ...payload,
      };
    },
    removeChat(state, action) {
      const { payload: chatId } = action;
      const removedChatItemIndex = state.chats.findIndex(
        (item) => item.chatId === chatId,
      );
      state.chats.splice(removedChatItemIndex, 1);
    },
    addChat(state, action) {
      state.chats.push(action.payload);
    },
    setMessages(state, action) {
      state.messages = action.payload;
    },
    setCurrentChat(state, action) {
      state.currentChat = action.payload;
    },
    removeCurrentChat(state) {
      state.currentChat = null;
    },
    setMessagesLoading(state, action) {
      state.messagesLoading = action.payload;
    },
    setChatInitialized(state, action) {
      state.chatInitialized = action.payload;
    },
    setAuthUserId(state, action) {
      state.authUserId = action.payload;
    },
    // Voice upload progress actions
    setVoiceUploadProgress(state, action) {
      const { tempMessageId, uploadState, progress } = action.payload;
      state.voiceUploads[tempMessageId] = {
        uploadState,
        progress: progress || 0,
        timestamp: Date.now(),
      };
    },
    updateVoiceUploadProgress(state, action) {
      const { tempMessageId, progress } = action.payload;
      if (state.voiceUploads[tempMessageId]) {
        state.voiceUploads[tempMessageId].progress = progress;
        state.voiceUploads[tempMessageId].timestamp = Date.now();
      }
    },
    setVoiceUploadState(state, action) {
      const { tempMessageId, uploadState } = action.payload;
      if (state.voiceUploads[tempMessageId]) {
        state.voiceUploads[tempMessageId].uploadState = uploadState;
        state.voiceUploads[tempMessageId].timestamp = Date.now();
      }
    },
    removeVoiceUpload(state, action) {
      const { tempMessageId } = action.payload;
      delete state.voiceUploads[tempMessageId];
    },
    clearOldVoiceUploads(state) {
      const now = Date.now();
      const maxAge = 5 * 60 * 1000; // 5 minutes
      Object.keys(state.voiceUploads).forEach(tempMessageId => {
        if (now - state.voiceUploads[tempMessageId].timestamp > maxAge) {
          delete state.voiceUploads[tempMessageId];
        }
      });
    },
  },
});

export const {
  setChats,
  setMessages,
  setCurrentChat,
  removeCurrentChat,
  updateChat,
  removeChat,
  addChat,
  setMessagesLoading,
  setChatInitialized,
  setAuthUserId,
  setVoiceUploadProgress,
  updateVoiceUploadProgress,
  setVoiceUploadState,
  removeVoiceUpload,
  clearOldVoiceUploads,
} = chatSlice.actions;
export default chatSlice.reducer;
