import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/blur_wrap.dart';
import 'package:quick/presentation/components/button/like_button.dart';
import 'package:quick/presentation/components/product_items/product_info.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import 'product_galleries.dart';

class ProductItem extends StatefulWidget {
  final ProductData product;
  final double height;
  final double width;
  final bool vip;
  final VoidCallback? onLike;

  const ProductItem({
    super.key,
    required this.product,
    this.height = 132,
    this.width = 176,
    this.onLike,
    this.vip = false,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isTapped = true;
          });
        },
        onTapUp: (_) async {
          // Add a small delay to show the blue border before navigation
          await Future.delayed(const Duration(milliseconds: 150));
          if (mounted) {
            setState(() {
              _isTapped = false;
            });
            await ProductRoute.goProductPage(context: context, product: widget.product);
            if (context.mounted) {
              context.read<ProductBloc>().add(const ProductEvent.updateState());
            }
          }
        },
        onTapCancel: () {
          setState(() {
            _isTapped = false;
          });
        },
        child: Stack(
          children: [
            Container(
              width: widget.width,
              decoration: BoxDecoration(
                color: colors.backgroundColor,
                borderRadius: BorderRadius.circular(AppConstants.radius.r),
                border: Border.all(
                  color: _isTapped ? CustomStyle.primary : colors.border,
                  width: _isTapped ? 1.5 : 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppConstants.radius.r),
                        ),
                        color: CustomStyle.shimmerBase),
                    child: Stack(
                      children: [
                        ProductGalleries(
                          galleries: widget.product.galleries ?? [],
                          height: widget.height,
                          width: widget.width,
                          img: widget.product.img,
                        ),
                        SizedBox(
                          height: widget.height.r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                children: [
                                  5.horizontalSpace,
                                  if (widget.vip)
                                    BlurWrap(
                                      radius: BorderRadius.circular(100.r),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.r, horizontal: 10.r),
                                        decoration: BoxDecoration(
                                          color: CustomStyle.primary
                                              .withValues(alpha: 0.9),
                                          boxShadow: [
                                            BoxShadow(
                                                color: CustomStyle.primary
                                                    .withValues(alpha: 0.35),
                                                blurRadius: 30.r,
                                                offset: const Offset(0, 10))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Remix.vip_crown_line,
                                              color: CustomStyle.white,
                                              size: 14.r,
                                            ),
                                            4.horizontalSpace,
                                            Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.vip),
                                              style: CustomStyle.interSemi(
                                                  color: CustomStyle.white,
                                                  size: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (widget.product.condition == 'new' && !widget.vip)
                                    BlurWrap(
                                      radius: BorderRadius.circular(100.r),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.r, horizontal: 10.r),
                                        decoration: BoxDecoration(
                                          color: colors.backgroundColor
                                              .withValues(alpha: 0.5),
                                          boxShadow: [
                                            BoxShadow(
                                                color: colors.backgroundColor
                                                    .withValues(alpha: 0.35),
                                                blurRadius: 30.r,
                                                offset: const Offset(0, 10))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Remix.vip_crown_line,
                                              color: colors.textBlack,
                                              size: 14.r,
                                            ),
                                            4.horizontalSpace,
                                            Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.newKey),
                                              style: CustomStyle.interSemi(
                                                  color: colors.textBlack,
                                                  size: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  Spacer(),
                                  LikeButton(
                                      colors: colors,
                                      isActive:
                                          LocalStorage.getLikedProductsList()
                                              .contains(widget.product.id),
                                      onTap: () {
                                        LocalStorage.setLikedProductsList(
                                            widget.product.id ?? 0);
                                        context.read<ProductBloc>().add(
                                            const ProductEvent.updateState());
                                        widget.onLike?.call();
                                      })
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ProductInfo(
                      width: widget.width,
                      product: widget.product,
                      colors: colors,
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
