part of 'media_bloc.dart';

@freezed
class MediaState with _$MediaState {
  const factory MediaState({
    @Default(false) bool isLoading,
    @Default(null) String? videoPath,
    @Default(null) String? imagePath,
  }) = _MediaState;
}
