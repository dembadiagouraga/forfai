import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class ProductInfo extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData product;
  final double width;

  const ProductInfo({
    super.key,
    required this.product,
    required this.colors,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    int priceLength = AppHelpers.numberFormat(product.price).length;
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          4.verticalSpace,
          SizedBox(
            width: width,
            child: Text(
              product.translation?.title ?? "",
              style: CustomStyle.interNormal(color: colors.textBlack, size: 14),
              maxLines: 2,
            ),
          ),
          4.verticalSpace,
          priceLength < 9
              ? Row(
                  children: [
                    Text(
                      AppHelpers.numberFormat(product.price),
                      style: CustomStyle.interBold(
                          color: colors.textBlack, size: 16),
                    ),
                    if (product.discount != null)
                      Padding(
                        padding: EdgeInsets.only(left: 10.r),
                        child: Text(
                          AppHelpers.numberFormat(product.price),
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
                    AutoSizeText(
                      AppHelpers.numberFormat(product.price),
                      style: CustomStyle.interBold(
                        color: colors.textBlack,
                        size: priceLength > 20 ? 13 : 14,
                      ),
                      maxLines: 1,
                    ),
                    if (product.discount != null)
                      Padding(
                        padding: EdgeInsets.only(right: 10.r),
                        child: Text(
                          AppHelpers.numberFormat(product.price),
                          style: CustomStyle.interBold(
                              color: CustomStyle.red,
                              size: 12,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                  ],
                ),
          4.verticalSpace,
          Text(
            TimeService.dateFormatAgo(product.createdAt),
            style: CustomStyle.interNormal(color: colors.textHint, size: 14),
          ),
          6.verticalSpace,
          if (product.countryActive)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Remix.map_pin_2_line,
                  color: colors.textBlack,
                  size: 16.r,
                ),
                4.horizontalSpace,
                Expanded(
                  child: AutoSizeText(
                    product.area?.translation?.title ??
                        product.city?.translation?.title ??
                        '',
                    style: CustomStyle.interNormal(
                        color: colors.textBlack, size: 13),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          12.verticalSpace,
        ],
      ),
    );
  }
}
