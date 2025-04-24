import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class ChatShimmer extends StatelessWidget {
  final CustomColorSet colors;

  const ChatShimmer({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.r),
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 16.r),
          decoration: BoxDecoration(
            color: colors.newBoxColor,
            borderRadius: BorderRadius.circular(AppConstants.radius.r),
          ),
          child: Row(
            children: [
              Container(
                height: 56.r,
                width: 56.r,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: CustomStyle.shimmerBase),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 20.r,
                      width: 180.r,
                      decoration: BoxDecoration(
                        color: CustomStyle.shimmerBase,
                        borderRadius: BorderRadius.circular((AppConstants.radius/1.9).r),
                      ),
                    ),
                    6.verticalSpace,
                    Container(
                      height: 16.r,
                      width: 100.r,
                      decoration: BoxDecoration(
                        color: CustomStyle.shimmerBase,
                        borderRadius: BorderRadius.circular((AppConstants.radius/2.1).r),
                      ),
                    ),
                  ],
                ),
              ),
              6.horizontalSpace,
              Container(
                height: 18.r,
                width: 70.r,
                decoration: BoxDecoration(
                  color: CustomStyle.shimmerBase,
                  borderRadius: BorderRadius.circular((AppConstants.radius/2).r),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
