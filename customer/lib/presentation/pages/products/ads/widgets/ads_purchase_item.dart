import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/model/ad_model.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class AdsPurchaseItem extends StatelessWidget {
  final CustomColorSet colors;
  final AdModel ads;
  final VoidCallback onSelect;

  const AdsPurchaseItem({
    super.key,
    required this.colors,
    required this.ads,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 1.4,
      margin: REdgeInsets.only(right: 16),
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(AppConstants.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ads.translation?.title ?? AppHelpers.getTranslation(TrKeys.standart),
            style: CustomStyle.interSemi(
              color: colors.textBlack,
              size: 20,
            ),
          ),
          const Spacer(),
          Text(
            AppHelpers.numberFormat( ads.price),
            style: CustomStyle.interSemi(
              color: colors.textBlack,
              size: 20,
            ),
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: _feature(
                  "${ads.count ?? 0} ${AppHelpers.getTranslation(TrKeys.times).toLowerCase()}",
                  colors,
                ),
              ),
              Expanded(
                child: _feature(
                  "${ads.time} ${AppHelpers.getTranslation(ads.timeType ?? '').toLowerCase()}",
                  colors,
                ),
              )
            ],
          ),
          const Spacer(),
          CustomButton(
            title: TrKeys.buyNow,
            bgColor: colors.transparent,
            titleColor: colors.textBlack,
            borderColor: colors.textBlack,
            onTap: onSelect,
          )
        ],
      ),
    );
  }
}

_feature(String title, CustomColorSet colors) {
  return Padding(
    padding: REdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(
          Remix.checkbox_circle_line,
          color: colors.primary,
          size: 24.r,
        ),
        8.horizontalSpace,
        Text(
          title,
          style: CustomStyle.interNormal(color: colors.textBlack),
        ),
      ],
    ),
  );
}
