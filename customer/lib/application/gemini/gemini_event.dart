part of 'gemini_bloc.dart';

@freezed
class GeminiEvent with _$GeminiEvent {
  const factory GeminiEvent.imageDescribe({
    required BuildContext context,
    required List<String> images,
    required List<String> networkImages,
    required ValueChanged<String> onSuccess,
  }) = ImageDescribe;
}
