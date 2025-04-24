import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/button/like_button.dart';
import 'package:quick/presentation/components/product_items/product_info.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';
import 'package:provider/provider.dart';

import '../media/custom_network_image.dart';

class NewProductItem extends StatelessWidget {
  final ProductData product;

  const NewProductItem({
    super.key,
    required this.product,
  });

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 320.r,
              height: 240.r,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius.r),
                  border: Border.all(color: CustomStyle.icon),
                  color: CustomStyle.shimmerBase),
              child: Stack(
                children: [
                  CustomNetworkImage(
                    url: product.img,
                    width: 470.r,
                    height: 240.r,
                    radius: AppConstants.radius,
                  ),
                  SizedBox(
                    height: 430.r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.r),
                          child: Container(
                            decoration: BoxDecoration(
                                color: colors.backgroundColor.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(8.r)),
                            padding: REdgeInsets.all(8),
                            child: ProductInfo(
                              product: product,
                              colors: colors,
                              width: 286,
                            ),
                          ),
                        ),
                        12.verticalSpace
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
