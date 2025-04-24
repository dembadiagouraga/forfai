import { configureStore, combineReducers } from '@reduxjs/toolkit';
import {
  persistStore,
  persistReducer,
  FLUSH,
  REHYDRATE,
  PAUSE,
  PERSIST,
  PURGE,
  REGISTER,
} from 'redux-persist';
import storage from 'redux-persist/lib/storage';

import rootReducer from './rootReducer';

const authPersistConfig = {
  key: 'auth',
  storage,
  whitelist: ['user'],
};
const settingsPersistConfig = {
  key: 'settings',
  storage,
  whitelist: ['settings'],
};
const themePersistConfig = {
  key: 'theme',
  storage,
  whitelist: ['theme'],
};
const todoPersistConfig = {
  key: 'todo',
  storage,
  whitelist: ['todos'],
};
const persistedReducer = combineReducers({
  ...rootReducer,
  auth: persistReducer(authPersistConfig, rootReducer.auth),
  globalSettings: persistReducer(
    settingsPersistConfig,
    rootReducer.globalSettings,
  ),
  theme: persistReducer(themePersistConfig, rootReducer.theme),
  todo: persistReducer(todoPersistConfig, rootReducer.todo),
});

export const store = configureStore({
  reducer: persistedReducer,
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      serializableCheck: {
        ignoredActions: [
          FLUSH, REHYDRATE, PAUSE, PERSIST, PURGE, REGISTER,
          'chat/setChats', 'chat/setMessages'
        ],
        // Ignore these field paths in all actions
        ignoredActionPaths: ['payload.time', 'meta.arg.time'],
        // Ignore these paths in the state
        ignoredPaths: ['chat.chats.time', 'chat.messages.time'],
      },
    }),
});

export const persistor = persistStore(store);
