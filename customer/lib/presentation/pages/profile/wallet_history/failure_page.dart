import 'package:flutter/material.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';

class FailurePage extends StatelessWidget {
  const FailurePage({super.key});

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
                child: Image.asset("assets/images/payment_rejected.png"),
              ),
              6.verticalSpace,
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.paymentRejected),
                      style: CustomStyle.interBold(
                          color: colors.textBlack, size: 20),
                    ),
                    6.verticalSpace,
                    Text(
                      AppHelpers.getTranslation(TrKeys.tryAgain),
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
            title: TrKeys.returnHome,
            bgColor: colors.primary,
            titleColor: colors.white,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
