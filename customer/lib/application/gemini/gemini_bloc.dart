
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/gemini/gemini_service.dart';

part 'gemini_event.dart';

part 'gemini_state.dart';

part 'gemini_bloc.freezed.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  GeminiBloc() : super(const GeminiState()) {
    on<ImageDescribe>(imageDescribe);
  }

  imageDescribe(event, emit) async {
    emit(state.copyWith(isLoading: true));
    final res = await GeminiService.imageToDesc(
      images: event.images,
      networkImages: event.networkImages,
    );
    res.fold((l) {
      emit(state.copyWith(isLoading: false, text: l));
      event.onSuccess.call(l);
    }, (r) {
      emit(state.copyWith(isLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }
}
