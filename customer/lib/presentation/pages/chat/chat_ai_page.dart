// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:quick/application/chat/chat_with_ai/ai_chat_bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/message_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/firebase/firebase_service.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/infrastructure/service/voice_chat_helper.dart';
import 'package:quick/presentation/pages/chat/widget/send_button.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'widget/message_item.dart';

class ChatAiPage extends StatefulWidget {
  final ProductData? product;

  const ChatAiPage({super.key, this.product});

  @override
  State<ChatAiPage> createState() => _ChatAiPageState();
}

class _ChatAiPageState extends State<ChatAiPage> {
  late TextEditingController messageController;
  final focusNode = FocusNode();
  final GlobalKey sendButtonKey = GlobalKey();
  String? editMessageId;
  MessageModel? replyMessage;
  ProductData? product;

  @override
  void initState() {
    product = widget.product;
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  readMessage(List<MessageModel> message, String chatId) {
    message.forEach((element) async {
      if (element.senderId != LocalStorage.getUser().id && !element.read) {
        chatRepository.readMessage(chatDocId: chatId, docId: element.doc ?? "");
      }
    });
  }

  editMessage() {
    context.read<AiChatBloc>().add(AiChatEvent.editMessage(
        context: context,
        message: messageController.text,
        messageId: editMessageId ?? ""));
    messageController.clear();
    editMessageId = null;
    return;
  }

  deleteMessage(String deleteMessageId) {
    context.read<AiChatBloc>().add(AiChatEvent.deleteMessage(
          context: context,
          messageId: deleteMessageId,
        ));
  }

  reply() {
    context.read<AiChatBloc>().add(AiChatEvent.replyMessage(
          context: context,
          messageId: replyMessage?.doc ?? "",
          message: messageController.text,
        ));
    replyMessage = null;
    messageController.clear();
    sendButtonKey.currentState?.setState(() {});
  }

  sendMessage({String? chatId}) {
    if (messageController.text.trim().isNotEmpty) {
      if (chatId == null) {
        context.read<AiChatBloc>().add(AiChatEvent.createAndSendMessage(
            context: context,
            message: messageController.text,
            userId: widget.product?.id,
            onSuccess: () {
              context.read<AiChatBloc>().add(AiChatEvent.sendMessage(
                    context: context,
                    message: messageController.text,
                    product: product,
                  ));
              messageController.clear();
            }));
        return;
      }

      context.read<AiChatBloc>().add(AiChatEvent.sendMessage(
            context: context,
            message: messageController.text,
            product: product,
          ));
      messageController.clear();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      key: sendButtonKey,
      appBar: (colors) => _appBar(colors),
      body: (colors) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<AiChatBloc, AiChatState>(
            buildWhen: (p, n) {
              return p.chatModel?.docId != n.chatModel?.docId ||
                  p.isMessageLoading != p.isMessageLoading;
            },
            builder: (context, state) {
              if (state.chatModel?.docId?.isNotEmpty ?? false) {
                return Center(
                    child: Text(
                  AppHelpers.getTranslation(TrKeys.noMessagesHereYet),
                  style: CustomStyle.interNormal(
                      color: colors.textBlack, size: 16),
                ));
              }
              return state.isMessageLoading
                  ? const Loading()
                  : StreamBuilder(
                      stream: FirebaseService.store
                          .collection("chat")
                          .doc(state.chatModel?.docId ?? "")
                          .collection("message")
                          .orderBy("time", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        List<MessageModel> messages = [];
                        for (var element in snapshot.data?.docs ?? []) {
                          messages.add(MessageModel.fromJson(
                              element.data(), element.id));
                        }
                        readMessage(messages, state.chatModel?.docId ?? "");
                        return Expanded(
                          child: GroupedListView<MessageModel, DateTime>(
                            elements: messages,
                            reverse: true,
                            order: GroupedListOrder.DESC,
                            groupBy: (element) => TimeService.dateFormatYMD(
                                element.time ?? DateTime.now()),
                            groupSeparatorBuilder: (DateTime groupByValue) =>
                                Center(
                                    child: Container(
                              margin: REdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                color: colors.socialButtonColor,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              padding: REdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Text(
                                TimeService.dateFormatDM(groupByValue),
                                style: CustomStyle.interNormal(
                                    color: colors.textHint),
                              ),
                            )),
                            itemBuilder: (context, dynamic element) {
                              return MessageItem(
                                colors: colors,
                                message: element,
                                replyMessage: messages.firstWhere(
                                    (e) => e.doc == element.replyDocId,
                                    orElse: () => MessageModel(
                                        message: "", senderId: 0, doc: "")),
                                edit: (id) {
                                  editMessageId = id;
                                  messageController.text =
                                      element.message ?? "";
                                  focusNode.requestFocus();
                                },
                                reply: (message) {
                                  replyMessage = message;
                                  focusNode.requestFocus();
                                  sendButtonKey.currentState?.setState(() {});
                                },
                                delete: deleteMessage,
                              );
                            },
                            itemComparator: (message, newMessage) =>
                                message.time?.compareTo(
                                    newMessage.time ?? DateTime.now()) ??
                                0,
                          ),
                        );
                      });
            },
          )
        ],
      ),
      bottomNavigationBar: (colors) => BlocBuilder<AiChatBloc, AiChatState>(
        builder: (context, state) {
          return SendButton(
            focusNode: focusNode,
            product: product,
            colors: colors,
            replyMessage: replyMessage,
            sendMessage: () {
              editMessageId != null
                  ? editMessage()
                  : replyMessage?.doc != null
                      ? reply()
                      : sendMessage(chatId: state.chatModel?.docId);
              if (product != null) {
                product = null;
                sendButtonKey.currentState?.setState(() {});
              }
            },
            controller: messageController,
            removeReplyMessage: () {
              replyMessage = null;
              focusNode.unfocus();
              sendButtonKey.currentState?.setState(() {});
            },
            sendImage: () {
              AppHelpers.openDialogImagePicker(
                context: context,
                openCamera: () async {
                  String? titleImg = await ImgService.getCamera();
                  if (context.mounted && (titleImg != null)) {
                    context.read<AiChatBloc>().add(AiChatEvent.sendImage(
                          context: context,
                          file: titleImg,
                        ));
                    Navigator.pop(context);
                  }
                },
                openGallery: () async {
                  String? titleImg = await ImgService.getGallery();
                  if (context.mounted && (titleImg != null)) {
                    context.read<AiChatBloc>().add(AiChatEvent.sendImage(
                          context: context,
                          file: titleImg,
                        ));
                    Navigator.pop(context);
                  }
                },
              );
            },
            onVoiceMessageRecorded: (audioPath, duration) {
              // Handle voice message recording
              debugPrint('Voice message recorded: $audioPath, duration: $duration');

              // Get scaffold messenger but don't show loading indicator
              final scaffoldMessenger = ScaffoldMessenger.of(context);

              final voiceChatHelper = VoiceChatHelper();
              voiceChatHelper.sendVoiceMessage(
                context: context,
                chatId: state.chatModel?.docId ?? "",
                audioPath: audioPath,
                audioDuration: duration,
                product: product, // Pass the selected product
                onSuccess: () {
                  // Voice message sent successfully, but don't show any message
                  debugPrint('Voice message sent successfully');
                },
                onError: (error) {
                  // Show error message but don't block the UI
                  debugPrint('Error sending voice message: $error');
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text("Error: $error")),
                  );
                },
              );
            },
            removeProduct: () {
              product = null;
              focusNode.unfocus();
              sendButtonKey.currentState?.setState(() {});
            },
          );
        },
      ),
    );
  }

  AppBar _appBar(CustomColorSet colors) {
    return AppBar(
      toolbarHeight: 46.r,
      backgroundColor: colors.backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0.2,
      shadowColor: colors.textBlack,
      leading: PopButton(color: colors.textBlack),
      title: Row(
        children: [
          CustomNetworkImage(
            url: widget.product?.img,
            height: 34,
            width: 34,
            radius: 17,
          ),
          8.horizontalSpace,
          Text(
            widget.product?.translation?.title ?? AppHelpers.getTranslation(TrKeys.chats),
            style: CustomStyle.interSemi(color: colors.textBlack, size: 16),
          ),
        ],
      ),
    );
  }
}
