part of 'media_bloc.dart';

@freezed
class MediaEvent with _$MediaEvent {
  const factory MediaEvent.setVideo({required String path}) = SetVideo;

  const factory MediaEvent.setPreview({required String path}) = SetPreview;

  const factory MediaEvent.deletePreview() = DeletePreview;

  const factory MediaEvent.uploadImage(
      {required BuildContext context,
      required ValueChanged<String> onSuccess}) = UploadImage;

  const factory MediaEvent.uploadVideo(
      {required BuildContext context,
      required ValueChanged<String> onSuccess}) = UploadVideo;
}
