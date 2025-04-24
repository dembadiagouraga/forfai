import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';

class CongratsPage extends StatelessWidget {
  final bool isOrder;
  final VoidCallback? onTap;

  const CongratsPage({super.key, this.isOrder = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.checkout),
                style: CustomStyle.interBold(color: colors.textBlack, size: 22),
              ),
              42.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Image.asset("assets/images/order_success.png"),
              ),
              6.verticalSpace,
              if (isOrder)
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.congrats),
                        style: CustomStyle.interBold(
                            color: colors.textBlack, size: 20),
                      ),
                      6.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.thankYouPurchase),
                        style: CustomStyle.interNormal(
                            color: colors.textBlack, size: 14),
                      ),
                      Text(
                        AppHelpers.getTranslation(TrKeys.yourOrderShipping),
                        style: CustomStyle.interNormal(
                            color: colors.textBlack, size: 14),
                      ),
                    ],
                  ),
                ),
              if (!isOrder)
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.congrats),
                        style: CustomStyle.interBold(
                            color: colors.textBlack, size: 20),
                      ),
                      6.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.paymentSuccessful),
                        style: CustomStyle.interNormal(
                            color: colors.textBlack, size: 14),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingButton: (colors) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: SizedBox(
          height: 60.r,
          child: CustomButton(
            title: isOrder ? TrKeys.returnHome : TrKeys.ok,
            bgColor: colors.primary,
            titleColor: colors.white,
            onTap: () {
              onTap ?? Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
