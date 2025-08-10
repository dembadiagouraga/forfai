import React from 'react';
import ChatDate from './chat-date';
import AdminMessage from './admin-message';
import UserMessage from './user-message';

export default function Channel({ groupMessages, messageEndRef, handleActionMessage, handleDelete, handleRetryUpload}) {
  // Log the group messages for debugging
  console.log('Channel component received groupMessages:', groupMessages);

  return (
    <div className='chat-box'>
      {groupMessages.map((item, key) => (
        <div key={key}>
          {item.date !== 'Invalid date' ? <ChatDate date={item.date} /> : ''}
          <div className='sms-box'>
            {item.messages.map((item) => {
              // Log each message for debugging
              console.log('Message in Channel component:', item);

              return Boolean(item.sender) ? (
                <UserMessage
                  key={item.id}
                  data={item}
                  onActionMessage={(actionType) => handleActionMessage(actionType, item)}
                />
              ) : (
                <AdminMessage
                  key={item.id}
                  data={{
                    ...item,
                    onRetryUpload: handleRetryUpload
                  }}
                  onActionMessage={(actionType) => handleActionMessage(actionType, item)}
                  onDeleteMessage={() => handleDelete(item)}
                />
              );
            })}
          </div>
        </div>
      ))}
      <div ref={messageEndRef} />
    </div>
  );
}
