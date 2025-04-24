import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/notification/notification_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/notification_item.dart';
import 'widgets/notification_shimmer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late RefreshController controller;

  @override
  void initState() {
    controller = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onLoading(RefreshController refreshController) {
    context.read<NotificationBloc>().add(NotificationEvent.fetchNotification(
          context: context,
          controller: refreshController,
        ));
  }

  void onRefresh(RefreshController refreshController) {
    context.read<NotificationBloc>().add(NotificationEvent.fetchNotification(
          context: context,
          controller: refreshController,
          isRefresh: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: Column(
          children: [
            Row(
              children: [
                PopButton(color: colors.textBlack),
                Text(
                  AppHelpers.getTranslation(TrKeys.notification),
                  style: CustomStyle.interSemi(
                      color: colors.textBlack, size: 18),
                )
              ],
            ),
            8.verticalSpace,
            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                return state.isLoading
                    ? const NotificationShimmer()
                    : state.notifications.isNotEmpty
                        ? Expanded(
                            child: SmartRefresher(
                              controller: controller,
                              enablePullUp: true,
                              enablePullDown: true,
                              onLoading: () {
                                onLoading(controller);
                              },
                              onRefresh: () {
                                onRefresh(controller);
                              },
                              child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 100.r),
                                shrinkWrap: true,
                                itemCount: state.notifications.length,
                                itemBuilder: (context, index) {
                                  return NotificationItem(
                                    colors: colors,
                                    notification: state.notifications[index],
                                  );
                                },
                              ),
                            ),
                          )
                        : _empty(context, colors);
              },
            )
          ],
        ),
      ),
      floatingButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingButton: (colors) => _buildButton(colors),
    );
  }

  Widget _empty(BuildContext context, CustomColorSet colors) {
    return Column(
      children: [
        32.verticalSpace,
        Lottie.asset("assets/lottie/notification_empty.json",
            width: MediaQuery.sizeOf(context).width / 1.5),
        32.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.yourNotificationListIsEmpty),
          style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
        )
      ],
    );
  }

  Widget _buildButton(CustomColorSet colors) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        return state.notifications.isNotEmpty
            ? ButtonEffectAnimation(
                onTap: () {
                  context
                      .read<NotificationBloc>()
                      .add(NotificationEvent.readAll(context: context));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: CustomStyle.black,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.r, vertical: 24.r),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Remix.check_double_line,
                        color: CustomStyle.white,
                      ),
                      8.horizontalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.markAsRead),
                        style: CustomStyle.interSemi(
                            color: colors.white, size: 16),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
