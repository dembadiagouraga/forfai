import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/presentation/style/style.dart';

class UProductShimmer extends StatelessWidget {
  const UProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.r),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            height: 420.r,
            margin: EdgeInsets.only(bottom: 16.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.radius.r),
                border: Border.all(color: CustomStyle.icon),
                color: CustomStyle.shimmerBase),
          );
        });
  }
}
