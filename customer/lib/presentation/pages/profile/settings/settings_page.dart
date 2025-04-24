import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/pages/profile/widgets/button_item.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
                  AppHelpers.getTranslation(TrKeys.settings),
                  style:
                      CustomStyle.interSemi(color: colors.textBlack, size: 18),
                ),
              ],
            ),
            24.verticalSpace,
            if (AppConstants.isDemo)
              ButtonItem(
                colors: colors,
                icon: Remix.magic_line,
                title: AppHelpers.getTranslation(TrKeys.selectUiType),
                onTap: () {
                  SettingRoute.goSelectUIType(context: context);
                },
              ),
            ButtonItem(
                icon: Remix.global_line,
                title: AppHelpers.getTranslation(TrKeys.language),
                selectValue: LocalStorage.getLanguage()?.title,
                onTap: () {
                  SettingRoute.goLanguage(context: context);
                },
                colors: colors),
            ButtonItem(
                icon: Remix.money_dollar_circle_line,
                title: AppHelpers.getTranslation(TrKeys.currency),
                selectValue: LocalStorage.getSelectedCurrency()?.symbol,
                onTap: () {
                  SettingRoute.goCurrency(context: context);
                },
                colors: colors),
            ThemeWrapper(builder: (colors, controller) {
              return ButtonItem(
                  icon: Remix.sun_line,
                  title: AppHelpers.getTranslation(TrKeys.appTheme),
                  onTap: () {
                    controller.toggle();
                  },
                  value: !controller.mode.isDark,
                  colors: colors);
            }),
            ButtonItem(
                icon: Remix.notification_line,
                title: AppHelpers.getTranslation(TrKeys.getNotification),
                onTap: () {
                  if (LocalStorage.getToken().isNotEmpty) {
                    userRepository.updateNotification(
                        notifications: LocalStorage.getUser().notification);
                  }
                },
                value: ((LocalStorage.getUser().notification?.isNotEmpty ??
                            false)
                        ? (LocalStorage.getUser().notification?.first.active ??
                            1)
                        : 1) ==
                    1,
                onTitle: AppHelpers.getTranslation(TrKeys.on),
                offTitle: AppHelpers.getTranslation(TrKeys.off),
                colors: colors),
            if (AppConstants.activeAi)
              ButtonItem(
                icon: Remix.ai_generate,
                title: AppHelpers.getTranslation(TrKeys.useAiGenerate),
                onTap: () => LocalStorage.changeAiActive(),
                value: LocalStorage.getAiActive(),
                onTitle: AppHelpers.getTranslation(TrKeys.on),
                offTitle: AppHelpers.getTranslation(TrKeys.off),
                colors: colors,
              ),
          ],
        ),
      ),
      floatingButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingButton: (colors) => ButtonEffectAnimation(
        onTap: () {
          if (LocalStorage.getToken().isEmpty) {
            AuthRoute.goLogin(context);
            return;
          }
          AppRoute.goChat(
            context: context,
            sender: LocalStorage.getAdmin(),
          );
        },
        child: Container(
          padding: REdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Remix.message_3_fill,
                color: colors.white,
              ),
              10.horizontalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.onlineChat),
                style:
                    CustomStyle.interSemi(color: CustomStyle.white, size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
