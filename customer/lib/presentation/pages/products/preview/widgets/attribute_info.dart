import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/request/selected_request.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class AttributeInfo extends StatelessWidget {
  final CustomColorSet colors;
  final List<SelectedAttribute>? attributes;

  const AttributeInfo({
    super.key,
    required this.colors,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    return (attributes?.isEmpty ?? true)
        ? SizedBox.shrink()
        : Column(
            children: [
              8.verticalSpace,
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                physics: NeverScrollableScrollPhysics(),
                itemCount: attributes?.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 40.r,
                  mainAxisSpacing: 8.r,
                  crossAxisSpacing: 8.r,
                ),
                itemBuilder: (context, index) {
                  return _item(attributes?[index]);
                },
              ),
              8.verticalSpace,
              Divider(color: colors.divider, thickness: 1.r),
            ],
          );
  }

  _item(SelectedAttribute? attributes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          attributes?.title ?? '',
          style: CustomStyle.interRegular(
            color: colors.textHint,
            size: 13,
          ),
          maxLines: 1,
        ),
        2.verticalSpace,
        Text(
          attributes?.value ??
              attributes?.attributeValue?.translation?.title ??
              '',
          style: CustomStyle.interNormal(
            color: colors.textBlack,
            size: 15,
          ),
        ),
      ],
    );
  }
}
