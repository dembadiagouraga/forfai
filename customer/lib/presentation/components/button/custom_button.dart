import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/loading.dart';
import 'package:quick/presentation/style/style.dart';

import 'animation_button_effect.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final bool changeColor;
  final double radius;
  final Color bgColor;
  final Color titleColor;
  final Color borderColor;
  final double? height;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.title,
    this.radius = AppConstants.radius,
    required this.bgColor,
    required this.titleColor,
    required this.onTap,
    this.height,
    this.isLoading = false,
    this.changeColor = false,
    this.borderColor = CustomStyle.transparent,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: height?.r,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.r),
            color: bgColor,
            border: Border.all(color: borderColor)),
        padding: padding ??
            EdgeInsets.symmetric(
                vertical: borderColor != CustomStyle.transparent ? 13.r : 14.r,
                horizontal: 16),
        child: Center(
          child: isLoading
              ? Loading(
                  changeColor: changeColor,
                  size: 24,
                )
              : AutoSizeText(
                  AppHelpers.getTranslation(title),
                  style: CustomStyle.interSemi(color: titleColor),
                  maxLines: 1,
                ),
        ),
      ),
    );
  }
}
