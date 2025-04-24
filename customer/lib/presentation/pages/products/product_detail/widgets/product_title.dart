// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class ProductTitle extends StatelessWidget {
  final ProductData? product;
  final CustomColorSet colors;

  const ProductTitle({
    super.key,
    required this.product,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Remix.time_line,
                size: 21.r,
                color: colors.textBlack,
              ),
              6.horizontalSpace,
              Expanded(
                child: Text(
                  TimeService.dateFormatProduct(product?.createdAt),
                  style: CustomStyle.interNormal(
                      color: colors.textBlack, size: 14),
                  maxLines: 1,
                ),
              ),
              12.verticalSpace,
            ],
          ),
          6.verticalSpace,
          if (product?.discount != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8.r),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomStyle.red,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    padding: EdgeInsets.all(6.r),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/discount.svg",
                          color: colors.white,
                        ),
                        4.horizontalSpace,
                        Text(
                          "-${((1 - (product?.totalPrice ?? 1) / (product?.price ?? 1)) * 100).toStringAsPrecision(2)} %",
                          style: CustomStyle.interNormal(
                              color: colors.white, size: 14),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppHelpers.numberFormat( product?.price),
                    style: CustomStyle.interSemi(
                        color: CustomStyle.red,
                        size: 14,
                        decoration: TextDecoration.lineThrough),
                  )
                ],
              ),
            ),
          Text(
            product?.translation?.title ?? "",
            style: CustomStyle.interSemi(color: colors.textBlack, size: 20),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          8.verticalSpace,
          AutoSizeText(
            AppHelpers.numberFormat( product?.price),
            style: CustomStyle.interBold(color: colors.textBlack, size: 24),
            maxLines: 1,
            minFontSize: 16,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
