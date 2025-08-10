// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:quick/application/chat/chat_bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/message_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/domain/model/model/user_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/service/voice_chat_helper.dart';
import 'package:quick/infrastructure/firebase/firebase_service.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/pages/chat/widget/send_button.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'widget/message_item.dart';

part 'chat_page_mixin.dart';

class ChatPage extends StatefulWidget {
  final UserModel? sender;
  final String? chatId;
  final ProductData? product;

  const ChatPage({super.key, required this.sender, this.chatId, this.product});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with ChatPageMixin {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      key: sendButtonKey,
      resizeToAvoidBottomInset: true, // Enable keyboard resize to push content up
      appBar: (colors) => _appBar(colors),
      body: (colors) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (p, n) {
              return p.chatModel?.docId != n.chatModel?.docId ||
                  p.isMessageLoading != n.isMessageLoading;
            },
            builder: (context, state) {
              if (state.isMessageLoading) {
                return Loading();
              } else if (widget.chatId == null &&
                  state.chatModel?.docId == null) {
                return Center(
                    child: Text(
                  AppHelpers.getTranslation(TrKeys.noMessagesHereYet),
                  style: CustomStyle.interNormal(
                      color: colors.textBlack, size: 15),
                ));
              }
              return StreamBuilder(
                  stream: FirebaseService.store
                      .collection("chat")
                      .doc(widget.chatId ?? state.chatModel?.docId ?? "")
                      .collection("message")
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<MessageModel> messages = [];
                    for (var element in snapshot.data?.docs ?? []) {
                      // Debug: Print raw data from Firebase for voice messages
                      final data = element.data();
                      if (data["type"] == "voice") {
                        debugPrint("Firebase voice message data: ${element.id} - $data");
                      }

                      messages.add(
                          MessageModel.fromJson(element.data(), element.id));
                    }
                    readMessage(messages,
                        widget.chatId ?? state.chatModel?.docId ?? "");
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
                            style:
                                CustomStyle.interNormal(color: colors.textHint),
                          ),
                        )),
                        itemBuilder: (context, MessageModel element) {
                          // print(messages.lastOrNull?.doc);
                          return MessageItem(
                            colors: colors,
                            message: element,
                            replyMessage: messages.firstWhere(
                                (e) => e.doc == element.replyDocId,
                                orElse: () => MessageModel(
                                    message: "", senderId: 0, doc: "")),
                            edit: (id) {
                              editMessageId = id;
                              messageController.text = element.message ?? "";
                              focusNode.requestFocus();
                            },
                            reply: (message) {
                              replyMessage = message;
                              focusNode.requestFocus();
                              sendButtonKey.currentState?.setState(() {});
                            },
                            delete: (id) {
                              if (messages.length > 1) {
                                deleteMessage(
                                    id,
                                    messages.firstOrNull?.doc == id
                                        ? messages[messages.length - 2]
                                        : null);
                              } else {
                                deleteMessage(null, null);
                                Navigator.pop(context);
                              }
                            },
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
      bottomNavigationBar: (colors) => BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return state.isMessageLoading
              ? SizedBox.shrink()
              : SendButton(
                  focusNode: focusNode,
                  product: product,
                  colors: colors,
                  replyMessage: replyMessage,
                  sendMessage: () {
                    editMessageId != null
                        ? editMessage()
                        : replyMessage?.doc != null
                            ? reply()
                            : sendMessage(
                                chatId: state.chatModel?.docId,
                                product: product,
                              );
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
                          event.add(ChatEvent.sendImage(
                              context: context,
                              file: titleImg,
                              chatId: widget.chatId));
                          Navigator.pop(context);
                        }
                      },
                      openGallery: () async {
                        String? titleImg = await ImgService.getGallery();
                        if (context.mounted && (titleImg != null)) {
                          event.add(ChatEvent.sendImage(
                              context: context,
                              file: titleImg,
                              chatId: widget.chatId));
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
onVoiceMessageRecorded: (audioPath, duration) {
                    // Handle voice message recording
                    debugPrint('Voice message recorded: $audioPath, duration: $duration');

                    // Get the correct chat ID
                    final chatId = widget.chatId ?? state.chatModel?.docId;
                    debugPrint('Chat ID for voice message: $chatId');
                    debugPrint('Widget chatId: ${widget.chatId}');
                    debugPrint('State chatModel docId: ${state.chatModel?.docId}');

                    // Create a local message immediately to show in the UI
                    debugPrint('Creating local voice message, path: $audioPath, duration: $duration');

                    // Get scaffold messenger but don't show loading indicator
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    // Check if we have a valid chat ID
                    if (chatId == null || chatId.isEmpty) {
                      debugPrint('❌ No valid chat ID found, creating new chat first...');
                      
                      // If no chat exists, create one first
                      if (widget.sender?.id != null) {
                        event.add(ChatEvent.createAndSendMessage(
                          context: context,
                          message: 'Chat started', // Temporary message
                          userId: widget.sender!.id,
                          onSuccess: () {
                            debugPrint('✅ Chat created successfully, now sending voice message...');
                            
                            // Wait a moment for the state to update, then send voice message
                            Future.delayed(Duration(milliseconds: 500), () {
                              final newChatId = context.read<ChatBloc>().state.chatModel?.docId;
                              debugPrint('New chat ID after creation: $newChatId');
                              
                              if (newChatId != null) {
                                final voiceChatHelper = VoiceChatHelper();
                                voiceChatHelper.sendVoiceMessage(
                                  context: context,
                                  chatId: newChatId,
                                  audioPath: audioPath,
                                  audioDuration: duration,
                                  product: product,
                                  onSuccess: () {
                                    debugPrint('✅ Voice message sent successfully after chat creation');
                                  },
                                  onError: (error) {
                                    debugPrint('❌ Error sending voice message after chat creation: $error');
                                    scaffoldMessenger.showSnackBar(
                                      SnackBar(content: Text("Error: $error")),
                                    );
                                  },
                                );
                              } else {
                                debugPrint('❌ Still no chat ID after creation');
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(content: Text("Error: Could not create chat")),
                                );
                              }
                            });
                          }
                        ));
                      } else {
                        debugPrint('❌ No sender ID available');
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text("Error: No recipient found")),
                        );
                      }
                      return;
                    }

                    // If we have a chat ID, proceed with sending voice message
                    debugPrint('✅ Using existing chat ID: $chatId');
                    final voiceChatHelper = VoiceChatHelper();
                    voiceChatHelper.sendVoiceMessage(
                      context: context,
                      chatId: chatId,
                      audioPath: audioPath,
                      audioDuration: duration,
                      product: product, // Pass the selected product
                      onSuccess: () {
                        // Voice message sent successfully, but don't show any message
                        debugPrint('✅ Voice message sent successfully to existing chat');
                      },
                      onError: (error) {
                        // Show error message but don't block the UI
                        debugPrint('❌ Error sending voice message to existing chat: $error');
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
      leading: PopButton(
        color: colors.textBlack,
        onTap: () {
          // Stop any playing voice message when navigating back
          final voiceChatHelper = VoiceChatHelper();
          voiceChatHelper.stopVoiceMessage();
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          CustomNetworkImage(
            url: widget.sender?.img,
            height: 34,
            name: widget.sender?.firstname,
            width: 34,
            radius: 17,
          ),
          8.horizontalSpace,
          Text(
            widget.sender?.firstname ?? AppHelpers.getTranslation(TrKeys.chats),
            style: CustomStyle.interSemi(color: colors.textBlack, size: 16),
          ),
        ],
      ),
    );
  }
}
