import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/response/notification_response.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../../../components/blur_wrap.dart';

class NotificationBottomSheetSheet extends StatelessWidget {
  final NotificationModel notification;
  final CustomColorSet colors;
  final ScrollController? controller;

  const NotificationBottomSheetSheet(
      {super.key,
      required this.notification,
      required this.colors,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return BlurWrap(
      radius: BorderRadius.only(
        topRight: Radius.circular(AppConstants.radius.r),
        topLeft: Radius.circular(AppConstants.radius.r),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.newBoxColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppConstants.radius.r),
            topLeft: Radius.circular(AppConstants.radius.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: controller == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.verticalSpace,
                  Text(
                    notification.title ?? "",
                    style: CustomStyle.interBold(
                        color: colors.textBlack, size: 22),
                  ),
                  16.verticalSpace,
                  Text(
                    notification.body ?? "",
                    style: CustomStyle.interRegular(
                        color: colors.textBlack, size: 16),
                  ),
                  32.verticalSpace
                ],
              )
            : ListView(
                padding: EdgeInsets.zero,
                controller: controller,
                shrinkWrap: true,
                children: [
                  24.verticalSpace,
                  Text(
                    notification.title ?? "",
                    style: CustomStyle.interBold(
                        color: colors.textBlack, size: 22),
                  ),
                  16.verticalSpace,
                  Text(
                    notification.body ?? "",
                    style: CustomStyle.interRegular(
                        color: colors.textBlack, size: 16),
                  ),
                  32.verticalSpace
                ],
              ),
      ),
    );
  }
}
