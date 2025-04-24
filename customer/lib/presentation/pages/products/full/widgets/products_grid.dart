import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/category_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/product_items/product_item.dart';
import 'package:quick/presentation/components/title.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class ProductsGrid extends StatelessWidget {
  final CategoryData category;
  final CustomColorSet colors;

  const ProductsGrid({super.key, required this.category, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (category.products?.isNotEmpty ?? false)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: category.translation?.title ??
                    AppHelpers.getTranslation(TrKeys.categories),
                titleColor: colors.textBlack,
              ),
              12.verticalSpace,
              GridView.builder(
                padding: EdgeInsets.only(right: 16.r, left: 16.r),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8.r,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.r,
                  mainAxisExtent: 274.r,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: category.products?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.r),
                    child: ProductItem(
                      width: double.infinity,
                      product: category.products?[index] ?? ProductData(),
                    ),
                  );
                },
              ),
            ],
          ),
        ListView.builder(
            itemCount: category.children?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, parentIndex) {
              final childCategory = category.children?[parentIndex];
              if (childCategory?.products?.isNotEmpty ?? false) {
                return Column(
                  children: [
                    12.verticalSpace,
                    TitleWidget(
                      title: childCategory?.translation?.title ??
                          AppHelpers.getTranslation(TrKeys.categories),
                      titleColor: colors.textBlack,
                      subTitle: AppHelpers.getTranslation(TrKeys.seeAll),
                      onTap: () => ProductRoute.goProductList(
                          context: context,
                          categoryId: childCategory?.id,
                          title: childCategory?.translation?.title),
                    ),
                    12.verticalSpace,
                    GridView.builder(
                      padding: EdgeInsets.only(right: 16.r, left: 16.r),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8.r,
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.r,
                        mainAxisExtent: 274.r,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: childCategory?.products?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.r),
                          child: ProductItem(
                            width: double.infinity,
                            product: childCategory?.products?[index] ??
                                ProductData(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
      ],
    );
  }
}
