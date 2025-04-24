import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/theme/theme.dart';

import '../../../../components/tags_item.dart';

class ProductTags extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData? product;
  final bool isDetail;

  const ProductTags({
    super.key,
    required this.colors,
    this.product,
    this.isDetail = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.r,
      child: ListView(
        padding:
            REdgeInsets.symmetric(vertical: 12, horizontal: isDetail ? 16 : 0),
        scrollDirection: Axis.horizontal,
        children: [
          if (product?.id != null && isDetail)
            TagsItem(
              colors: colors,
              title: "${AppHelpers.getTranslation(TrKeys.id)}: ${product?.id ?? ''}",
            ),
          if (product?.type != 'private')
            TagsItem(
              colors: colors,
              title: AppHelpers.getTranslation(product?.type ?? ''),
            ),
          if (product?.brand?.title != null)
            TagsItem(
              colors: colors,
              title: product?.brand?.title ?? '',
            ),
          if (product?.category?.translation?.title != null)
            TagsItem(
              colors: colors,
              title: product?.category?.translation?.title ?? '',
            ),
          if (product?.city?.translation?.title != null && isDetail)
            TagsItem(
              colors: colors,
              title: product?.city?.translation?.title ?? '',
            ),
          if (product?.area?.translation?.title != null && isDetail)
            TagsItem(
              colors: colors,
              title: product?.area?.translation?.title ?? '',
            ),
        ],
      ),
    );
  }
}
