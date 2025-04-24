part of 'chat_page.dart';

mixin ChatPageMixin on State<ChatPage> {
  late TextEditingController messageController;
  final focusNode = FocusNode();
  final GlobalKey sendButtonKey = GlobalKey();
  String? editMessageId;
  MessageModel? replyMessage;
  ProductData? product;
  late ChatBloc event;

  @override
  void initState() {
    product = widget.product;
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    event = context.read<ChatBloc>();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  readMessage(List<MessageModel> message, String chatId) {
    for (var element in message) {
      if (element.senderId != LocalStorage.getUser().id && !element.read) {
        chatRepository.readMessage(chatDocId: chatId, docId: element.doc ?? "");
      }
    }
  }

  editMessage() {
    event.add(ChatEvent.editMessage(
      context: context,
      message: messageController.text,
      chatId: widget.chatId,
      messageId: editMessageId ?? "",
    ));
    messageController.clear();
    editMessageId = null;
    return;
  }

  deleteMessage(String? deleteMessageId, MessageModel? lastMessage) {
    event.add(ChatEvent.deleteMessage(
      context: context,
      messageId: deleteMessageId,
      chatId: widget.chatId,
      lastMessage: lastMessage,
    ));
  }

  reply() {
    event.add(ChatEvent.replyMessage(
      context: context,
      messageId: replyMessage?.doc ?? "",
      chatId: widget.chatId,
      message: messageController.text,
    ));
    replyMessage = null;
    messageController.clear();
    sendButtonKey.currentState?.setState(() {});
  }

  sendMessage({String? chatId, ProductData? product}) {
    if (messageController.text.trim().isNotEmpty) {
      if (widget.chatId == null && chatId == null) {
        event.add(ChatEvent.createAndSendMessage(
            context: context,
            message: messageController.text,
            userId: widget.sender?.id,
            onSuccess: () {
              event.add(ChatEvent.sendMessage(
                context: context,
                message: messageController.text,
                chatId: widget.chatId,
                product: product,
              ));
              messageController.clear();
            }));
        return;
      }

      event.add(ChatEvent.sendMessage(
        context: context,
        message: messageController.text,
        chatId: widget.chatId,
        product: product,
      ));
      messageController.clear();
      return;
    }
  }
}
