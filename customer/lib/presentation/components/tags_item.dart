import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class TagsItem extends StatelessWidget {
  final CustomColorSet colors;
  final String title;

  const TagsItem({super.key, required this.colors, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(right: 8),
      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.socialButtonColor,
        borderRadius: BorderRadius.circular(100),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: CustomStyle.interNormal(color: colors.textBlack, size: 14),
      ),
    );
  }
}
