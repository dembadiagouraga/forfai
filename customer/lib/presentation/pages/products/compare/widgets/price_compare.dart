import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class PriceCompare extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData product;

  const PriceCompare({super.key, required this.colors, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppHelpers.getTranslation(TrKeys.from)} ${AppHelpers.numberFormat(product.price)}",
            style: CustomStyle.interNormal(color: colors.textBlack, size: 15),
          ),
          4.verticalSpace,
          Text(
            "${(product.attributes?.isEmpty ?? true) ? AppHelpers.getTranslation(TrKeys.no) : product.attributes?.length ?? 0} ${AppHelpers.getTranslation(TrKeys.options).toLowerCase()}",
            style: CustomStyle.interNormal(color: colors.primary, size: 14),
          ),
        ],
      ),
    );
  }
}
