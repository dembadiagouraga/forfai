import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/user_products/user_product_bloc.dart';
import 'package:quick/application/select/select_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'quick_help_modal.dart';

class ProductEditModal extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData? product;

  const ProductEditModal(
      {super.key, required this.colors, required this.product});

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      colors: colors,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ModalDrag(colors: colors),
            _editItem(
              colors: colors,
              titleColor: (product?.active ?? false)
                  ? colors.textBlack
                  : CustomStyle.primary,
              title: (product?.active ?? false)
                  ? TrKeys.deactivate
                  : TrKeys.activate,
              onTap: () {
                if (!(product?.active ?? false)) {
                  context
                      .read<UserProductBloc>()
                      .add(UserProductEvent.changeActivate(
                        context: context,
                        product: product,
                      ));
                } else {
                  Navigator.pop(context);
                  AppHelpers.showCustomModalBottomSheet(
                      context: context,
                      modal: MultiBlocProvider(
                        providers: [
                          BlocProvider(create: (context) => SelectBloc()),
                          BlocProvider.value(
                              value: context.read<UserProductBloc>()),
                        ],
                        child: QuickHelpModal(product: product),
                      ));
                }
              },
            ),
            if (LocalStorage.getAiActive())
              _editItem(
                colors: colors,
                comingSoon: true,
                title: TrKeys.chatWithAi,
                onTap: () {},
              ),
            _editItem(
              colors: colors,
              comingSoon: true,
              title: TrKeys.viewStatistics,
              onTap: () {},
            ),
            _editItem(
              colors: colors,
              title: TrKeys.deleteAd,
              titleColor: CustomStyle.red,
              onTap: () {
                AppHelpers.showCustomModalBottomSheet(
                  context: context,
                  modal: BlocProvider.value(
                    value: context.read<UserProductBloc>(),
                    child: DeleteModal(
                        onDelete: () {
                          context
                              .read<UserProductBloc>()
                              .add(UserProductEvent.deleteProduct(
                                context: context,
                                product: product,
                              ));
                        },
                        colors: colors),
                  ),
                );
              },
            ),
            24.verticalSpace,
            CustomButton(
              title: TrKeys.cancel,
              bgColor: colors.textBlack,
              titleColor: colors.textWhite,
              onTap: () => Navigator.pop(context),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}

_editItem({
  required CustomColorSet colors,
  required String title,
  Color? titleColor,
  bool? comingSoon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppHelpers.getTranslation(title),
              style: CustomStyle.interNormal(
                color: titleColor ?? colors.textBlack,
              ),
            ),
            if (comingSoon ?? false)
              Text(
                " (${AppHelpers.getTranslation(TrKeys.comingSoon)})",
                style: CustomStyle.interNormal(color: colors.primary, size: 14),
              ),
          ],
        ),
        8.verticalSpace,
        Divider(color: colors.divider),
      ],
    ),
  );
}
