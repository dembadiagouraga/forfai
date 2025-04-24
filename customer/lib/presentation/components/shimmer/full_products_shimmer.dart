import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/title.dart';
import 'package:quick/presentation/style/style.dart';

class FullProductsShimmer extends StatelessWidget {
  const FullProductsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
      REdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: AppHelpers.getTranslation(TrKeys.categories),
                titleColor: CustomStyle.shimmerBase,
                subTitle: AppHelpers.getTranslation(TrKeys.seeAll),
              ),
              12.verticalSpace,
              SizedBox(
                height: 140.r,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.r),
                        child: SizedBox(
                          width: 108.r,
                          child: Column(
                            children: [
                              Container(
                                padding: REdgeInsets.all(4),
                                height: 100.r,
                                decoration: BoxDecoration(
                                  color: CustomStyle.shimmerBase,
                                  borderRadius: BorderRadius.circular(AppConstants.radius.r),
                                ),
                              ),
                              8.verticalSpace,
                              Container(
                                height: 16.r,
                                padding: REdgeInsets.symmetric(horizontal: 8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: CustomStyle.shimmerBase,
                                  borderRadius: BorderRadius.circular((AppConstants.radius/1.9).r),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
          TitleWidget(
            title: AppHelpers.getTranslation(TrKeys.products),
            titleColor: CustomStyle.shimmerBase,
            subTitle: AppHelpers.getTranslation(TrKeys.seeAll),
          ),
          GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.r),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8.r, crossAxisCount: 2, mainAxisExtent: 280.r),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.r),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.radius.r),
                        border: Border.all(color: CustomStyle.icon),
                        color: CustomStyle.shimmerBase),
                  ),
                );
              })
        ],
      ),
    );
  }
}
