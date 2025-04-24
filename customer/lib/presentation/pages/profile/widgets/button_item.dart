import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class ButtonItem extends StatelessWidget {
  final CustomColorSet colors;
  final IconData icon;
  final String title;
  final String? selectValue;
  final String? onTitle;
  final String? offTitle;
  final VoidCallback onTap;
  final bool? value;

  const ButtonItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.colors,
    this.selectValue,
    this.value,
    this.onTitle,
    this.offTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      disabled: value == null,
      onTap: value == null ? onTap : null,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 4.r),
        decoration: BoxDecoration(
          color: colors.newBoxColor,
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: value != null ? 14 : 18,
        ),
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
                style: CustomStyle.interNormal(color: colors.textBlack, size: 16),
                maxLines: 2,
              ),
            ),
            Text(
              selectValue ?? "",
              style: CustomStyle.interNormal(color: colors.textBlack, size: 12),
            ),
            if (value == null)
              Icon(
                Remix.arrow_right_s_line,
                color: colors.textBlack,
              ),
            if (value != null)
              CustomToggle(
                  offTitle: offTitle,
                  onTitle: onTitle,
                  isOnline: value ?? false,
                  onChange: (s) => onTap(),
                  colors: colors)
          ],
        ),
      ),
    );
  }
}
