import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/notification/notification_bloc.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'widgets/button_item.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                PopButton(color: colors.textBlack),
                8.horizontalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.account),
                  style:
                      CustomStyle.interSemi(color: colors.textBlack, size: 18),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      if (LocalStorage.getToken().isEmpty) {
                        AuthRoute.goLogin(context);
                        return;
                      }
                      AppRoute.goNotification(context: context);
                    },
                    icon: Badge(
                      label: (LocalStorage.getToken().isEmpty)
                          ? const Text("0")
                          : BlocBuilder<NotificationBloc, NotificationState>(
                              builder: (context, state) {
                                return Text(state
                                        .countOfNotifications?.notification
                                        .toString() ??
                                    "0");
                              },
                            ),
                      child: Icon(
                        Remix.notification_line,
                        color: colors.textBlack,
                      ),
                    ))
              ],
            ),
            _user(colors),
            ButtonItem(
                icon: Remix.settings_3_line,
                title: AppHelpers.getTranslation(TrKeys.contactInformation),
                onTap: () {
                  SettingRoute.goEditProfile(context: context, colors: colors);
                },
                colors: colors),
            ButtonItem(
                icon: Remix.lock_2_line,
                title: AppHelpers.getTranslation(TrKeys.changePassword),
                onTap: () {
                  SettingRoute.goChangePassword(context: context, colors: colors);
                },
                colors: colors),
            ButtonItem(
                icon: Remix.hotel_line,
                title: AppHelpers.getTranslation(TrKeys.selectAddress),
                onTap: () {
                  SettingRoute.goSelectCountry(context: context);
                },
                colors: colors),
            if (LocalStorage.getToken().isNotEmpty)
              ButtonItem(
                colors: colors,
                icon: Remix.logout_box_line,
                title: AppHelpers.getTranslation(TrKeys.deleteAccount),
                onTap: () {
                  AppHelpers.showCustomDialog(
                      context: context,
                      content: Container(
                        decoration: BoxDecoration(
                            color: colors.backgroundColor,
                            borderRadius: BorderRadius.circular(8.r)),
                        padding: EdgeInsets.all(16.r),
                        child: _deleteAlert(colors, context),
                      ));
                },
              )
          ],
        ),
      ),
    );
  }

  _user(CustomColorSet colors) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (p, n) {
        return p.isLoading != n.isLoading;
      },
      builder: (context, state) {
        return Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CustomNetworkImage(
                url: LocalStorage.getUser().img,
                name: LocalStorage.getUser().firstname ??
                    LocalStorage.getUser().lastname,
                height: 68,
                width: 68,
                radius: AppConstants.radius / 0.8,
              ),
              8.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalStorage.getUser().firstname ?? "",
                      style: CustomStyle.interNormal(
                          color: colors.textBlack, size: 20),
                      maxLines: 1,
                    ),
                    Text(
                      "${AppHelpers.getTranslation(TrKeys.id.toUpperCase())}-${LocalStorage.getUser().id ?? " "}",
                      style: CustomStyle.interRegular(
                          color: colors.textHint, size: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _deleteAlert(CustomColorSet colors, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppHelpers.getTranslation(TrKeys.areYouSureDeleteAccount),
          style: CustomStyle.interNormal(color: colors.textBlack, size: 18),
        ),
        16.verticalSpace,
        Row(
          children: [
            Expanded(
              child: CustomButton(
                  title: TrKeys.back,
                  bgColor: colors.newBoxColor,
                  titleColor: colors.textBlack,
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
            16.horizontalSpace,
            Expanded(
              child: CustomButton(
                  title: TrKeys.yes,
                  bgColor: colors.primary,
                  titleColor: colors.white,
                  onTap: () {
                    AuthRoute.goLogin(context);
                    authRepository.deleteAccount();
                  }),
            )
          ],
        )
      ],
    );
  }
}
