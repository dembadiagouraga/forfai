import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';

class StoriesShimmer extends StatelessWidget {
  const StoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94.r,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: REdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: REdgeInsets.only(right: 8.r),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: CustomStyle.primary, width: 1.8),
                          ),
                          child: Container(
                            height: 56.r,
                            width: 56.r,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomStyle.shimmerBase),
                            alignment: Alignment.center,
                            child: Text(AppHelpers.getAppName()),
                          ),
                        ),
                        4.verticalSpace,
                      ],
                    ),
                  );
                }),
          ),
          const Divider(color: CustomStyle.dividerColor),
        ],
      ),
    );
  }
}
