import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/helper.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'color_item.dart';

class FilterItem extends StatelessWidget {
  final CustomColorSet colors;
  final VoidCallback onTap;
  final String? title;
  final List<String?>? subTitle;
  final bool color;

  const FilterItem({
    super.key,
    required this.colors,
    required this.title,
    required this.onTap,
    this.color = false,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.r,
        margin: EdgeInsets.only(bottom: 8.r),
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: colors.newBoxColor,
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? '',
                    style: CustomStyle.interNormal(
                      color: colors.textBlack,
                      size: 15,
                    ),
                  ),
                  if (subTitle != null)
                    Wrap(
                      children: [
                        ...?subTitle?.mapIndexed(
                          (i, e) {
                            if (AppHelpers.checkIfHex(e)) {
                              return ColorItem(colors: colors, value: e);
                            } else {
                              return Text(
                                '${AppHelpers.getNameColor(e)}${((subTitle?.length ?? 0) - 1 > i) ? ', ' : ''}',
                                style: CustomStyle.interNormal(
                                  size: 12,
                                  color: colors.textHint,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    )
                ],
              ),
            ),
            Badge(
              isLabelVisible: false,
              child: Icon(
                Remix.arrow_right_s_line,
                color: colors.textBlack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
