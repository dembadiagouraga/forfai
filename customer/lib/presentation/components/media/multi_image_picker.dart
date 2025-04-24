import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/components/media/custom_image_picker.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../blur_wrap.dart';
import '../button/animation_button_effect.dart';

class MultiImagePicker extends StatelessWidget {
  final List<String?>? listOfImages;
  final List<Galleries?>? imageUrls;
  final Function(String) onDelete;
  final Function(String) onImageChange;
  final CustomColorSet colors;

  const MultiImagePicker({
    super.key,
    this.listOfImages,
    required this.onDelete,
    this.imageUrls,
    required this.onImageChange,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    int itemCount = (listOfImages?.length ?? 0) + (imageUrls?.length ?? 0);
    return SizedBox(
      height: 158.h,
      child: itemCount == 0
          ? DottedBorder(
              dashPattern: const [8],
              color: CustomStyle.icon,
              strokeWidth: 2.6,
              borderType: BorderType.RRect,
              radius: Radius.circular(AppConstants.radius.r),
              child: Container(
                margin: REdgeInsets.all(6),
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius.r),
                ),
                child: InkWell(
                  onTap: () => ImgService.getPhotoGallery(onImageChange),
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
                          Remix.image_add_line,
                          color: colors.textHint,
                          size: 36.r,
                        ),
                        8.verticalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.uploadPhoto),
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
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: itemCount + 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: REdgeInsets.only(right: 12),
                          height: 124.r,
                          width: 124.r,
                          child: itemCount == index
                              ? CustomImagePicker(
                                  width: 124.r,
                                  height: 124.r,
                                  onImageChange: onImageChange,
                                  onDelete: () {},
                                  colors: colors,
                                )
                              : Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: CustomNetworkImage(
                                        fileImage: (imageUrls?.length ?? 0) >
                                                index
                                            ? null
                                            : File(listOfImages?[index -
                                                    (imageUrls?.length ?? 0)] ??
                                                ""),
                                        url: (imageUrls?.length ?? 0) > index
                                            ? imageUrls![index]?.path
                                            : null,
                                        radius: 12,
                                        fit: BoxFit.cover,
                                        height: 124.r,
                                        width: 124.r,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: REdgeInsets.all(6),
                                        child: ButtonEffectAnimation(
                                          onTap: () {
                                            String path;
                                            try {
                                              path = (imageUrls?.length ?? 0) >
                                                      index
                                                  ? imageUrls![index]?.path ??
                                                      ''
                                                  : listOfImages?[index -
                                                          (imageUrls?.length ??
                                                              0)] ??
                                                      "";
                                            } catch (e) {
                                              path = listOfImages?[(index -
                                                      (imageUrls?.length ??
                                                          0))] ??
                                                  "";
                                            }
                                            onDelete(path);
                                          },
                                          child: BlurWrap(
                                            blur: 8,
                                            radius: BorderRadius.circular(20.r),
                                            child: Container(
                                              height: 32.r,
                                              width: 32.r,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colors.white
                                                    .withValues(alpha: 0.15),
                                              ),
                                              child: Icon(
                                                Remix.delete_bin_fill,
                                                color: colors.white,
                                                size: 16.r,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      }),
                ),
                8.verticalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.photoUploadDesc),
                  style: CustomStyle.interNormal(color: colors.textHint,size: 12),
                ),
              ],
            ),
    );
  }
}
