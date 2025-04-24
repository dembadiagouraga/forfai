import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/media/media_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../blur_wrap.dart';
import '../button/animation_button_effect.dart';
import 'media_dialog.dart';

class HorizontalVideoPicker extends StatelessWidget {
  final Galleries? video;
  final ValueChanged<Galleries> onUpload;
  final VoidCallback? onDelete;
  final CustomColorSet colors;

  const HorizontalVideoPicker({
    super.key,
     this.onDelete,
    required this.video,
    required this.colors,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [8],
      color: CustomStyle.icon,
      strokeWidth: 2.6,
      borderType: BorderType.RRect,
      radius: Radius.circular(AppConstants.radius.r),
      child: Container(
        margin: REdgeInsets.all(6),
        height: 150.r,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
        ),
        child: (video == null)
            ? InkWell(
                onTap: () {
                  ImgService.getVideoGallery((videoPath) {
                    AppHelpers.showAlertDialog(
                      context: context,
                      colors: colors,
                      child: BlocProvider(
                        create: (context) => MediaBloc()
                          ..add(MediaEvent.setVideo(path: videoPath)),
                        child: MediaDialog(
                          onUpload: onUpload,
                          colors: colors,
                        ),
                      ),
                    );
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 180.h,
                  decoration: BoxDecoration(
                    color: colors.socialButtonColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: REdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Remix.video_upload_line,
                        color: colors.textHint,
                        size: 36.r,
                      ),
                      8.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.uploadVideo),
                        style: CustomStyle.interNormal(
                          size: 14,
                          color: colors.textHint,
                          textDecoration: TextDecoration.underline,
                          letterSpacing: -0.3,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  SizedBox(
                    height: 150.r,
                    width: MediaQuery.sizeOf(context).width,
                    child: CustomNetworkImage(
                      url: video?.path,
                      preview: video?.preview,
                      width: double.infinity,
                      radius: AppConstants.radius,
                      fit: BoxFit.cover,
                      height: 150.r,
                    ),
                  ),
                  Positioned(
                    top: 12.r,
                    right: 16.r,
                    child: Row(
                      children: [
                        if (video != null && onDelete != null)
                          ButtonEffectAnimation(
                            child: GestureDetector(
                              onTap: onDelete,
                              child: BlurWrap(
                                radius: BorderRadius.circular(AppConstants.radius.r),
                                child: Container(
                                  height: 36.r,
                                  width: 36.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.primary.withValues(alpha: 0.5),
                                  ),
                                  child: Icon(
                                    Remix.delete_bin_fill,
                                    color: colors.white,
                                    size: 18.r,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
