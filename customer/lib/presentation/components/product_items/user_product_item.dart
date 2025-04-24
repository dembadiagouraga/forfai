import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/user_products/user_product_bloc.dart';
import 'package:quick/domain/model/model/area_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/pages/products/product_detail/widgets/product_tags.dart';
import 'package:quick/presentation/pages/products/user_products/widgets/product_edit_modal.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';
import '../location_item.dart';
import 'product_galleries.dart';

class UserProductItem extends StatelessWidget {
  final ProductData product;
  final VoidCallback? refresh;

  const UserProductItem({super.key, required this.product, this.refresh});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return Padding(
        padding: EdgeInsets.only(bottom: 24.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
          onTap: () {
            if (product.status == 'published' && (product.active ?? false)) {
              ProductRoute.goProductPage(context: context, product: product);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radius.r),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppConstants.radius.r),
                      ),
                      border: Border.all(color: CustomStyle.icon),
                      color: CustomStyle.shimmerBase),
                  child: Stack(
                    children: [
                      ProductGalleries(
                        img: product.img,
                        height: 220,
                        width: MediaQuery.sizeOf(context).width - 24,
                        galleries: product.galleries ?? [],
                      ),
                      if (product.status == 'published')
                        Padding(
                          padding: REdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              16.horizontalSpace,
                              Container(
                                height: 32.r,
                                padding: REdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: colors.socialButtonColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Icon(
                                      Remix.heart_3_line,
                                      size: 18.r,
                                      color: colors.textBlack,
                                    ),
                                    4.horizontalSpace,
                                    Text(
                                      "${product.likeCount ?? 0}",
                                      style: CustomStyle.interSemi(
                                          color: colors.textBlack, size: 12),
                                    )
                                  ],
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                height: 32.r,
                                padding: REdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: colors.socialButtonColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Icon(
                                      Remix.eye_line,
                                      size: 18.r,
                                      color: colors.textBlack,
                                    ),
                                    4.horizontalSpace,
                                    Text(
                                      "${product.viewsCount ?? 0}",
                                      style: CustomStyle.interSemi(
                                          color: colors.textBlack, size: 12),
                                    )
                                  ],
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                height: 32.r,
                                padding: REdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: colors.socialButtonColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Icon(
                                      Remix.phone_line,
                                      size: 18.r,
                                      color: colors.textBlack,
                                    ),
                                    4.horizontalSpace,
                                    Text(
                                      "${product.callsCount ?? 0}",
                                      style: CustomStyle.interSemi(
                                          color: colors.textBlack, size: 12),
                                    )
                                  ],
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                height: 32.r,
                                padding: REdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: colors.socialButtonColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Icon(
                                      Remix.chat_1_line,
                                      size: 18.r,
                                      color: colors.textBlack,
                                    ),
                                    4.horizontalSpace,
                                    Text(
                                      "${product.messageCount ?? 0}",
                                      style: CustomStyle.interSemi(
                                          color: colors.textBlack, size: 12),
                                    )
                                  ],
                                ),
                              ),
                              if (product.discount != null)
                                SvgPicture.asset("assets/svg/discount.svg"),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                Padding(
                  padding: REdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.translation?.title ?? "",
                              style: CustomStyle.interNormal(
                                  color: colors.textBlack, size: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (product.status == 'published')
                            IconButton(
                                splashColor: Colors.transparent,
                                splashRadius: 24.r,
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  AppHelpers.showCustomModalBottomSheet(
                                    context: context,
                                    modal: BlocProvider.value(
                                      value: context.read<UserProductBloc>(),
                                      child: ProductEditModal(
                                          colors: colors, product: product),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Remix.more_2_fill,
                                  size: 24.r,
                                  color: colors.textBlack,
                                ))
                        ],
                      ),
                      8.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppHelpers.numberFormat(product.price),
                            style: CustomStyle.interBold(
                                color: colors.textBlack, size: 20),
                          ),
                          if (product.discount != null)
                            Padding(
                              padding: EdgeInsets.only(right: 10.r),
                              child: Text(
                                AppHelpers.numberFormat(product.price),
                                style: CustomStyle.interBold(
                                    color: CustomStyle.red,
                                    size: 14,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                        ],
                      ),
                      12.verticalSpace,
                      Text(
                        TimeService.dateFormatDMY(product.createdAt),
                        style: CustomStyle.interNormal(
                            color: colors.textBlack, size: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      4.verticalSpace,
                      ProductTags(
                        colors: colors,
                        product: product,
                        isDetail: false,
                      ),
                      LocationItem(colors: colors, product: product),
                      12.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              title: TrKeys.edit,
                              height: 52,
                              onTap: () {
                                ProductRoute.goEditProductPage(
                                  context: context,
                                  product: product,
                                );
                              },
                              borderColor: colors.textBlack,
                              titleColor: colors.textBlack,
                              bgColor: colors.transparent,
                            ),
                          ),
                          if (AppHelpers.getAds()&& product.status == 'published' && (product.active ?? false) )
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: CustomButton(
                                  title: TrKeys.advertise,
                                  height: 52,
                                  onTap: () async {
                                    final area = AreaModel(
                                      id: product.area?.id,
                                      countryId: product.country?.id,
                                      regionId: product.country?.regionId,
                                      cityId: product.city?.id,
                                    );
                                    final check =
                                        await AppRoute.goSelectAdsPage(
                                            context: context,
                                            product:
                                                product.copyWith(area: area));
                                    if (check.runtimeType == bool &&
                                        check &&
                                        context.mounted) {
                                      refresh?.call();
                                    }
                                  },
                                  borderColor: colors.textBlack,
                                  titleColor: colors.textWhite,
                                  bgColor: colors.textBlack,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
