import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/main/main_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/keyboard_dismisser.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

import 'widgets/drawer_item.dart';
import 'widgets/logout_button.dart';
import 'widgets/wallet_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (colors, controller) {
        return KeyboardDismisser(
          isLtr: LocalStorage.getLangLtr(),
          child: ListView(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shrinkWrap: true,
            children: [
              12.verticalSpace,
              LogoutButton(colors: colors),
              12.verticalSpace,
              if (LocalStorage.getToken().isNotEmpty)
                WalletScreen(colors: colors),
              12.verticalSpace,
              Divider(color: colors.divider),
              if (LocalStorage.getToken().isNotEmpty)
                DrawerItem(
                  colors: colors,
                  icon: Remix.archive_2_line,
                  title: AppHelpers.getTranslation(TrKeys.myProducts),
                  onTap: () {
                    ProductRoute.goUserProductsPage(context: context);
                  },
                ),
              if (LocalStorage.getToken().isNotEmpty)
                DrawerItem(
                  colors: colors,
                  icon: Remix.money_dollar_box_line,
                  title: AppHelpers.getTranslation(TrKeys.myPayments),
                  onTap: () {
                    SettingRoute.goTransactionList(context: context);
                  },
                ),
              DrawerItem(
                colors: colors,
                icon: Remix.heart_3_line,
                title: AppHelpers.getTranslation(TrKeys.myWishlist),
                onTap: () {
                  context
                      .read<MainBloc>()
                      .add(const MainEvent.changeIndex(index: 1));
                  context
                      .read<ProductBloc>()
                      .add(ProductEvent.fetchLikeProduct(context: context));
                },
              ),
              if (LocalStorage.getToken().isNotEmpty)
                DrawerItem(
                  colors: colors,
                  icon: Remix.stack_line,
                  title: AppHelpers.getTranslation(TrKeys.compare),
                  onTap: () {
                    ProductRoute.goComparePage(context: context);
                  },
                ),
              DrawerItem(
                colors: colors,
                icon: Remix.archive_line,
                title: AppHelpers.getTranslation(TrKeys.categories),
                onTap: () {
                  AppRoute.goAllCategoryPage(context);
                },
              ),
              if (LocalStorage.getToken().isNotEmpty &&
                  AppHelpers.getReferralActive())
                DrawerItem(
                  colors: colors,
                  icon: Remix.money_dollar_circle_line,
                  title: AppHelpers.getTranslation(TrKeys.inviteFriend),
                  onTap: () {
                    SettingRoute.goMyReferral(context: context);
                  },
                ),
              DrawerItem(
                colors: colors,
                icon: Remix.message_3_line,
                title: AppHelpers.getTranslation(TrKeys.blog),
                onTap: () {
                  AppRoute.goBlog(context: context);
                },
              ),
              12.verticalSpace,
              Divider(color: colors.divider),
              8.verticalSpace,
              DrawerItem(
                colors: colors,
                icon: Remix.settings_3_line,
                title: AppHelpers.getTranslation(TrKeys.settings),
                onTap: () {
                  SettingRoute.goSettingPage(context: context);
                },
              ),
              DrawerItem(
                colors: colors,
                icon: Remix.question_line,
                title: AppHelpers.getTranslation(TrKeys.helpInfo),
                onTap: () {
                  SettingRoute.goHelp(context: context);
                },
              ),
              DrawerItem(
                colors: colors,
                icon: Remix.alarm_warning_line,
                title: AppHelpers.getTranslation(TrKeys.privacy),
                onTap: () {
                  SettingRoute.goPolicy(context: context);
                },
              ),
              DrawerItem(
                colors: colors,
                icon: Remix.spam_line,
                title: AppHelpers.getTranslation(TrKeys.terms),
                onTap: () {
                  SettingRoute.goTerm(context: context);
                },
              ),
              if (LocalStorage.getToken().isNotEmpty)
                DrawerItem(
                  colors: colors,
                  icon: Remix.logout_circle_line,
                  title: AppHelpers.getTranslation(TrKeys.logout),
                  onTap: () {
                    AuthRoute.goLogin(context);
                    authRepository.logout();
                  },
                ),
              100.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
