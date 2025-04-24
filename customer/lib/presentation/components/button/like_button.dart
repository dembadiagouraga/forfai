import 'package:flutter/material.dart';
import 'package:quick/presentation/components/blur_wrap.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class LikeButton extends StatelessWidget {
  final CustomColorSet colors;
  final bool isActive;
  final VoidCallback onTap;

  const LikeButton({
    super.key,
    required this.colors,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(4),
      child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: REdgeInsets.all(4),
            child: BlurWrap(
              radius: BorderRadius.circular(50.r),
              child: Container(
                padding: REdgeInsets.only(top: 4, left: 4, right: 4, bottom: 3),
                decoration: BoxDecoration(
                  color: colors.backgroundColor.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: isActive
                    ? Icon(
                        Remix.heart_3_fill,
                        color: CustomStyle.red,
                        size: 22.r,
                      )
                    : Icon(
                        Remix.heart_3_line,
                        size: 22.r,
                        color: colors.textBlack,
                      ),
              ),
            ),
          )),
    );
  }
}
