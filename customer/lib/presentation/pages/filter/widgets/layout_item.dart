import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/pages/filter/widgets/layout_box.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class LayoutItem extends StatelessWidget {
  final CustomColorSet colors;
  final LayoutType type;
  final LayoutType selectType;

  const LayoutItem({
    super.key,
    required this.colors,
    required this.type,
    required this.selectType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
          border: Border.all(color: colors.white),
          color: CustomStyle.transparent),
      padding: REdgeInsets.all(6),
      child: type == LayoutType.twoH
          ? Row(
              children: [
                LayoutBox(
                  active: selectType == LayoutType.twoH,
                  width: 14,
                ),
                4.horizontalSpace,
                LayoutBox(
                  active: selectType == LayoutType.twoH,
                  width: 14,
                ),
              ],
            )
          : type == LayoutType.three
              ? Column(
                  children: [
                    Row(
                      children: [
                        LayoutBox(
                          active: selectType == LayoutType.three,
                          height: 14,
                          width: 8,
                          radius: 2,
                        ),
                        4.horizontalSpace,
                        LayoutBox(
                          active: selectType == LayoutType.three,
                          height: 14,
                          width: 8,
                          radius: 2,
                        ),
                        4.horizontalSpace,
                        LayoutBox(
                          active: selectType == LayoutType.three,
                          height: 14,
                          width: 8,
                          radius: 2,
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      children: [
                        LayoutBox(
                          active: selectType == LayoutType.three,
                          height: 14,
                          width: 8,
                          radius: 2,
                        ),
                        4.horizontalSpace,
                        LayoutBox(
                          active: selectType == LayoutType.three,
                          height: 14,
                          width: 8,
                          radius: 2,
                        ),
                        4.horizontalSpace,
                        LayoutBox(
                          active: selectType == LayoutType.three,
                          height: 14,
                          width: 8,
                          radius: 2,
                        ),
                      ],
                    ),
                  ],
                )
              : type == LayoutType.twoV
                  ? Column(
                      children: [
                        LayoutBox(
                          active: selectType == LayoutType.twoV,
                          height: 14,
                          width: 32,
                        ),
                        4.verticalSpace,
                        LayoutBox(
                          active: selectType == LayoutType.twoV,
                          height: 14,
                          width: 32,
                        ),
                      ],
                    )
                  : type == LayoutType.one
                      ? LayoutBox(
                          active: selectType == LayoutType.one,
                          height: 32,
                          width: 32,
                        )
                      : Icon(
                          Remix.collage_fill,
                          size: 32.r,
                          color: CustomStyle.unselectLayout,
                        ),
    );
  }
}
