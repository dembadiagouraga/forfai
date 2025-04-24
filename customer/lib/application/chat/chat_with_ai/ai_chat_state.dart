part of 'ai_chat_bloc.dart';

@freezed
class AiChatState with _$AiChatState {
  const factory AiChatState({
    @Default(true) bool isLoading,
    @Default(false) bool isButtonLoading,
    @Default(true) bool isMessageLoading,
    @Default(null) ChatModel? chatModel,
    @Default([]) List<ChatModel> chatList,
  }) = _AiChatState;
}
