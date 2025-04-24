import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class MainInfo extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData product;
  final AttributesData? attribute;

  const MainInfo({
    super.key,
    required this.colors,
    required this.product,
    required this.attribute,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _category(),
          // const Divider(),
          Text(
            attribute?.attribute?.translation?.title ?? "",
            style: CustomStyle.interRegular(color: colors.textHint, size: 13),
          ),
          8.verticalSpace,
          attribute?.value?.isNotEmpty ?? false
              ? Container(
                  margin: EdgeInsets.all(2.r),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                      color: colors.transparent,
                      border: Border.all(color: colors.textHint),
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Text(
                    attribute?.value ?? '',
                    style: CustomStyle.interNormal(
                      color: colors.textBlack,
                      size: 14,
                    ),
                  ),
                )
              : attribute?.attributeValue != null
                  ? Container(
                      margin: EdgeInsets.all(2.r),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                          color: colors.transparent,
                          border: Border.all(color: colors.textHint),
                          borderRadius: BorderRadius.circular(4.r)),
                      child: Text(
                        attribute?.attributeValue?.translation?.title ?? '',
                        style: CustomStyle.interNormal(
                          color: colors.textBlack,
                          size: 14,
                        ),
                      ),
                    )
                  : attribute?.attributeValue != null
                      ? Wrap(
                          children: attribute?.values?.map((value) {
                                return attribute?.values?.isNotEmpty ?? false
                                    ? Container(
                                        margin: EdgeInsets.all(2.r),
                                        height: 24.r,
                                        width: 36.r,
                                        decoration: BoxDecoration(
                                            color: colors.transparent,
                                            border: Border.all(
                                                color: colors.textHint),
                                            borderRadius:
                                                BorderRadius.circular(4.r)),
                                        child: Center(
                                            child: Text(
                                          value.translation?.title ?? '',
                                          style: CustomStyle.interNormal(
                                              color: colors.textBlack),
                                        )),
                                      )
                                    : const SizedBox.shrink();
                              }).toList() ??
                              [])
                      : Text(
                          AppHelpers.getTranslation("-- -- --"),
                          style: CustomStyle.interNormal(
                            color: colors.textBlack,
                            size: 14,
                          ),
                        ),
        ],
      ),
    );
  }
}
