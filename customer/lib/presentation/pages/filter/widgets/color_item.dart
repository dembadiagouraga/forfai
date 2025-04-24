import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:remixicon/remixicon.dart';

class ColorItem extends StatelessWidget {
  final String? value;
  final bool active;
  final CustomColorSet colors;

  const ColorItem({
    super.key,
    required this.value,
    this.active = false,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
            margin: REdgeInsets.only(right: 4),
            width: 16.r,
            height: 16.r,
            decoration: BoxDecoration(
              color: Color(int.parse('0xFF${value?.substring(1, 7)}')),
              borderRadius: BorderRadius.circular((AppConstants.radius / 2).r),
            ),
            child: active
                ? Container(
                    width: 14.r,
                    height: 14.r,
                    alignment: Alignment.center,
                    child: Icon(
                      Remix.check_double_line,
                      color: value?.substring(1, 7) == "ffffff"
                          ? CustomStyle.black
                          : CustomStyle.white,
                    ),
                  )
                : SizedBox(width: 16.r, height: 16.r),
          );

  }
}
