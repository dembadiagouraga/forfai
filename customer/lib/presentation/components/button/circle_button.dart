import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/style.dart';

import 'animation_button_effect.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final Color borderColor;
  final double size;
  final double iconSize;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    this.size = 36,
    this.iconSize = 20,
    this.iconColor = CustomStyle.black,
    this.borderColor = CustomStyle.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Container(
        height: size.r,
        width: size.r,
        padding: REdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor)
        ),
        child: Center(
            child: Icon(
          icon,
          color: iconColor,
          size: iconSize.r,
        )),
      ),
    );
  }
}
