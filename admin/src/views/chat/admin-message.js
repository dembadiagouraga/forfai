import React, { useEffect, useState } from 'react';
import moment from 'moment';
import { Message } from '@chatscope/chat-ui-kit-react';
import { IoCheckmarkOutline, IoCheckmarkDone } from 'react-icons/io5';
import { FaReply } from 'react-icons/fa';
import { MdOutlineModeEditOutline } from 'react-icons/md';
import { RiDeleteBin6Fill } from 'react-icons/ri';
import { Dropdown, Menu } from 'antd';
import { useSelector } from 'react-redux';
import { fetchRepliedMessage } from '../../firebase';
import ReplyMessage from './replyMessage';
import VoiceMessageBubble from '../../components/VoiceMessageBubble';

const AdminMessage = ({ data, onActionMessage, onDeleteMessage }) => {
  const { type, time, message, read, replyDocId } = data;
  const currentChatId = useSelector((state) => state.chat?.currentChat?.chatId);

  const [replyMessage, setReplyMessage] = useState(null);
  const handleMenuClick = ({ key }) => {
    switch (key) {
      case 'delete':
        return onDeleteMessage();
      default:
        return onActionMessage(key);
    }
  };
  const menu = (
    <Menu onClick={handleMenuClick}>
      <Menu.Item key='reply' icon={<FaReply />}>
        Reply
      </Menu.Item>
      {type !== 'image' && type !== 'voice' && (
        <Menu.Item key='edit' icon={<MdOutlineModeEditOutline />}>
          Edit
        </Menu.Item>
      )}
      <Menu.Item key='delete' icon={<RiDeleteBin6Fill />} danger>
        Delete
      </Menu.Item>
    </Menu>
  );
  useEffect(() => {
    if (replyDocId) {
      return fetchRepliedMessage(replyDocId, currentChatId, setReplyMessage);
    }
    // eslint-disable-next-line
  }, []);
  return (
    <div className='admin-message-wrapper'>
      <div className={`admin-message ${type === 'image' && 'chat-image'} ${type === 'voice' && 'chat-voice'}`}>
        <Dropdown overlay={menu} trigger={['contextMenu']}>
          <div>
            {replyMessage && <ReplyMessage replyMessage={replyMessage} />}
            {type === 'image' ? (
              <Message
                type='image'
                model={{
                  direction: 'incoming',
                  payload: {
                    src: message,
                    alt: 'Image',
                    width: '100%',
                    height: '100%',
                  },
                }}
              />
            ) : type === 'voice' ? (
              (() => {
                // Use audioDuration first (customer format), then duration (admin format), then fallback
                const voiceDuration = data.audioDuration || data.duration || 6;

                // Debug admin voice message issues
                if (voiceDuration <= 1) {
                  console.warn('Admin voice message has short duration:', voiceDuration, 'for message:', data.id);
                }

                return (
                  <VoiceMessageBubble
                    key={`voice-${data.id}-${message}`} // ✅ CRITICAL FIX: Stable key to prevent old messages from remounting
                    audioUrl={message}
                    duration={voiceDuration}
                    isAdmin={true}
                    messageId={data.id || ''}
                    tempMessageId={data.tempMessageId || null}
                    onRetryUpload={data.onRetryUpload || null}
                  />
                );
              })()
            ) : (
              <div className='text'>{message}</div>
            )}
          </div>
        </Dropdown>

        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'flex-end', marginTop: '4px' }}>
          <div className='time'>{moment(new Date(time)).format('HH:mm')}</div>
          <span className='double-check'>
            {read ? (
              <IoCheckmarkDone size={12} />
            ) : (
              <IoCheckmarkOutline size={12} />
            )}
          </span>
        </div>
      </div>
    </div>
  );
};

export default AdminMessage;
