import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/detail/product_detail_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';

import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class BottomWidget extends StatelessWidget {
  final CustomColorSet colors;

  const BottomWidget({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 24),
            decoration: BoxDecoration(
              color: colors.backgroundColor,
              boxShadow: CustomStyle.blackShadow,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppConstants.radius.r)),
            ),
            child: LocalStorage.getUser().id == state.product?.user?.id
                ? _userBottom(context, state.product)
                : Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: TrKeys.toCall,
                          isLoading: state.isLoadingPhone,
                          bgColor: colors.transparent,
                          titleColor: colors.textBlack,
                          borderColor: colors.textBlack,
                          onTap: () async {
                            if (state.product?.user?.id != null) {
                              context.read<ProductDetailBloc>().add(
                                  ProductDetailEvent.showPhone(
                                      context: context));
                            }
                          },
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: CustomButton(
                          title: TrKeys.message,
                          bgColor: colors.textBlack,
                          titleColor: colors.textWhite,
                          onTap: () {
                            if (LocalStorage.getToken().isEmpty) {
                              AuthRoute.goLogin(context);
                              return;
                            }
                            if (state.product?.user?.id != null) {
                              AppRoute.goChat(
                                context: context,
                                product: state.product,
                                sender: state.product?.user,
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
          ),
        ],
      );
    });
  }

  _userBottom(BuildContext context, ProductData? product) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            title: TrKeys.edit,
            bgColor: colors.transparent,
            titleColor: colors.textBlack,
            borderColor: colors.textBlack,
            onTap: () async {
              ProductRoute.goEditProductPage(
                  context: context, product: product ?? ProductData());
            },
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: CustomButton(
            title: TrKeys.myProducts,
            bgColor: colors.textBlack,
            titleColor: colors.textWhite,
            onTap: () {
              ProductRoute.goUserProductsPage(context: context);
            },
          ),
        )
      ],
    );
  }
}
