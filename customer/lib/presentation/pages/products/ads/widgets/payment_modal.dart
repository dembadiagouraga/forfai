import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/ads/ads_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/bottom_sheets/modal_wrap.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class PaymentModal extends StatelessWidget {
  final CustomColorSet colors;
  final ScrollController controller;

  const PaymentModal({
    super.key,
    required this.colors,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      colors: colors,
      color: colors.backgroundColor,
      child: Padding(
        padding:
            EdgeInsets.only(top: 20.r, left: 16.r, right: 16.r, bottom: 24.r),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.paymentMethod),
                style: CustomStyle.interBold(color: colors.textBlack),
              ),
              8.verticalSpace,
              BlocBuilder<AdsBloc, AdsState>(
                buildWhen: (l, n) {
                  return l.isLoading != n.isLoading ||
                      l.selectPayment != n.selectPayment;
                },
                builder: (context, state) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: REdgeInsets.only(top: 8, bottom: 8),
                      itemCount: state.payments.length,
                      itemBuilder: (context, index) {
                        return _paymentItem(
                          context: context,
                          payment: state.payments[index],
                          isSelect: state.selectPayment?.id ==
                              state.payments[index].id,
                        );
                      });
                },
              ),
              CustomButton(
                title: TrKeys.back,
                bgColor: colors.transparent,
                titleColor: colors.textBlack,
                borderColor: colors.textBlack,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              8.verticalSpace,
              BlocBuilder<AdsBloc, AdsState>(
                buildWhen: (l, n) {
                  return l.isPurchaseLoading != n.isPurchaseLoading;
                },
                builder: (context, state) {
                  return CustomButton(
                    title: TrKeys.pay,
                    bgColor: colors.textBlack,
                    titleColor: colors.textWhite,
                    isLoading: state.isPurchaseLoading,
                    changeColor: true,
                    onTap: () {
                      context.read<AdsBloc>().add(AdsEvent.purchaseAds(
                            context: context,
                            onSuccess: () {
                              Navigator.pop(context);
                            },
                            onFailure: () {
                              Navigator.pop(context);
                            },
                          ));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _paymentItem({
    required BuildContext context,
    required PaymentData payment,
    required bool isSelect,
  }) {
    return Padding(
      padding: REdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          context.read<AdsBloc>().add(AdsEvent.changePayment(payment: payment));
        },
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: colors.socialButtonColor,
            borderRadius: BorderRadius.circular(AppConstants.radius.r),
          ),
          child: Row(
            children: [
              Icon(
                isSelect
                    ? Remix.checkbox_circle_fill
                    : Remix.checkbox_blank_circle_line,
                color: isSelect ? colors.primary : colors.textBlack,
              ),
              10.horizontalSpace,
              Text(
                AppHelpers.getTranslation(payment.tag ?? ""),
                style: CustomStyle.interNormal(
                  size: 14,
                  color: colors.textBlack,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
