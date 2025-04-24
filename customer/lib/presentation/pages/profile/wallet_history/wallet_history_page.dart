import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/application/profile/wallet/wallet_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/pages/notification/widgets/notification_shimmer.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'fill_wallet_screen.dart';
import 'send_price_screen.dart';
import 'widgets/wallet_history_item.dart';

class WalletHistoryPage extends StatefulWidget {
  const WalletHistoryPage({super.key});

  @override
  State<WalletHistoryPage> createState() => _WalletHistoryPageState();
}

class _WalletHistoryPageState extends State<WalletHistoryPage> {
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
    context.read<WalletBloc>().add(WalletEvent.fetchTransactions(
          context: context,
          controller: refreshController,
        ));
  }

  void onRefresh(RefreshController refreshController) {
    context.read<WalletBloc>().add(WalletEvent.fetchTransactions(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PopButton(color: colors.textBlack),
                Text(
                  AppHelpers.getTranslation(TrKeys.transactions),
                  style:
                      CustomStyle.interSemi(color: colors.textBlack, size: 18),
                ),
                8.horizontalSpace,
                Flexible(
                  child: SecondButton(
                      title: TrKeys.send,
                      bgColor: colors.primary,
                      titleColor: colors.white,
                      onTap: () {
                        AppHelpers.showCustomModalBottomSheetDrag(
                          context: context,
                          modal: (c) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                  value: context.read<ProfileBloc>()),
                              BlocProvider.value(
                                  value: context.read<WalletBloc>()),
                            ],
                            child: SenPriceScreen(
                              colors: colors,
                            ),
                          ),
                        );
                      }),
                ),
                8.horizontalSpace,
                Flexible(
                  child: SecondButton(
                      title: TrKeys.topUp,
                      bgColor: colors.primary,
                      titleColor: colors.white,
                      onTap: () {
                        AppHelpers.showCustomModalBottomSheetDrag(
                          context: context,
                          modal: (c) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                  value: context.read<ProfileBloc>()),
                              BlocProvider.value(
                                  value: context.read<WalletBloc>()),
                            ],
                            child: FillWalletScreen(colors: colors),
                          ),
                        );
                      }),
                ),
                16.horizontalSpace
              ],
            ),
            8.verticalSpace,
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                return state.isTransactionLoading
                    ? const NotificationShimmer()
                    : state.transactions.isNotEmpty
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
                                itemCount: state.transactions.length,
                                itemBuilder: (context, index) {
                                  return WalletHistoryItem(
                                      colors: colors,
                                      transaction: state.transactions[index]);
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
          AppHelpers.getTranslation(TrKeys.yourTransactionsListIsEmpty),
          style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
        )
      ],
    );
  }
}
