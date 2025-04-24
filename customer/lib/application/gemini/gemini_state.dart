part of 'gemini_bloc.dart';

@freezed
class GeminiState with _$GeminiState {
  const factory GeminiState({
    @Default(null) String? text,
    @Default(false) bool isLoading,
  }) = _GeminiState;
}