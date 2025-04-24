import 'package:flutter/material.dart';
import 'package:quick/domain/model/response/filter_response.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class AttributeItem extends StatelessWidget {
  final CustomColorSet colors;
  final String type;
  final Value extra;
  final bool active;

  const AttributeItem({
    super.key,
    required this.type,
    required this.extra,
    required this.colors,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return type == "color"
        ? AppHelpers.checkIfHex(extra.value)
            ? Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(4.r),
                        width: 36.r,
                        height: 36.r,
                        decoration: BoxDecoration(
                            color: Color(int.parse(
                                '0xFF${extra.value?.substring(1, 7)}')),
                            borderRadius:
                                BorderRadius.circular(AppConstants.radius.r)),
                        child: active
                            ? Container(
                                width: 36.r,
                                height: 36.r,
                                alignment: Alignment.center,
                                child: Icon(
                                  Remix.check_double_line,
                                  color:
                                      extra.value?.substring(1, 7) == "ffffff"
                                          ? CustomStyle.black
                                          : CustomStyle.white,
                                ),
                              )
                            : SizedBox(width: 36.r, height: 36.r),
                      ),
                      6.horizontalSpace,
                      Text(
                        AppHelpers.getNameColor(extra.value ?? ""),
                        style: CustomStyle.interNormal(
                          size: 14,
                          color: colors.textBlack,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: colors.icon)
                ],
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius.r),
                ),
                padding: REdgeInsets.all(12),
                child: Text(
                  extra.title ?? extra.value ?? "",
                  style: CustomStyle.interNormal(
                    size: 14,
                    color: colors.textBlack,
                  ),
                ),
              )
        : Column(
            children: [
              4.verticalSpace,
              Row(
                children: [
                  Icon(
                    active ? Remix.checkbox_fill : Remix.checkbox_blank_line,
                    color: active ? colors.primary : colors.textBlack,
                  ),
                  10.horizontalSpace,
                  Text(
                    extra.title ?? extra.value ?? "",
                    style: CustomStyle.interNormal(
                      size: 14,
                      color: colors.textBlack,
                    ),
                  )
                ],
              ),
              4.verticalSpace,
              Divider(color: colors.icon)
            ],
          );
  }
}
