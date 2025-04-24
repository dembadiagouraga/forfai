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
  // Log the full data object
  console.log('AdminMessage component received data:', data);

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
              // Log voice message data for debugging
              console.log('Admin voice message data:', { ...data, audioUrl: message }) ||
              <VoiceMessageBubble
                audioUrl={message}
                duration={data.duration || 0}
                isAdmin={true}
              />
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
