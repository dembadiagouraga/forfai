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
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

import 'product_info.dart';

class OneProductItem extends StatelessWidget {
  // Helper method to fix double storage path issue
  String? _fixImagePath(String? inputUrl) {
    if (inputUrl == null || inputUrl.isEmpty) {
      return "";
    }

    String fixedUrl = inputUrl;

    if (fixedUrl.startsWith('http')) {
      // Fix host issues - replace 127.0.0.1 with the correct IP
      if (fixedUrl.contains('127.0.0.1')) {
        fixedUrl = AppConstants.fixLocalIpUrl(fixedUrl);
      }

      // Fix double storage path issue
      if (fixedUrl.contains('/storage/storage/')) {
        fixedUrl = fixedUrl.replaceAll('/storage/storage/', '/storage/');
      }

      // Fix double slash issue
      if (fixedUrl.contains('//storage/')) {
        fixedUrl = fixedUrl.replaceAll('//storage/', '/storage/');
      }

      return fixedUrl;
    }

    // Fix double storage path issue
    String pathToUse = fixedUrl;

    // Remove leading slash if present
    if (pathToUse.startsWith('/')) {
      pathToUse = pathToUse.substring(1);
    }

    // Fix double storage path issue
    if (pathToUse.startsWith('storage/')) {
      pathToUse = pathToUse.replaceFirst('storage/', '');
    }

    return "${AppConstants.imageUrl}$pathToUse";
  }
  final ProductData product;
  final double height;

  const OneProductItem({super.key, required this.product, this.height = 186});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return Padding(
        padding: EdgeInsets.only(bottom: 12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
          // Add splash and highlight colors for tap effect
          splashColor: Colors.blue.withAlpha(76), // 0.3 opacity
          highlightColor: Colors.blue.withAlpha(51), // 0.2 opacity
          onTap: () async {
            await ProductRoute.goProductPage(context: context, product: product);
            if (context.mounted) {
              context.read<ProductBloc>().add(const ProductEvent.updateState());
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radius.r),
              color: colors.transparent,
              border: Border.all(color: colors.icon),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height.h,
                  child: Stack(
                    children: [
                      CustomNetworkImage(
                        url: _fixImagePath(product.img),
                        height: height,
                        width: double.infinity,
                        topRadius: AppConstants.radius,
                      ),
                      SizedBox(
                        height: height.r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                16.horizontalSpace,
                                if (product.discount != null)
                                  AppHelpers.getType() == 2
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.r, horizontal: 10.r),
                                          decoration: BoxDecoration(
                                              color: colors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(100.r)),
                                          child: Text(
                                            AppHelpers.getTranslation(TrKeys.hot)
                                                .toUpperCase(),
                                            style: CustomStyle.interSemi(
                                                color: colors.white, size: 12),
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          "assets/svg/discount.svg"),
                                const Spacer(),
                                LikeButton(
                                    colors: colors,
                                    isActive:
                                        LocalStorage.getLikedProductsList()
                                            .contains(product.id),
                                    onTap: () {
                                      LocalStorage.setLikedProductsList(
                                          product.id ?? 0);
                                      context.read<ProductBloc>().add(
                                          const ProductEvent.updateState());
                                    }),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                12.verticalSpace,
                ProductInfo(
                  product: product,
                  colors: colors,
                  width: MediaQuery.sizeOf(context).width - 50.w,
                ),
                8.verticalSpace,
              ],
            ),
          ),
        ),
      );
    });
  }
}
