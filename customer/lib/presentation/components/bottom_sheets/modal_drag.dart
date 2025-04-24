import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class ModalDrag extends StatelessWidget {
  final CustomColorSet colors;
  const ModalDrag({super.key, required this.colors}) ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          8.verticalSpace,
          Container(
            width: 48.r,
            height: 4.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.r),
              color: colors.socialButtonColor,
            ),
          ),
          18.verticalSpace,
        ],
      ),
    );
  }
}
