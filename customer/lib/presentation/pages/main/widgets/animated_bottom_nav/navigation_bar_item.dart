import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class NavigationBarItem extends StatelessWidget {
  final CustomColorSet? colors;
  final bool isActive;
  final double bubbleRadius;
  final IconData? iconData;
  final double iconScale;
  final VoidCallback onTap;
  final Widget? child;

  const NavigationBarItem({
    super.key,
    required this.bubbleRadius,
    required this.iconData,
    required this.iconScale,
    required this.onTap,
    this.child,
    required this.isActive, this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: InkWell(
          splashColor: CustomStyle.transparent,
          focusColor: CustomStyle.transparent,
          highlightColor: CustomStyle.transparent,
          hoverColor: CustomStyle.transparent,
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: isActive ? iconScale : 1,
                child: Container(
                  padding: REdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors?.socialButtonColor,
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: child ??
                      Icon(
                        iconData,
                        size: 24,
                        color: isActive ? CustomStyle.primary : colors?.textBlack,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
