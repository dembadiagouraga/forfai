import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class TitleCompare extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData product;

  const TitleCompare({super.key, required this.colors, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ProductRoute.goProductPage(context: context, product: product);
      },
      child: Padding(
        padding:  REdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomNetworkImage(
              url: product.img,
              height: 80,
              width: 80,
              fit: BoxFit.fitHeight,
            ),
            8.verticalSpace,
            SizedBox(
              height: 64.r,
              child: Text(
                product.translation?.title ?? "",
                style: CustomStyle.interNormal(
                  color: colors.textBlack,
                  size: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}

