import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/user_products/user_product_bloc.dart';
import 'package:quick/application/select/select_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/bottom_sheets/modal_drag.dart';
import 'package:quick/presentation/components/bottom_sheets/modal_wrap.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

class QuickHelpModal extends StatelessWidget {
  final ProductData? product;

  const QuickHelpModal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return ModalWrap(
          colors: colors,
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ModalDrag(colors: colors),
                Text(
                  '${AppHelpers.getTranslation(TrKeys.didYourAdWork)}?',
                  style:
                      CustomStyle.interSemi(color: colors.textBlack, size: 18),
                ),
                12.verticalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.yourAnswerIsUsed),
                  style:
                      CustomStyle.interNormal(color: colors.textHint, size: 14),
                  textAlign: TextAlign.center,
                ),
                16.verticalSpace,
                BlocBuilder<SelectBloc, SelectState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        _yesNoButton(context, colors, state.selectIndex, 0),
                        12.horizontalSpace,
                        _yesNoButton(context, colors, state.selectIndex, 1),
                      ],
                    );
                  },
                ),
                24.verticalSpace,
                BlocBuilder<SelectBloc, SelectState>(
                  builder: (context, state) {
                    return CustomButton(
                        title: TrKeys.send,
                        bgColor: colors.textBlack,
                        titleColor: colors.textWhite,
                        onTap: () {
                          _changeActive(context, help: state.selectIndex == 0);
                        });
                  },
                ),
                12.verticalSpace,
                CustomButton(
                    title: TrKeys.skip,
                    bgColor: colors.transparent,
                    titleColor: colors.textBlack,
                    borderColor: colors.textBlack,
                    onTap: () {
                      _changeActive(context);
                    }),
                24.verticalSpace,
              ],
            ),
          ));
    });
  }

  _changeActive(BuildContext context, {bool? help}) {
    context.read<UserProductBloc>().add(UserProductEvent.changeActivate(
          context: context,
          product: product,
          help: help,
        ));
    Navigator.pop(context);
  }

  _yesNoButton(
    BuildContext context,
    CustomColorSet colors,
    int selectIndex,
    int index,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context
              .read<SelectBloc>()
              .add(SelectEvent.changeIndex(selectIndex: index));
        },
        child: Container(
          height: 90.r,
          // width: double.infinity,
          padding: REdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
                color: selectIndex == index ? colors.primary : colors.textHint),
            borderRadius: BorderRadius.circular(AppConstants.radius),
          ),
          alignment: Alignment.center,
          child: Text(
            AppHelpers.getTranslation(index == 0 ? TrKeys.yesQuickHelp : TrKeys.no),
            style: CustomStyle.interNormal(
                color:
                    selectIndex == index ? colors.primary : colors.textBlack),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
