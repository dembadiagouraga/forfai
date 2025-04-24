import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/blur_wrap.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class DescriptionScreen extends StatelessWidget {
  final ScrollController? controller;
  final CustomColorSet colors;
  final String? description;

  const DescriptionScreen(
      {super.key,
      required this.colors,
      required this.description,
       this.controller});

  @override
  Widget build(BuildContext context) {
    return BlurWrap(
      radius: BorderRadius.only(
        topRight: Radius.circular(AppConstants.radius.r),
        topLeft: Radius.circular(AppConstants.radius.r),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppConstants.radius.r),
            topLeft: Radius.circular(AppConstants.radius.r),
          ),
        ),
        padding: EdgeInsets.symmetric( horizontal: 16.r),
        child: controller == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.verticalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.description),
                    style: CustomStyle.interBold(
                        color: colors.textBlack, size: 22),
                  ),
                  16.verticalSpace,
                  Text(
                    description ?? "",
                    style: CustomStyle.interRegular(
                        color: colors.textBlack, size: 16),
                  ),
                  32.verticalSpace
                ],
              )
            : ListView(
                padding: EdgeInsets.zero,
                controller: controller,
                shrinkWrap: true,
                children: [
                  24.verticalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.description),
                    style: CustomStyle.interBold(
                        color: colors.textBlack, size: 22),
                  ),
                  16.verticalSpace,
                  Text(
                    description ?? "",
                    style: CustomStyle.interRegular(
                        color: colors.textBlack, size: 16),
                  ),
                  32.verticalSpace
                ],
              ),
      ),
    );
  }
}
