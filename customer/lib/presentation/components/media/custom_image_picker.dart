import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../blur_wrap.dart';
import '../button/animation_button_effect.dart';

class CustomImagePicker extends StatelessWidget {
  final String? imageFilePath;
  final String? imageUrl;
  final String? preview;
  final Function(String) onImageChange;
  final VoidCallback? onDelete;
  final bool isAdding;
  final double width;
  final double radius;
  final double height;
  final CustomColorSet colors;

  const CustomImagePicker({
    super.key,
    required this.onImageChange,
    this.onDelete,
    this.imageFilePath,
    this.imageUrl,
    this.isAdding = false,
    this.width = double.infinity,
    this.height = 172,
    this.preview,
    this.radius = AppConstants.radius,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.r,
      width: width.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.r),
      ),
      child: Stack(
        children: [
          ButtonEffectAnimation(
            onTap: () async => ImgService.getPhotoGallery(onImageChange),
            child: SizedBox(
              width: width.r,
              height: height.r,
              child: (imageFilePath != null || imageUrl != null)
                  ? CustomNetworkImage(
                      url: imageUrl,
                      height: height.r,
                      fileImage:
                          imageFilePath != null ? File(imageFilePath!) : null,
                      preview: preview,
                      width: width,
                      radius: radius,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: width.r,
                      height: height.r,
                      decoration: BoxDecoration(
                        color: colors.socialButtonColor,
                        borderRadius: BorderRadius.circular(radius.r),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Remix.image_add_fill,
                            color: colors.textHint,
                            size: 24.r,
                          ),
                          6.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.uploadPhoto),
                            style: CustomStyle.interNormal(
                              size: 14,
                              color: colors.textHint,
                              textDecoration: TextDecoration.underline,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      )),
                    ),
            ),
          ),
          Positioned(
            top: 12.h,
            right: 16.w,
            child: Row(
              children: [
                if (imageFilePath != null && onDelete != null)
                  ButtonEffectAnimation(
                    child: GestureDetector(
                      onTap: onDelete,
                      child: BlurWrap(
                        radius: BorderRadius.circular(radius.r),
                        child: Container(
                          height: 36.r,
                          width: 36.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.white.withValues(alpha: 0.15),
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
    );
  }
}
