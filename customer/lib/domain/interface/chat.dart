import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';

abstract class ChatInterface {
  Future<Either<List<ChatModel>, dynamic>> getChatList({String? lastDocId});

  Future<Either<MessageModel, dynamic>> sendMessage(
      {required MessageModel message, required String chatDocId});

  Future<Either<ChatModel, dynamic>> createChat({required int id});

  Future<Either<ChatModel, dynamic>> getChat({required int sellerId});

  Future<Either<List<UserModel>, dynamic>> showChatUser(
      {required List<int> ids});

  void deleteMessage({
    required String chatDocId,
    String? docId,
    MessageModel? lastMessage,
  });

  Future<void> deleteChat(String chatDocId);

  void readMessage({required String chatDocId, required String docId});

  void replyMessage({required String chatDocId, required MessageModel message});

  void editMessage({
    required String message,
    required String chatDocId,
    required String docId,
    required bool isLast,
  });

  Future<Either<String, dynamic>> sendVoiceMessage({
    required String chatDocId,
    required String audioPath,
    required int audioDuration,
    ProductData? product,
  });
}
