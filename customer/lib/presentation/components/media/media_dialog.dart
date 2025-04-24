import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/media/media_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import '../button/second_button.dart';
import 'custom_image_picker.dart';
import 'video_item.dart';

class MediaDialog extends StatelessWidget {
  final ValueChanged<Galleries> onUpload;
  final CustomColorSet colors;

  const MediaDialog({
    super.key,
    required this.onUpload,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<MediaBloc>();
    return BlocBuilder<MediaBloc, MediaState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.videoPath != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoItem(
                    url: state.videoPath,
                    height: 180,
                    isNetwork: false,
                    width: MediaQuery.sizeOf(context).width / 1.4,
                  ),
                  12.verticalSpace,
                  Text(
                    '${AppHelpers.getTranslation(TrKeys.preview)}*',
                    style: CustomStyle.interNormal(color: colors.textBlack),
                  ),
                  4.verticalSpace,
                  CustomImagePicker(
                    imageFilePath: state.imagePath,
                    onImageChange: (path) {
                      notifier.add(MediaEvent.setPreview(path: path));
                    },
                    onDelete: () {
                      notifier.add(const MediaEvent.deletePreview());
                    },
                    width: MediaQuery.sizeOf(context).width / 1.4,
                    colors: colors,
                  ),
                  12.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SecondButton(
                        bgColor: colors.socialButtonColor,
                        title: TrKeys.cancel,
                        titleColor: colors.textBlack,
                        onTap: () => Navigator.pop(context),
                      ),
                      6.horizontalSpace,
                      SecondButton(
                        bgColor: colors.primary,
                        titleColor: colors.textWhite,
                        isLoading: state.isLoading,
                        title: TrKeys.save,
                        onTap: () {
                          if (state.imagePath == null) {
                            AppHelpers.errorSnackBar(
                              context: context,
                              message:
                                  AppHelpers.getTranslation(TrKeys.pleaseUploadPreview),
                            );
                          } else {
                            notifier.add(MediaEvent.uploadImage(
                                context: context,
                                onSuccess: (image) {
                                  notifier.add(MediaEvent.uploadVideo(
                                      context: context,
                                      onSuccess: (video) {
                                        onUpload.call(Galleries(
                                          path: video,
                                          preview: image,
                                        ));
                                        Navigator.pop(context);
                                      }));
                                }));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
