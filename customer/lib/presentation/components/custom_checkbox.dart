import 'package:flutter/material.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class CustomCheckbox extends StatelessWidget {
  final CustomColorSet colors;
  final bool active;
  final String? title;
  final VoidCallback? onTap;

  const CustomCheckbox({
    super.key,
    required this.colors,
    required this.active,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ButtonEffectAnimation(
            child: Container(
              height: 18.r,
              width: 18.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 1.8,
                  color: active ? colors.textBlack : colors.textBlack,
                ),
                color: active ? colors.textBlack : colors.transparent,
              ),
              child: Icon(
                Remix.check_line,
                size: 14.r,
                color: active ? colors.textWhite : colors.transparent,
              ),
            ),
          ),
          if (title?.isNotEmpty ?? false)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title ?? '',
                style: CustomStyle.interNormal(
                  color: colors.textBlack,
                  size: 14
                ),
              ),
            )
        ],
      ),
    );
  }
}
