import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/chat_model.dart';
import 'package:quick/domain/model/model/message_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<CheckChatId>(checkChatId);
    on<CreateAndSendMessage>(createAndSendMessage);
    on<SendMessage>(sendMessage);
    on<SendImage>(sendImage);
    on<EditMessage>(editMessage);
    on<ReplyMessage>(replyMessage);
    on<DeleteMessage>(deleteMessage);
    on<GetChatList>(getChatList);
  }

  String? lastDocId;

  checkChatId(event, emit) async {
    emit(state.copyWith(isMessageLoading: true));
    final res = await chatRepository.getChat(sellerId: event.sellerId);
    res.fold((l) {
      emit(state.copyWith(chatModel: l, isMessageLoading: false));
    }, (r) {
      emit(state.copyWith(isMessageLoading: false));
    });
  }

  createAndSendMessage(event, emit) async {
    final res = await chatRepository.createChat(id: event.userId);
    res.fold((l) async {
      emit(state.copyWith(chatModel: l));
      event.onSuccess();
    }, (r) {
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  sendMessage(event, emit) {
    chatRepository.sendMessage(
        chatDocId: event.chatId ?? state.chatModel?.docId ?? "",
        message: MessageModel(
          message: event.message,
          product: event.product == null
              ? null
              : Product.fromJson(event.product.toJsonForChat()),
          senderId: LocalStorage.getUser().id ?? 0,
          doc: "",
        ));
    if (event.product != null) {
      productsRepository.getMessage(slug: event.product.slug);
    }
  }

  sendImage(event, emit) async {
    emit(state.copyWith(isButtonLoading: true));
    final res =
        await galleryRepository.uploadImage(event.file, UploadType.chats);
    res.fold((image) {
      chatRepository.sendMessage(
          chatDocId: event.chatId ?? state.chatModel?.docId ?? "",
          message: MessageModel(
              message: image.imageData?.title,
              senderId: LocalStorage.getUser().id ?? 0,
              type: "image",
              doc: ""));
      emit(state.copyWith(isButtonLoading: false));
    }, (r) {
      emit(state.copyWith(isButtonLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  editMessage(event, emit) {
    chatRepository.editMessage(
      chatDocId: event.chatId ?? state.chatModel?.docId ?? "",
      message: event.message,
      docId: event.messageId,
      isLast: event.messageId == state.chatModel?.lastMessageId,
    );
  }

  replyMessage(event, emit) {
    chatRepository.replyMessage(
      chatDocId: event.chatId ?? state.chatModel?.docId ?? "",
      message: MessageModel(
          message: event.message,
          senderId: LocalStorage.getUser().id ?? 0,
          doc: "",
          replyDocId: event.messageId),
    );
  }

  deleteMessage(event, emit) {
    chatRepository.deleteMessage(
      chatDocId: event.chatId ?? state.chatModel?.docId ?? "",
      docId: event.messageId,
      lastMessage: event.lastMessage,
    );
  }

  deleteChat(event, emit) async {
    await chatRepository.deleteChat(
      event.chatId ?? state.chatModel?.docId ?? "",
    );
    add(
      ChatEvent.getChatList(
        context: event.context,
        isRefresh: true,
      ),
    );
  }

  getChatList(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      lastDocId = null;
      emit(state.copyWith(isLoading: state.chatList.isEmpty));
    }
    final res = await chatRepository.getChatList(lastDocId: lastDocId);
    res.fold((data) {
      if (event.isRefresh ?? false) {
        emit(state.copyWith(chatList: []));
      }
      if (data.isEmpty) {
        event.controller?.loadNoData();
        emit(state.copyWith(isLoading: false));
        return;
      }
      lastDocId = data.last.docId;
      List<ChatModel> list =
          (event.isRefresh ?? false) ? [] : List.from(state.chatList);
      list.addAll(data);
      emit(state.copyWith(isLoading: false, chatList: list));
      if (event.isRefresh ?? false) {
        event.controller?.refreshCompleted();
        return;
      }
      event.controller?.loadComplete();
      return;
    }, (failure) {
      emit(state.copyWith(isLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: failure);
    });
  }
}
