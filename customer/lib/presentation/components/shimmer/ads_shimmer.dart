import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/presentation/style/style.dart';

class AdsShimmer extends StatelessWidget {

  const AdsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        padding: REdgeInsets.all(16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.sizeOf(context).width / 1.4,
            margin: REdgeInsets.only(right: 16),
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CustomStyle.shimmerBase,
              borderRadius: BorderRadius.circular(AppConstants.radius),
            ),
          );
        });
  }
}
