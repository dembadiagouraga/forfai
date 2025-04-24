import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/product_items/product_item.dart';
import 'package:quick/presentation/components/shimmer/products_shimmer.dart';
import 'package:quick/presentation/components/title.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class AllProductList extends StatelessWidget {
  final CustomColorSet colors;

  const AllProductList({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state.isLoading
                ? const ProductsShimmer()
                : Column(
                    children: [
                      12.verticalSpace,
                      TitleWidget(
                        title:
                            AppHelpers.getTranslation(TrKeys.allAdvertisement),
                        titleColor: colors.textBlack,
                      ),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: REdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8.r,
                            crossAxisCount: 2,
                            mainAxisSpacing: 12.r,
                            mainAxisExtent: 268.r,
                          ),
                          itemCount: state.allProductList.length,
                          // (state.allProductList.length - addAdsIndex * 6) > 6 ? 6
                          //     : (state.allProductList.length - addAdsIndex * 6),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.r),
                              child: ProductItem(
                                width: double.infinity,
                                product: state.allProductList[index],
                              ),
                            );
                          }),
                    ],
                  );
          },
        ),
      ],
    );
  }
}
