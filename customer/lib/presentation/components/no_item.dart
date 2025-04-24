import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class NoItem extends StatelessWidget {
  final CustomColorSet colors;
  final String title;

  const NoItem({
    super.key,
    required this.colors,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset('assets/lottie/noItem.json'),
          16.verticalSpace,
          Text(
            AppHelpers.getTranslation(title),
            style: CustomStyle.interSemi(color: colors.textBlack, size: 16),
          ),
        ],
      ),
    );
  }
}
