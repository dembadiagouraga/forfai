import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class AdsProductList extends StatelessWidget {
  final CustomColorSet colors;

  const AdsProductList({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state.adProducts.isNotEmpty
            ? Column(
                children: [
                  24.verticalSpace,
                  TitleWidget(
                    isVip: true,
                    title: AppHelpers.getTranslation(TrKeys.theAdvertisement),
                    titleColor: colors.textBlack,
                  ),
                  12.verticalSpace,
                  SizedBox(
                    height: (286 + 24).r,
                    // color: colors.socialButtonColor,
                    width: double.infinity,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding:
                            REdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.adProducts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: REdgeInsets.only(right: 12),
                            child: ProductItem(
                              vip: true,
                              width: MediaQuery.sizeOf(context).width / 2.2,
                              product: state.adProducts[index].product ?? ProductData(),
                            ),
                          );
                        }),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
