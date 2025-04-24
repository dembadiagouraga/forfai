import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/response/banners_paginate_response.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../blur_wrap.dart';
import '../media/custom_network_image.dart';

class BannerBottomSheet extends StatelessWidget {
  final BannerData banner;
  final CustomColorSet colors;

  const BannerBottomSheet(
      {super.key, required this.banner, required this.colors});

  @override
  Widget build(BuildContext context) {
    return BlurWrap(
      radius: BorderRadius.only(
        topRight: Radius.circular(AppConstants.radius.r),
        topLeft: Radius.circular(AppConstants.radius.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.newBoxColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppConstants.radius.r),
            topLeft: Radius.circular(AppConstants.radius.r),
          ),
        ),
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomNetworkImage(
                  url: banner.img ?? banner.galleries?.first.path,
                  preview: banner.img != null
                      ? null
                      : banner.galleries?.first.preview,
                  height: 180,
                  width: double.infinity,
                  radius: 24),
              16.verticalSpace,
              Text(
                banner.translation?.description ?? "",
                style: CustomStyle.interNormal(
                  color: colors.textBlack,
                  size: 18,
                ),
              ),
              16.verticalSpace,
              Text(
                banner.translation?.description ?? "",
                style: CustomStyle.interRegular(
                  color: colors.textBlack,
                  size: 16,
                ),
              ),
              24.verticalSpace,
              CustomButton(
                  title: TrKeys.viewProducts,
                  bgColor: CustomStyle.black,
                  titleColor: CustomStyle.white,
                  onTap: () {
                    ProductRoute.goProductList(
                        context: context,
                        title: banner.translation?.description ?? "",
                        bannerId: banner.id);
                  }),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
