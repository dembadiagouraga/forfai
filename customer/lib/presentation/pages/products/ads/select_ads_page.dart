import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quick/application/ads/ads_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/components/no_item.dart';
import 'package:quick/presentation/components/shimmer/ads_shimmer.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'widgets/ads_purchase_item.dart';
import 'widgets/ads_item.dart';

class SelectAdsPage extends StatefulWidget {
  final ProductData? product;

  const SelectAdsPage({super.key, this.product});

  @override
  State<SelectAdsPage> createState() => _SelectAdsPageState();
}

class _SelectAdsPageState extends State<SelectAdsPage> {
  late RefreshController adsRefresh;
  late RefreshController userAdsRefresh;

  @override
  void initState() {
    adsRefresh = RefreshController();
    userAdsRefresh = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    adsRefresh.dispose();
    userAdsRefresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: _appBar,
      body: (colors) {
        return widget.product?.productAds != null
            ? Column(
                children: [
                  _product(colors),
                  Expanded(child: _havePlan(colors))
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _product(colors),
                    _perfectPlan(colors),
                    _purchasePlan(colors),
                    _noItem(colors),
                    32.verticalSpace,
                    if (widget.product?.id == null) 56.verticalSpace
                  ],
                ),
              );
      },
      floatingButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingButton: (colors) => Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.product?.id == null)
              CustomButton(
                  title: TrKeys.publishWithoutAds,
                  bgColor: colors.textBlack,
                  titleColor: colors.textWhite,
                  onTap: () {
                    ProductRoute.goUserProductsPage(context: context);
                  }),
          ],
        ),
      ),
    );
  }

  _havePlan(CustomColorSet colors) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (MediaQuery.sizeOf(context).height / 4.4).verticalSpace,
          RichText(
            text: TextSpan(
                text: AppHelpers.getTranslation(TrKeys.youHaveAlreadyAdsPlan),
                style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
                children: [
                  TextSpan(
                    text:
                        " ${widget.product?.productAds?.userAdsPackage?.adsPackage?.translation?.title ?? ''}",
                    style: CustomStyle.interSemi(
                        color: colors.textBlack, size: 18),
                  ),
                ]),
          ),
          8.verticalSpace,
          Text(
            '${AppHelpers.getTranslation(TrKeys.adsId)} #${widget.product?.productAds?.userAdsPackage?.adsPackage?.id ?? 0}',
            style: CustomStyle.interNormal(color: colors.textBlack, size: 16),
          ),
          8.verticalSpace,
          Text(
            '${AppHelpers.getTranslation(TrKeys.expiredAt)}: ${TimeService.dateFormatMDYHm(widget.product?.productAds?.expiredAt?.toLocal())}',
            style: CustomStyle.interNormal(color: colors.textHint, size: 16),
          ),
        ],
      ),
    );
  }

  _perfectPlan(CustomColorSet colors) {
    return BlocBuilder<AdsBloc, AdsState>(
      builder: (context, state) {
        return state.userAds.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(thickness: 1.r, height: 8.r),
                  12.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.weHavePlan),
                      style: CustomStyle.interSemi(
                          color: colors.textBlack, size: 20),
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.advertiseYourAd),
                      style: CustomStyle.interNormal(
                          color: colors.textHint, size: 14),
                    ),
                  ),
                  SizedBox(
                    height: 360.r,
                    child: state.isLoading
                        ? const AdsShimmer()
                        : SmartRefresher(
                            scrollDirection: Axis.horizontal,
                            enablePullUp: true,
                            enablePullDown: false,
                            controller: userAdsRefresh,
                            onLoading: () {
                              context.read<AdsBloc>().add(AdsEvent.fetchUserAds(
                                  context: context,
                                  categoryId: widget.product?.categoryId,
                                  controller: userAdsRefresh));
                            },
                            child: ListView.builder(
                                padding: REdgeInsets.all(16),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.userAds.length,
                                itemBuilder: (context, index) {
                                  return AdsItem(
                                    colors: colors,
                                    ads: state.userAds[index],
                                    onSelect: () {
                                      context
                                          .read<AdsBloc>()
                                          .add(AdsEvent.boost(
                                            context: context,
                                            productId: widget.product?.id,
                                            adsId: state.userAds[index].id,
                                          ));

                                    },
                                  );
                                }),
                          ),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }

  _purchasePlan(CustomColorSet colors) {
    return BlocBuilder<AdsBloc, AdsState>(
      builder: (context, state) {
        return state.adsBanners.isEmpty
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(thickness: 1.r, height: 8.r),
                  12.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.purchasePlan),
                      style: CustomStyle.interSemi(
                          color: colors.textBlack, size: 20),
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.advertiseYourAd),
                      style: CustomStyle.interNormal(
                          color: colors.textHint, size: 14),
                    ),
                  ),
                  SizedBox(
                    height: 224.r,
                    child: SmartRefresher(
                      scrollDirection: Axis.horizontal,
                      enablePullUp: true,
                      enablePullDown: false,
                      controller: adsRefresh,
                      onLoading: () {
                        context.read<AdsBloc>().add(AdsEvent.fetchAds(
                              context: context,
                              categoryId: widget.product?.categoryId,
                              controller: adsRefresh,
                            ));
                      },
                      child: state.isLoading
                          ? const Loading()
                          : ListView.builder(
                              padding: REdgeInsets.all(16),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.adsBanners.length,
                              itemBuilder: (context, index) {
                                return AdsPurchaseItem(
                                  colors: colors,
                                  ads: state.adsBanners[index],
                                  onSelect: () {
                                    AppRoute.goAdsPaymentModal(
                                      context: context,
                                      colors: colors,
                                      selectAdsId: state.adsBanners[index].id,
                                    );
                                  },
                                );
                              }),
                    ),
                  ),
                ],
              );
      },
    );
  }

  _noItem(CustomColorSet colors) {
    return BlocBuilder<AdsBloc, AdsState>(
      buildWhen: (p, n) {
        return p.userAds != n.userAds || p.adsBanners != n.adsBanners;
      },
      builder: (context, state) {
        return state.userAds.isEmpty &&
                state.adsBanners.isEmpty &&
                !state.isLoading
            ? NoItem(colors: colors, title: TrKeys.noAds)
            : const SizedBox.shrink();
      },
    );
  }

  _product(CustomColorSet colors) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CustomNetworkImage(
            url: widget.product?.img,
            height: 64,
            width: 64,
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              widget.product?.translation?.title ?? '',
              style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBar(CustomColorSet colors) {
    return AppBar(
      toolbarHeight: 46.r,
      backgroundColor: colors.backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0.3,
      leading: PopButton(color: colors.textBlack),
      title: Text(
        AppHelpers.getTranslation(TrKeys.selectAds),
        style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
      ),
    );
  }
}
