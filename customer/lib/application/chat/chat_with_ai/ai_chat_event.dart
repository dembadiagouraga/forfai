part of 'ai_chat_bloc.dart';

@freezed
abstract class AiChatEvent with _$AiChatEvent {
  const factory AiChatEvent.checkChatId(
      {required BuildContext context, required int? sellerId}) = CheckChatId;

  const factory AiChatEvent.sendImage({
    required BuildContext context,
    required String file,
  }) = SendImage;

  const factory AiChatEvent.sendMessage({
    required BuildContext context,
    required String message,
    required ProductData? product,
  }) = SendMessage;

  const factory AiChatEvent.editMessage({
    required BuildContext context,
    required String message,
    required String messageId,
  }) = EditMessage;

  const factory AiChatEvent.replyMessage({
    required BuildContext context,
    required String message,
    required String messageId,
  }) = ReplyMessage;

  const factory AiChatEvent.deleteMessage({
    required BuildContext context,
    required String messageId,
  }) = DeleteMessage;

  const factory AiChatEvent.createAndSendMessage(
      {required BuildContext context,
      required String message,
      required int? userId,
      required Function onSuccess}) = CreateAndSendMessage;

  const factory AiChatEvent.getChatList({
    required BuildContext context,
    bool? isRefresh,
    RefreshController? controller,
  }) = GetChatList;
}
