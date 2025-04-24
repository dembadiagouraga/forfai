import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/detail/product_detail_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/presentation/components/product_items/product_item.dart';
import 'package:quick/presentation/components/title.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class RelatedAndViewedProducts extends StatelessWidget {
  final CustomColorSet colors;
  final List<ProductData> list;
  final String title;

  const RelatedAndViewedProducts(
      {super.key,
      required this.colors,
      required this.list,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              TitleWidget(
                title: title,
                titleColor: colors.textBlack,
              ),
              16.verticalSpace,
              SizedBox(
                height: 268.r,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.r),
                        child: ProductItem(
                          width: MediaQuery.sizeOf(context).width / 2.2,
                          product: list[index],
                          onLike: () {
                            context
                                .read<ProductDetailBloc>()
                                .add(const ProductDetailEvent.updateState());
                          },
                        ),
                      );
                    }),
              )
            ],
          )
        : const SizedBox.shrink();
  }
}
