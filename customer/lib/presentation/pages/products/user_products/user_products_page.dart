import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/user_products/user_product_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/vertical_list_page.dart';

class UserProductsPage extends StatefulWidget {
  const UserProductsPage({super.key});

  @override
  State<UserProductsPage> createState() => _UserProductsPageState();
}

class _UserProductsPageState extends State<UserProductsPage>
    with SingleTickerProviderStateMixin {
  final isLtr = LocalStorage.getLangLtr();
  late RefreshController activeController;
  late RefreshController waitingController;
  late RefreshController unActiveController;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    activeController = RefreshController();
    waitingController = RefreshController();
    unActiveController = RefreshController();
    tabController.addListener(
      () {
        if (!(tabController.indexIsChanging)) {
          context
              .read<UserProductBloc>()
              .add(UserProductEvent.setIndex(index: tabController.index));
        }
      },
    );
    super.initState();
  }

  void onRefresh(RefreshController refreshController) {
    context.read<UserProductBloc>().add(UserProductEvent.fetchActiveProduct(
        context: context, controller: refreshController, isRefresh: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProductBloc, UserProductState>(
      builder: (context, state) {
        return CustomScaffold(
          appBar: (colors) => CustomAppBar(
            colors: colors,
            context: context,
            title: TrKeys.myProducts,
            actions: [
              Column(
                children: [
                  SecondButton(
                    title: AppHelpers.getTranslation(TrKeys.add),
                    bgColor: colors.primary,
                    titleColor: colors.textWhite,
                    onTap: () => ProductRoute.goCreateProductPage(context),
                  ),
                ],
              ),
              8.horizontalSpace,
            ],
          ),
          body: (colors) => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: TabBar(
                  padding: EdgeInsets.zero,
                  isScrollable: false,
                  controller: tabController,
                  indicatorColor: colors.textBlack,
                  indicatorPadding: REdgeInsets.symmetric(horizontal: 16),
                  labelColor: colors.textBlack,
                  unselectedLabelColor: CustomStyle.unselectTabBar,
                  unselectedLabelStyle: CustomStyle.interNormal(
                    size: 14,
                    color: CustomStyle.unselectLayout,
                  ),
                  labelStyle: CustomStyle.interSemi(
                    size: 14,
                    color: colors.textBlack,
                  ),
                  labelPadding: EdgeInsets.zero,
                  tabs: listTabs(colors),
                ),
              ),
              Divider(color: colors.newBoxColor, height: 2, thickness: 2),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _active(state, colors),
                    _waiting(state, colors),
                    _unActive(state, colors),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Tab> listTabs(CustomColorSet colors) {
    return [
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<UserProductBloc, UserProductState>(
                builder: (context, state) {
              return Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: state.tabIndex == 0
                      ? colors.textBlack
                      : CustomStyle.unselectTabBar,
                  borderRadius:
                      BorderRadius.circular(AppConstants.radius / 0.5),
                ),
                child: Text(
                  '${state.activeLength ?? 0}',
                  style: CustomStyle.interNormal(
                      color: colors.textWhite, size: 14),
                ),
              );
            }),
            4.horizontalSpace,
            Text(AppHelpers.getTranslation(TrKeys.active)),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<UserProductBloc, UserProductState>(
                builder: (context, state) {
              return Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: state.tabIndex == 1
                      ? colors.textBlack
                      : CustomStyle.unselectTabBar,
                  borderRadius:
                      BorderRadius.circular(AppConstants.radius / 0.5),
                ),
                child: Text(
                  '${state.waitingLength ?? 0}',
                  style: CustomStyle.interNormal(
                      color: colors.textWhite, size: 14),
                ),
              );
            }),
            4.horizontalSpace,
            Flexible(
              child: AutoSizeText(
                AppHelpers.getTranslation(TrKeys.waiting),
                minFontSize: 16,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<UserProductBloc, UserProductState>(
                builder: (context, state) {
              return Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: state.tabIndex == 2
                      ? colors.textBlack
                      : CustomStyle.unselectTabBar,
                  borderRadius:
                      BorderRadius.circular(AppConstants.radius / 0.5),
                ),
                child: Text(
                  '${state.unActiveLength ?? 0}',
                  style: CustomStyle.interNormal(
                      color: colors.textWhite, size: 14),
                ),
              );
            }),
            4.horizontalSpace,
            Flexible(
              child: AutoSizeText(
                AppHelpers.getTranslation(TrKeys.unActive),
                minFontSize: 16,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  _active(UserProductState state, CustomColorSet colors) {
    return state.isLoadingActive
        ? const UProductShimmer()
        : VerticalListPage(
            colors: colors,
            list: state.activeProducts,
            refreshController: activeController,
            onLoading: () {
              context.read<UserProductBloc>().add(
                  UserProductEvent.fetchActiveProduct(
                      context: context, controller: activeController));
            },
            onRefresh: () {
              context.read<UserProductBloc>().add(
                  UserProductEvent.fetchActiveProduct(
                      context: context,
                      controller: activeController,
                      isRefresh: true));
            },
          );
  }

  _waiting(UserProductState state, CustomColorSet colors) {
    return state.isLoadingWaiting
        ? const UProductShimmer()
        : VerticalListPage(
            list: state.waitingProducts,
            refreshController: waitingController,
            onLoading: () {
              context.read<UserProductBloc>().add(
                  UserProductEvent.fetchWaitingProduct(
                      context: context, controller: waitingController));
            },
            onRefresh: () {
              context.read<UserProductBloc>().add(
                  UserProductEvent.fetchWaitingProduct(
                      context: context,
                      controller: waitingController,
                      isRefresh: true));
            },
            colors: colors,
          );
  }

  _unActive(UserProductState state, CustomColorSet colors) {
    return state.isLoadingUnActive
        ? const UProductShimmer()
        : VerticalListPage(
            colors: colors,
            list: state.unActiveProducts,
            refreshController: unActiveController,
            onLoading: () {
              context.read<UserProductBloc>().add(
                  UserProductEvent.fetchUnActiveProduct(
                      context: context, controller: unActiveController));
            },
            onRefresh: () {
              context.read<UserProductBloc>().add(
                  UserProductEvent.fetchUnActiveProduct(
                      context: context,
                      controller: unActiveController,
                      isRefresh: true));
            },
          );
  }

  @override
  void dispose() {
    tabController.dispose();
    activeController.dispose();
    waitingController.dispose();
    unActiveController.dispose();
    super.dispose();
  }
}
