// ignore_for_file: prefer_is_empty

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/application/chat/chat_bloc.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/pages/chat/chat_list_page.dart';
import 'package:quick/presentation/pages/like/like_page.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/main/main_bloc.dart';
import 'package:quick/application/notification/notification_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/infrastructure/firebase/firebase_service.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

import 'package:quick/presentation/pages/home/home_page.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

import '../profile/profile_page.dart';
import 'widgets/bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final isLtr = LocalStorage.getLangLtr();
  Timer? timer;

  List<IndexedStackChild> list = [
    IndexedStackChild(child: const HomePage()),
    IndexedStackChild(child: const LikePage()),
    IndexedStackChild(child: const ChatListPage()),
    IndexedStackChild(child: const ProfilePage()),
  ];

  @override
  void initState() {
    if (LocalStorage.getToken().isNotEmpty) {
      userRepository.getProfileDetails(context);
      settingsRepository.getAdminInfo();
      productsRepository.getProductsByIds(LocalStorage.getLikedProductsList());
      if (LocalStorage.getToken().isNotEmpty) {
        timer = Timer.periodic(
            Duration(seconds: AppConstants.timeRefresh.inSeconds), (Timer t) {
          context
              .read<NotificationBloc>()
              .add(NotificationEvent.fetchCount(context: context));
        });
      }
    }
    FirebaseService.initDynamicLinks(context);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBody: true,
      appBar: _buildAppBar,
      body: (colors) => BlocBuilder<MainBloc, MainState>(
        buildWhen: (l, n) {
          return l.selectIndex != n.selectIndex;
        },
        builder: (context, state) {
          return ProsteIndexedStack(
            index: state.selectIndex,
            children: list,
          );
        },
      ),
      floatingButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingButton: _floatActionButton,
      bottomNavigationBar: _bottomNavigationBar,
    );
  }

  AppBar _buildAppBar(CustomColorSet colors) {
    return AppBar(
      backgroundColor: colors.backgroundColor,
      elevation: 0.2,
      shadowColor: colors.textHint,
      actions: [
        GestureDetector(
            onTap: () {
              SettingRoute.goSelectCountry(context: context);
            },
            child: Row(
              children: [
                Icon(
                  Remix.map_pin_line,
                  color: colors.textBlack,
                ),
                4.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocalStorage.getAddress()?.city ??
                          LocalStorage.getAddress()?.country ??
                          '',
                      style: CustomStyle.interRegular(color: colors.textBlack,size: 12),
                    ),
                  ],
                )
              ],
            )),
        // IconButton(
        //     onPressed: () {
        //       if (LocalStorage.getToken().isEmpty) {
        //         AuthRoute.goLogin(context);
        //         return;
        //       }
        //       AppRoute.goNotification(context: context);
        //     },
        //     icon: LocalStorage.getToken().isNotEmpty
        //         ? BlocBuilder<NotificationBloc, NotificationState>(
        //             builder: (context, state) {
        //               return Badge(
        //                 isLabelVisible:
        //                     (state.countOfNotifications?.notification ?? 0) > 0,
        //                 label: Text(
        //                     "${state.countOfNotifications?.notification ?? 0}"),
        //                 child: Icon(
        //                   Remix.notification_3_line,
        //                   color: colors.textBlack,
        //                 ),
        //               );
        //             },
        //           )
        //         : Badge(
        //             isLabelVisible: false,
        //             child: Icon(
        //               Remix.notification_3_line,
        //               color: colors.textBlack,
        //             ),
        //           )),
        12.horizontalSpace,
      ],
      centerTitle: false,
      title: AppHelpers.getType() == 1
          ? _oneTitle(colors)
          : Text(
              AppHelpers.getAppName(),
              style: CustomStyle.interBold(color: colors.textBlack, size: 16),
            ),
    );
  }

  _oneTitle(CustomColorSet colors) {
    return InkWell(
      onTap: () {
        SettingRoute.goSelectCountry(context: context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.selectAddress),
                style:
                    CustomStyle.interNormal(color: colors.textHint, size: 12),
              ),
              Icon(
                Remix.arrow_right_s_line,
                color: colors.textHint,
              )
            ],
          ),
          Text(
            "${LocalStorage.getAddress()?.country ?? ""} ${LocalStorage.getAddress()?.city ?? ""}",
            style: CustomStyle.interBold(color: colors.textBlack, size: 14),
          ),
        ],
      ),
    );
  }

  Widget _floatActionButton(CustomColorSet colors) {
    return BlocBuilder<MainBloc, MainState>(buildWhen: (l, n) {
      return l.selectIndex != n.selectIndex;
    }, builder: (context, state) {
      return FloatingActionButton(
        backgroundColor: CustomStyle.primary,
        onPressed: () {
          if (LocalStorage.getToken().isNotEmpty) {
            ProductRoute.goCreateProductPage(context);
          } else {
            AuthRoute.goLogin(context);
          }
        },
        child: const Center(
          child: Icon(Remix.add_line),
        ),
      );
    });
  }

  Widget _bottomNavigationBar(CustomColorSet colors) {
    return BlocBuilder<MainBloc, MainState>(buildWhen: (l, n) {
      return l.selectIndex != n.selectIndex;
    }, builder: (context, state) {
      return AnimatedBottomNavigationBar(
        colors: colors,
        icons: const [
          Remix.home_2_line,
          Remix.heart_line,
          Remix.message_3_line,
          Remix.user_3_line,
        ],
        activeIndex: state.selectIndex,
        onTap: (index) {
          if (index == 1) {
            context
                .read<ProductBloc>()
                .add(ProductEvent.fetchLikeProduct(context: context));
          }
          if (index == 2) {
            if (LocalStorage.getToken().isEmpty) {
              AuthRoute.goLogin(context);
              return;
            }
            context
                .read<ChatBloc>()
                .add(ChatEvent.getChatList(context: context, isRefresh: true));
          }
          context.read<MainBloc>().add(
                MainEvent.changeIndex(index: index),
              );
        },
      );
    });
  }
}
