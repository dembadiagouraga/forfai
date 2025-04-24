import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class LocationItem extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData? product;

  const LocationItem({
    super.key,
    required this.colors,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: colors.socialButtonColor,
          borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Remix.map_pin_2_line,
            color: colors.textBlack,
            size: 18.r,
          ),
          4.horizontalSpace,
          Text(
            '${product?.city?.translation?.title ?? ""}${product?.area?.translation?.title != null ? ',' : ''}${product?.area?.translation?.title ?? ""}',
            style: CustomStyle.interNormal(color: colors.textBlack, size: 14),
          ),
        ],
      ),
    );
  }
}
