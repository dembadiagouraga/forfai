import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class DrawerItem extends StatelessWidget {
  final CustomColorSet colors;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.colors,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: colors.textBlack,
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style:
                    CustomStyle.interNormal(color: colors.textBlack, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
