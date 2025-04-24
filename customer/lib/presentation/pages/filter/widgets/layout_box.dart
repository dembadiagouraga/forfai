import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/presentation/style/style.dart';

class LayoutBox extends StatelessWidget {
  final bool active;
  final double height;
  final double width;
  final double radius;

  const LayoutBox({
    super.key,
    required this.active,
    this.height = 32,
    this.width = 16,
    this.radius = AppConstants.radius / 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.r),
        color: active ? CustomStyle.primary : CustomStyle.unselectLayout,
      ),
      height: height.r,
      width: width.r,
    );
  }
}
