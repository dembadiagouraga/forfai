import moment from 'moment';
import {store} from "../store";


export function getMessages(messages) {
    const groups = messages
        .reduce((groups, item) => {
            const date = moment(item.time).format('DD-MM-YYYY');
            if (!groups[date]) {
                groups[date] = [];
            }
            const {auth} = store.getState();
            // Log the raw item from Redux store
            console.log('Raw message from Redux store:', item);

            const messageData = {
                time: item.time,
                sender: auth?.user?.id !== item?.senderId,
                read: item.read,
                id: item.id,
                replyDocId: item.replyDocId,
                message: item.message,
                type: item.type,
                duration: item.duration, // Include duration field
                isLast: item.isLast
            }

            // Log the processed message data
            console.log('Processed message data:', messageData);
            groups[date].push(messageData);
            return groups;
        }, {});
    // Sort dates in ascending order (oldest first)
    const groupArrays = Object.keys(groups)
        .sort((a, b) => moment(a, 'DD-MM-YYYY').valueOf() - moment(b, 'DD-MM-YYYY').valueOf())
        .map((date) => {
            return {
                date,
                messages: groups[date],
            };
        });
    return groupArrays;
}

export function getAllUnreadMessages(messages) {
    return messages.filter((item) => item.unread && Boolean(item.sender));
}

export function getChatDetails(chat, messages) {
    const chatMessages = messages.filter((item) => item.chat_id === chat.id);
    const lastMessage = chatMessages[chatMessages.length - 1];
    const unreadMessages = chatMessages.filter(
        (item) => item.unread && Boolean(item.sender)
    );

    return {lastMessage, unreadMessages};
}
