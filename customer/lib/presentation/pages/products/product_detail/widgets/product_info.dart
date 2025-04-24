import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:readmore/readmore.dart';

class ProductInfo extends StatelessWidget {
  final CustomColorSet colors;
  final String? description;

  const ProductInfo({
    super.key,
    required this.colors,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return description?.isNotEmpty ?? false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Text(
                  AppHelpers.getTranslation(TrKeys.description),
                  style:
                      CustomStyle.interSemi(color: colors.textBlack, size: 18),
                ),
              ),
              12.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: ReadMoreText(
                  '${description ?? ""} ',
                  trimMode: TrimMode.Line,
                  trimLines: 6,
                  trimCollapsedText: AppHelpers.getTranslation(TrKeys.showMore),
                  trimExpandedText: AppHelpers.getTranslation(TrKeys.showLess),
                  lessStyle: CustomStyle.interRegular(
                    size: 14,
                    textDecoration: TextDecoration.underline,
                    color: colors.textHint,
                  ),
                  moreStyle: CustomStyle.interRegular(
                    size: 14,
                    textDecoration: TextDecoration.underline,
                    color: colors.textHint,
                  ),
                  style: CustomStyle.interRegular(
                      color: colors.textHint, size: 14, letterSpacing: -0.3),
                  textAlign: TextAlign.start,
                ),
              ),
              8.verticalSpace,
              Divider(color: colors.divider, thickness: 1.r),
            ],
          )
        : const SizedBox.shrink();
  }
}
