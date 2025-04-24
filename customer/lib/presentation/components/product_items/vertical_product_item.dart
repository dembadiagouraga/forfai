import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/button/like_button.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';
import '../media/custom_network_image.dart';

class VerticalProductItem extends StatelessWidget {
  final ProductData product;
  final VoidCallback? addAndRemove;

  const VerticalProductItem(
      {super.key, required this.product, this.addAndRemove});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return Padding(
        padding: EdgeInsets.only(bottom: 24.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
          // Add splash and highlight colors for tap effect
          splashColor: Colors.blue.withAlpha(76), // 0.3 opacity
          highlightColor: Colors.blue.withAlpha(51), // 0.2 opacity
          onTap: () {
            ProductRoute.goProductPage(context: context, product: product);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.radius.r),
                    border: Border.all(color: CustomStyle.icon),
                    color: CustomStyle.shimmerBase),
                child: Stack(
                  children: [
                    CustomNetworkImage(
                      url: product.img,
                      height: 148,
                      width: 168,
                      radius: AppConstants.radius,
                    ),
                    SizedBox(
                      width: 168.r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              16.horizontalSpace,
                              if (product.discount != null)
                                SvgPicture.asset("assets/svg/discount.svg"),
                              const Spacer(),
                              LikeButton(
                                  colors: colors,
                                  isActive: LocalStorage.getLikedProductsList()
                                      .contains(product.id),
                                  onTap: () {
                                    LocalStorage.setLikedProductsList(
                                        product.id ?? 0);
                                    context
                                        .read<ProductBloc>()
                                        .add(const ProductEvent.updateState());
                                  }),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 216.r,
                height: 148.r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.translation?.title ?? "",
                      style: CustomStyle.interNormal(
                          color: colors.textBlack, size: 16),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        SvgPicture.asset("assets/svg/start.svg"),
                        4.horizontalSpace,
                        Text(
                          product.ratingAvg?.toStringAsPrecision(2) ?? "0.0",
                          style: CustomStyle.interSemi(
                              color: colors.textBlack, size: 12),
                        )
                      ],
                    ),
                    const Spacer(),
                    AppHelpers.numberFormat(product.price).length < 9
                        ? Row(
                            children: [
                              Text(
                                AppHelpers.numberFormat(product.price ?? 0),
                                style: CustomStyle.interBold(
                                    color: colors.textBlack, size: 20),
                              ),
                              if (product.discount != null)
                                Padding(
                                  padding: EdgeInsets.only(left: 10.r),
                                  child: Text(
                                    AppHelpers.numberFormat(
                                        product.price),
                                    style: CustomStyle.interBold(
                                        color: CustomStyle.red,
                                        size: 14,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.numberFormat(product.price ?? 0),
                                style: CustomStyle.interBold(
                                    color: colors.textBlack, size: 20),
                              ),
                              if (product.discount != null)
                                Padding(
                                  padding: EdgeInsets.only(right: 10.r),
                                  child: Text(
                                    AppHelpers.numberFormat(product.price ?? 0),
                                    style: CustomStyle.interBold(
                                        color: CustomStyle.red,
                                        size: 14,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                            ],
                          ),
                    12.verticalSpace,
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
