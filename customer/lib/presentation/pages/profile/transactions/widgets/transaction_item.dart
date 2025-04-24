import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class TransactionItem extends StatelessWidget {
  final CustomColorSet colors;
  final TransactionModel transaction;

  const TransactionItem(
      {super.key, required this.colors, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.r, left: 16.r, right: 16.r),
      width: double.infinity,
      padding: REdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: colors.transparent,
        border: Border.all(color: colors.textBlack.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              16.horizontalSpace,
              Text(
                TimeService.dateFormatMonth(transaction.createdAt),
                style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
              ),
              const Spacer(),
              Text(
                TimeService.dateFormatDMYHm(transaction.createdAt),
                style: CustomStyle.interNormal(
                    color: colors.textBlack.withValues(alpha: 0.5), size: 14),
              ),
              16.horizontalSpace,
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              16.horizontalSpace,
              Text(
                '${AppHelpers.getTranslation(TrKeys.payment)} ${AppHelpers.getTranslation(TrKeys.id).toUpperCase()}',
                style: CustomStyle.interNormal(
                  size: 14,
                  color: colors.textBlack.withValues(alpha: 0.5),
                ),
              ),
              8.horizontalSpace,
              Text(
                "#${transaction.id ?? " "}",
                style: CustomStyle.interSemi(
                  size: 14,
                  color: colors.textBlack,
                ),
              ),
              const Spacer(),
              Text(
                AppHelpers.getTranslation(TrKeys.amount),
                style: CustomStyle.interNormal(
                  size: 14,
                  color: colors.textBlack.withValues(alpha: 0.5),
                ),
              ),
              8.horizontalSpace,
              Text(
                AppHelpers.numberFormat( transaction.price),
                style: CustomStyle.interSemi(
                  size: 14,
                  color: colors.textBlack,
                ),
              ),
              16.horizontalSpace,

            ],
          ),
          12.verticalSpace,
          Divider(color: colors.textBlack.withValues(alpha: 0.1), thickness: 1.5),
          8.verticalSpace,
          Row(
            children: [
              16.horizontalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.status),
                style: CustomStyle.interNormal(
                  size: 14,
                  color: colors.textBlack.withValues(alpha: 0.5),
                ),
              ),
              8.horizontalSpace,
              Container(
                padding: REdgeInsets.symmetric(horizontal: 16,vertical: 8),
                decoration: BoxDecoration(
                  color: CustomStyle.greenColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radius.r)
                ),
                child: Text(
                  AppHelpers.getTranslation(transaction.status ?? ""),
                  style: CustomStyle.interSemi(
                    size: 14,
                    color: CustomStyle.greenColor,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                AppHelpers.getTranslation(transaction.paymentSystem?.tag ?? ""),
                style: CustomStyle.interSemi(
                  size: 14,
                  color: colors.textBlack,
                ),
              ),
              16.horizontalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
