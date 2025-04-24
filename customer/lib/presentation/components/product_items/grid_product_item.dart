import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

class GridProductItem extends StatelessWidget {
  // Helper method to fix double storage path issue
  String? _fixImagePath(String? inputUrl) {
    if (inputUrl == null || inputUrl.isEmpty) {
      return "";
    }

    String fixedUrl = inputUrl;

    if (fixedUrl.startsWith('http')) {
      // Fix host issues - replace 127.0.0.1 with the correct IP
      if (fixedUrl.contains('127.0.0.1')) {
        fixedUrl = fixedUrl.replaceAll('127.0.0.1', '192.168.0.107');
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

  const GridProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return InkWell(
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
            border: Border.all(color: CustomStyle.icon),
          ),
          child: Column(
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
                      url: _fixImagePath(product.img),
                      height: 96,
                      width: double.infinity,
                      topRadius: AppConstants.radius,
                    ),
                    if (product.discount != null)
                      Padding(
                        padding: EdgeInsets.all(12.r),
                        child: SvgPicture.asset("assets/svg/discount.svg"),
                      ),
                  ],
                ),
              ),
              8.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.translation?.title ?? "",
                      style: CustomStyle.interNormal(
                        color: colors.textBlack,
                        size: 15,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
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
                    12.verticalSpace,
                    if (product.discount != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.r),
                        child: Text(
                          AppHelpers.numberFormat(product.price),
                          style: CustomStyle.interBold(
                              color: CustomStyle.red,
                              size: 14,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    Text(
                      AppHelpers.numberFormat(product.price),
                      style: CustomStyle.interBold(
                          color: colors.textBlack, size: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
