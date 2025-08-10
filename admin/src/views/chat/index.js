import React, { useContext, useEffect, useRef, useState } from 'react';
import '@chatscope/chat-ui-kit-styles/dist/default/styles.min.css';
import {
  Sidebar,
  MainContainer,
  ChatContainer,
  MessageList,
  MessageInput,
  Avatar,
  ConversationList,
  Conversation,
  ConversationHeader,
} from '@chatscope/chat-ui-kit-react';
import Channel from './channel';
import {
  deleteChat,
  deleteMessage,
  editMessage,
  fetchMessages,
  getChat,
  sendMessage,
  sendVoiceMessage,
  sendVoiceMessageWithProgress,
  retryVoiceMessageUpload,
} from '../../firebase';

import { FaMicrophone } from 'react-icons/fa';
import { IoSend } from 'react-icons/io5';
import { batch, shallowEqual, useDispatch, useSelector } from 'react-redux';
import {
  removeCurrentChat,
  setAuthUserId,
  setChatInitialized,
  setChats,
  setCurrentChat,
  setMessages,
  setMessagesLoading,
} from 'redux/slices/chat';
import { getMessages } from 'redux/selectors/chatSelector';
import { scrollTo } from 'helpers/scrollTo';
import { useTranslation } from 'react-i18next';
import CustomModal from 'components/modal';
import { Context } from 'context/context';
import getAvatar from 'helpers/getAvatar';
import UploadMedia from './upload-media';
import { toast } from 'react-toastify';
import { SUPPORTED_FORMATS } from 'configs/app-global';
import MessageActionIndicator from './message-action-indicator';
import VoiceRecordingModal from '../../components/VoiceRecordingModal';

let chatUnsubscribe;

export default function Chat() {
  const { t } = useTranslation();
  const inputRef = useRef();
  const nextRef = useRef();
  const dispatch = useDispatch();
  const messageEndRef = useRef();
  const { setIsModalVisible } = useContext(Context);
  const [file, setFile] = useState('');
  const [url, setUrl] = useState('');
  const [modal, setModal] = useState(false);
  const [isVoiceRecordingModalVisible, setIsVoiceRecordingModalVisible] = useState(false);
  const [isVoiceUploading, setIsVoiceUploading] = useState(false); // ✅ ADD UPLOAD STATE
  const currentUserId = useSelector((state) => state.auth.user.id);
  const { chats, currentChat, messagesLoading, chatInitialized, authUserId } =
    useSelector((state) => state.chat, shallowEqual);
  // ✅ CRITICAL FIX: Remove shallowEqual to ensure re-renders when message content changes
  const groupMessages = useSelector(
    (state) => {
      const messages = getMessages(state.chat.messages);
      console.log('🔄 Messages selector triggered, total groups:', messages.length);
      return messages;
    }
    // Removed shallowEqual to ensure re-renders when individual message properties change
  );
  // ✅ Access raw messages array for direct lookups (e.g., by tempMessageId)
  const messages = useSelector((state) => state.chat.messages);
  // ✅ Access voice upload states stored in Redux
  const voiceUploads = useSelector((state) => state.chat.voiceUploads);
  const [newMessage, setNewMessage] = useState('');
  const [actionMessage, setActionMessage] = useState({
    actionType: null,
    message: null,
  });

  const messageUnsubscribeRef = useRef();

  // Handle voice recording button click
  const handleVoiceRecordClick = () => {
    console.log('🎤 handleVoiceRecordClick function called');

    // ✅ PREVENT MULTIPLE RECORDING SESSIONS
    if (isVoiceRecordingModalVisible || isVoiceUploading) {
      console.log('🚫 Recording already in progress or uploading, ignoring click');
      return;
    }

    // Check if the browser supports getUserMedia
    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
      console.error('Browser does not support getUserMedia');
      alert('Your browser does not support voice recording. Please try a different browser.');
      return;
    }

    // Request microphone access before showing the modal
    navigator.mediaDevices.getUserMedia({ audio: true })
      .then(stream => {
        console.log('✅ Microphone access granted');
        // Stop the stream immediately, we just needed to check access
        stream.getTracks().forEach(track => track.stop());

        // Now show the modal
        setIsVoiceRecordingModalVisible(prevState => {
          console.log('Setting modal visible, previous state:', prevState);
          return true;
        });
      })
      .catch(err => {
        console.error('❌ Error accessing microphone:', err);
        alert('Could not access your microphone. Please check your microphone permissions and try again.');
      });
  };

  // Store audio blob for retry functionality
  const [pendingVoiceUploads, setPendingVoiceUploads] = useState(new Map());

  // Handle voice recording completion with progress tracking
  const handleVoiceRecordingComplete = async (audioBlob, duration) => {
    console.log('🎤 Voice recording complete:', { audioBlob, duration });

    // ❌ DON'T close modal immediately - wait for upload to complete
    if (!audioBlob || duration <= 0) {
      console.warn('Cannot send voice message: audioBlob or duration is invalid');
      setIsVoiceRecordingModalVisible(false);
      return;
    }

    // ✅ SET UPLOADING STATE
    setIsVoiceUploading(true);

    console.log('🚀 Sending voice message with progress tracking:', {
      currentUserId,
      chatId: currentChat?.chatId,
      audioBlobSize: audioBlob?.size,
      duration
    });

    try {
      // ✅ CRITICAL FIX: Wait for upload to complete before closing modal
      const tempMessageId = await sendVoiceMessageWithProgress(
        currentUserId,
        currentChat?.chatId,
        audioBlob,
        duration
      );

      if (tempMessageId) {
        // Store the audio blob for potential retry
        setPendingVoiceUploads(prev => new Map(prev.set(tempMessageId, {
          audioBlob,
          duration,
          chatId: currentChat?.chatId
        })));
        console.log('✅ Voice message upload completed with temp ID:', tempMessageId);
      }

      // ✅ Only close modal AFTER successful upload
      setIsVoiceRecordingModalVisible(false);

    } catch (error) {
      console.error('❌ Error sending voice message with progress:', error);
      // Close modal even on error to prevent UI lock
      setIsVoiceRecordingModalVisible(false);
    } finally {
      // ✅ ALWAYS RESET UPLOADING STATE
      setIsVoiceUploading(false);
    }
  };

  // Handle retry upload
  const handleRetryUpload = (tempMessageId) => {
    console.log('Retrying upload for temp message ID:', tempMessageId);

    // Read pending upload data from Redux voiceUploads map
    const uploadData = voiceUploads && voiceUploads[tempMessageId];
    if (!uploadData) {
      console.error('No upload data found for temp message ID:', tempMessageId);
      return;
    }

    const { audioBlob, duration, chatId } = uploadData;

    // Find the actual message ID from Firebase messages
    const message = messages.find(msg => msg.tempMessageId === tempMessageId);
    if (!message) {
      console.error('No message found for temp message ID:', tempMessageId);
      return;
    }

    try {
      retryVoiceMessageUpload(tempMessageId, chatId, message.id, audioBlob, duration);
    } catch (error) {
      console.error('Error retrying voice message upload:', error);
    }
  };

  const handleOnChange = (value) => {
    setNewMessage(value);
  };

  // Scroll to the bottom where latest messages are
  const scrollToBottom = () => {
    const topPosition = messageEndRef.current.offsetTop;
    const container = document.querySelector(
      '.message-list .scrollbar-container',
    );
    scrollTo(container, topPosition - 30, 600);
  };

  const handleOnSubmit = async (data) => {
    setNewMessage('');
    if (actionMessage.actionType === 'reply')
      data.replyDocId = actionMessage.message.id;
    if (actionMessage.actionType === 'edit') {
      await editMessage(currentUserId, currentChat.chatId, data, actionMessage);
    } else {
      scrollToBottom();
      await sendMessage(currentUserId, currentChat.chatId, data);
    }
    clearActionMessage();
  };

  useEffect(() => {
    if (inputRef.current) {
      inputRef.current.focus();
    }
  }, [inputRef, currentChat]);

  // Scroll to bottom when messages change
  useEffect(() => {
    if (groupMessages.length > 0 && !messagesLoading) {
      // Scroll to bottom after messages are loaded
      setTimeout(() => {
        scrollToBottom();
      }, 100);
    }
  }, [groupMessages, messagesLoading]);



  // Add click handler for the microphone/send button
  useEffect(() => {
    const handleButtonClick = () => {
      // Get the send button
      const sendButton = document.querySelector('.cs-button--send');

      if (sendButton) {
        // Remove any existing event listeners
        const newSendButton = sendButton.cloneNode(true);
        sendButton.parentNode.replaceChild(newSendButton, sendButton);

        // Add the appropriate event listener based on whether there's text in the input
        if (!newMessage.trim()) {
          // If input is empty, use the mic functionality
          console.log('Adding mic button click handler');
          newSendButton.addEventListener('click', (e) => {
            console.log('Microphone button clicked');
            e.preventDefault();
            e.stopPropagation();
            handleVoiceRecordClick();
            return false;
          });
        } else {
          // If input has text, use the send functionality
          console.log('Adding send button click handler');
          newSendButton.addEventListener('click', (e) => {
            console.log('Send button clicked');
            e.preventDefault();
            e.stopPropagation();
            handleOnSubmit({
              message: newMessage.trim()
            });
            return false;
          });
        }
      }
    };

    // Add the handler after a short delay to ensure the DOM is ready
    const timer = setTimeout(handleButtonClick, 300);

    return () => {
      clearTimeout(timer);
    };
  }, [newMessage, handleVoiceRecordClick, currentChat, currentUserId]);

  // Add keyboard shortcut for voice recording (Ctrl+Shift+V)
  useEffect(() => {
    const handleKeyDown = (e) => {
      // Check if Ctrl+Shift+V is pressed and chat is active
      if (e.ctrlKey && e.shiftKey && e.key === 'V' && currentChat) {
        e.preventDefault();
        handleVoiceRecordClick();
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, [currentChat, handleVoiceRecordClick]);

  useEffect(() => {
    if (!chatInitialized) {
      chatUnsubscribe?.();
      chatUnsubscribe = getChat(currentUserId);
      batch(() => {
        dispatch(setAuthUserId(currentUserId));
        dispatch(setChatInitialized(true));
      });
    } else if (currentUserId !== authUserId) {
      chatUnsubscribe?.();
      batch(() => {
        dispatch(removeCurrentChat());
        dispatch(setChats([]));
        dispatch(setMessages([]));
        dispatch(setAuthUserId(currentUserId));
      });
      chatUnsubscribe = getChat(currentUserId);
    }
    // eslint-disable-next-line
  }, [currentUserId]);



  const handleChatClick = (chat) => {
    if (messageUnsubscribeRef.current) messageUnsubscribeRef.current();
    batch(() => {
      dispatch(setMessagesLoading(true));
      dispatch(setCurrentChat(chat));
    });
    messageUnsubscribeRef.current = fetchMessages(chat.chatId, currentUserId);
    clearActionMessage();

    // Scroll to bottom after a short delay to allow messages to load
    setTimeout(() => {
      scrollToBottom();
    }, 500);
  };

  const deleteCurrentChat = async () => {
    await deleteChat(currentChat.chatId);
    groupMessages.forEach((group) => {
      group.messages.forEach((item) =>
        deleteMessage(currentChat.chatId, item.id),
      );
    });
    messageUnsubscribeRef.current?.();
    batch(() => {
      dispatch(removeCurrentChat());
      dispatch(setMessages([]));
    });
    setIsModalVisible(false);
    clearActionMessage();
  };

  function handleFile(event) {
    if (!SUPPORTED_FORMATS.includes(event.target.files[0].type)) {
      toast.error('Supported only image formats!');
    } else {
      setFile(event.target.files[0]);
      const reader = new FileReader();
      reader.onload = () => {
        if (reader.readyState === 2) {
          setUrl(reader.result);
          setModal(true);
        }
      };
      reader?.readAsDataURL(event.target.files[0]);
    }
  }

  const onAttachClick = () => {
    nextRef.current.click();
  };

  const clearActionMessage = () => {
    setActionMessage({ actionType: null, message: null });
    if (newMessage) setNewMessage('');
    inputRef.current?.focus();
  };

  const handleActionMessage = (actionType, message) => {
    setActionMessage({ actionType, message });
    if (actionType === 'edit') {
      setNewMessage(message.message);
    }
    inputRef.current?.focus();
  };

  const handleDelete = (message) => {
    const messageBeforeLastMessage =
      groupMessages?.at(-1)?.messages?.at(-2) ||
      groupMessages?.at(-2)?.messages?.at(-1);
    deleteMessage(currentChat.chatId, message, messageBeforeLastMessage).then();
  };


  return (
    <div style={{ height: '80vh', position: 'relative' }}>
      <input
        type='file'
        ref={nextRef}
        onChange={handleFile}
        accept='image/jpg, image/jpeg, image/png, image/svg+xml, image/svg'
        className='d-none'
      />
      <MainContainer responsive className='chat-container rounded'>
        <Sidebar position='left' scrollable={false} className='chat-sidebar'>
          <ConversationList>
            {chats
              .filter((item) => item.user.id !== undefined)
              .map((chat, idx) => {
                return (
                  <Conversation
                    onClick={() => {
                      handleChatClick(chat);
                    }}
                    key={idx}
                    name={
                      chat.user.firstname + ' ' + (chat.user.lastname || '')
                    }
                    info={chat.lastMessage}
                  >
                    <Avatar
                      src={getAvatar(chat.user?.img)}
                      name={chat.user?.firstname}
                    />
                  </Conversation>
                );
              })}
          </ConversationList>
        </Sidebar>

        <ChatContainer className='chat-container'>
          {currentChat ? (
            <ConversationHeader className='chat-header'>
              <ConversationHeader.Back />
              <Avatar
                src={getAvatar(currentChat?.user?.img)}
                name={currentChat?.user?.firstname}
              />
              <ConversationHeader.Content
                userName={`${currentChat?.user?.firstname} ${
                  currentChat?.user?.lastname || ''
                }`}
              />
              {/*  <ConversationHeader.Actions>*/}
              {/*      <Dropdown*/}
              {/*          overlay={<Menu*/}
              {/*              items={[{*/}
              {/*                  key: '1',*/}
              {/*                  label: <div>{t('delete.chat')}</div>,*/}
              {/*                  icon: <DeleteOutlined/>,*/}
              {/*                  onClick: () => setIsModalVisible(true),*/}
              {/*              },]}*/}
              {/*          />}*/}
              {/*      >*/}
              {/*<span className='more-btn'>*/}
              {/*  <MoreOutlined style={{fontSize: 22}}/>*/}
              {/*</span>*/}
              {/*      </Dropdown>*/}
              {/*  </ConversationHeader.Actions>*/}
            </ConversationHeader>
          ) : (
            ''
          )}
          <MessageList loading={messagesLoading} className='message-list'>
            <Channel
              groupMessages={groupMessages}
              messageEndRef={messageEndRef}
              handleActionMessage={handleActionMessage}
              handleDelete={handleDelete}
              handleRetryUpload={handleRetryUpload}
            />
            {actionMessage.message && (
              <MessageActionIndicator
                actionMessage={actionMessage}
                cancelMessageAction={clearActionMessage}
              />
            )}
          </MessageList>
          {groupMessages.length ? (
            <MessageInput
              ref={inputRef}
              value={newMessage}
              onChange={handleOnChange}
              onSend={(inputVal) =>
                handleOnSubmit({
                  message: inputVal
                    // eslint-disable-next-line
                    .replace(/\&nbsp;/g, '')
                    .replace(/<[^>]+>/g, '')
                    .trim(),
                })
              }
              placeholder='Message'
              className={`chat-input ${!newMessage.trim() ? 'empty-input' : ''}`}

              onAttachClick={onAttachClick}
              attachButton={true}
              sendButton={true}
              sendDisabled={false}
              autoFocus={true}
              sendOnReturnDisabled={false}
            />
          ) : null}
        </ChatContainer>
      </MainContainer>

      <UploadMedia
        modal={modal}
        url={url}
        setModal={setModal}
        file={file}
        handleOnSubmit={handleOnSubmit}
      />
      <CustomModal click={deleteCurrentChat} text={t('delete.chat')} />



      <VoiceRecordingModal
        visible={isVoiceRecordingModalVisible}
        onClose={() => setIsVoiceRecordingModalVisible(false)}
        onComplete={handleVoiceRecordingComplete}
      />
    </div>
  );
}
