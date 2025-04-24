import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:remixicon/remixicon.dart';

class GenerateButton extends StatelessWidget {
  final CustomColorSet colors;
  final bool isLoading;
  final VoidCallback onTap;

  const GenerateButton({
    super.key,
    required this.colors,
    this.isLoading = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          gradient: CustomStyle.primaryGradient,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular((AppConstants.radius / 0.8).r),
            topLeft: Radius.circular((AppConstants.radius / 0.8).r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              AppHelpers.getTranslation(
                isLoading ? TrKeys.generating : TrKeys.generate,
              ),
              style: CustomStyle.interNormal(
                color: colors.white,
                size: 14,
              ),
            ),
            4.horizontalSpace,
            isLoading
                ? LoadingAnimationWidget.waveDots(
                    color: colors.white,
                    size: 18.r,
                  )
                : Icon(
                    Remix.ai_generate,
                    color: colors.white,
                    size: 18.r,
                  ),
          ],
        ),
      ),
    );
  }
}
