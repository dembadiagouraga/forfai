import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/model/user_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class SellerInfo extends StatelessWidget {
  final CustomColorSet colors;
  final UserModel? user;

  const SellerInfo({super.key, required this.colors, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.radius.r),
        onTap: () async {
          ProductRoute.goProductList(
            context: context,
            userId: user?.id,
            title: user?.firstname,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radius.r),
            border: Border.all(color: colors.icon),
          ),
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Row(
                children: [
                  CustomNetworkImage(
                    url: user?.img,
                    name: user?.firstname ?? AppHelpers.getTranslation(TrKeys.unKnow),
                    height: 44,
                    width: 44,
                    radius: 22,
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          user?.firstname ?? AppHelpers.getTranslation(TrKeys.unKnow),
                          style: CustomStyle.interNormal(
                              color: colors.textBlack, size: 16),
                          maxLines: 2,
                        ),
                        Text(
                          "${AppHelpers.getTranslation(TrKeys.id).toUpperCase()} ${user?.id ?? 0}",
                          style: CustomStyle.interRegular(
                              color: colors.textBlack, size: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              Container(
                width: double.infinity,
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius.r),
                  border: Border.all(color: colors.border),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${AppHelpers.getTranslation(TrKeys.registeredSince)} ${TimeService.dateFormatSince(user?.registeredAt)}',
                  style:
                      CustomStyle.interNormal(color: colors.textHint, size: 14),
                ),
              ),
              8.verticalSpace,
              Container(
                width: double.infinity,
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius.r),
                  border: Border.all(color: colors.textBlack),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Remix.archive_line,
                      size: 21.r,
                      color: colors.textBlack,
                    ),
                    8.horizontalSpace,
                    Text(
                      AppHelpers.getTranslation(TrKeys.allAdsByTheAuthor),
                      style: CustomStyle.interNormal(
                        color: colors.textBlack,
                        size: 15,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
