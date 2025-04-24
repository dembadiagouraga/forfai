function ReplyMessage({replyMessage}) {
    return <div className='reply-message'>
        {replyMessage.type === 'image' ?
            <img className="reply-message__image" src={replyMessage.message} alt={replyMessage.message}/> :
        replyMessage.type === 'voice' ?
            <p className='reply-message__text'>
                🎤 {replyMessage.duration ?
                    `${Math.floor(replyMessage.duration / 60).toString().padStart(2, '0')}:${Math.floor(replyMessage.duration % 60).toString().padStart(2, '0')}` :
                    'Voice message'}
            </p> :
            <p className='reply-message__text'>{replyMessage.message}</p>
        }
    </div>
}

export default ReplyMessage