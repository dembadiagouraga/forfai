import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class PopButton extends StatelessWidget {
  final Color? color;
  final CustomColorSet? colors;
  final VoidCallback? onTap;

  const PopButton({super.key, this.color, this.colors, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors?.newBoxColor,
        borderRadius: BorderRadius.circular((AppConstants.radius/1.2).r),
      ),
      padding: REdgeInsets.all(4),
      child: IconButton(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(colors?.transparent),
            overlayColor: WidgetStatePropertyAll(colors?.transparent),
            backgroundColor: WidgetStatePropertyAll(colors?.transparent),
            shadowColor: WidgetStatePropertyAll(colors?.transparent),
        ),
        onPressed: () {
          // Always use the provided onTap if available, otherwise use default behavior
          if (onTap != null) {
            onTap!();
          } else {
            Navigator.pop(context);
          }
        },
        icon: Icon(
          Remix.arrow_left_s_line,
          color: colors?.textBlack ?? color ?? CustomStyle.white,
        ),
      ),
    );
  }
}
