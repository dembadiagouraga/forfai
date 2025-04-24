import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../blur_wrap.dart';

class ModalWrap extends StatelessWidget {
  final Widget child;
  final Color? color;
  final CustomColorSet colors;

  const ModalWrap({
    super.key,
    required this.child,
    this.color,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return BlurWrap(
      radius: BorderRadius.only(
        topLeft: Radius.circular(AppConstants.radius.r),
        topRight: Radius.circular(AppConstants.radius.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstants.radius.r),
            topRight: Radius.circular(AppConstants.radius.r),
          ),
          color: color ?? colors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: colors.black.withValues(alpha: 0.25),
              offset: const Offset(0, -2),
              blurRadius: 40,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: MediaQuery.viewInsetsOf(context),
        child: child,
      ),
    );
  }
}
