

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/infrastructure/service/services.dart';

part 'media_event.dart';

part 'media_state.dart';

part 'media_bloc.freezed.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(const MediaState()) {
    on<SetVideo>(setVideo);
    on<SetPreview>(setPreview);
    on<DeletePreview>(deletePreview);
    on<UploadVideo>(uploadVideo);
    on<UploadImage>(uploadImage);
  }

  setVideo(event, emit) {
    emit(state.copyWith(videoPath: event.path));
  }

  setPreview(event, emit) {
    emit(state.copyWith(imagePath: event.path));
  }

  deletePreview(event, emit) {
    emit(state.copyWith(imagePath: null));
  }

  uploadImage(event, emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await galleryRepository.uploadImage(
        state.imagePath!, UploadType.products);
    response.fold((image) async {
      event.onSuccess.call(image.imageData?.title ?? '');
      emit(state.copyWith(isLoading: false));
    }, (failure) {
      emit(state.copyWith(isLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: failure);
    });
  }

  uploadVideo(event, emit) async {
    emit(state.copyWith(isLoading: true));
    final res = await galleryRepository.uploadImage(
        state.videoPath!, UploadType.products);
    res.fold((video) {
      emit(state.copyWith(isLoading: false));
      event.onSuccess.call(video.imageData?.title ?? '');
    }, (failure) {
      emit(state.copyWith(isLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: failure);
    });
  }
}
