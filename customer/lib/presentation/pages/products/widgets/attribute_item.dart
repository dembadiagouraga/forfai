import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/domain/model/request/selected_request.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/components/custom_checkbox.dart';
import 'package:quick/presentation/components/custom_radio.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class AttributeItem extends StatelessWidget {
  final AttributesData attribute;
  final CustomColorSet colors;
  final SelectedAttribute? selectedAttribute;
  final ValueChanged<SelectedAttribute>? onChanged;

  const AttributeItem({
    super.key,
    required this.attribute,
    required this.colors,
    required this.selectedAttribute,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          if (attribute.type == 'input')
            CustomTextFormField(
              label: attribute.translation?.title,
              // controller: desc,
              initialText: selectedAttribute?.value,
              textInputAction: TextInputAction.next,
              hint: attribute.translation?.placeholder,
              validation: (attribute.required ?? false)
                  ? AppValidators.emptyCheck
                  : null,
              onChanged: (v) {
                onChanged?.call(
                  SelectedAttribute(
                    attributeId: attribute.id,
                    value: v,
                    type: attribute.type,
                    title: attribute.translation?.title,
                  ),
                );
              },
            ),
          if (attribute.type == 'drop_down')
            ClassicDropDown(
              label: attribute.translation?.title,
              hint: attribute.translation?.placeholder,
              list: attribute.values
                      ?.map((e) => e.translation?.title ?? '')
                      .toSet()
                      .toList() ??
                  [],
              value: attribute.values
                  ?.firstWhere(
                      (e) =>
                          (e.translation?.title ?? '') ==
                          (selectedAttribute
                                  ?.attributeValue?.translation?.title ??
                              ''),
                      orElse: () => Attributes())
                  .translation
                  ?.title,
              onChanged: (v) {
                onChanged?.call(
                  SelectedAttribute(
                    attributeId: attribute.id,
                    valueId: attribute.values
                        ?.firstWhere((e) => e.translation?.title == v,
                            orElse: () => Attributes())
                        .id,
                    attributeValue: AttributeValue.fromJson(attribute.values
                            ?.firstWhere((e) => e.translation?.title == v,
                                orElse: () => Attributes())
                            .toJson() ??
                        {}),
                    type: attribute.type,
                    title: attribute.translation?.title,
                  ),
                );
              },
              validator: (attribute.required ?? false)
                  ? AppValidators.emptyCheck
                  : null,
              colors: colors,
            ),
          if (attribute.type == 'yes_or_no')
            ClassicDropDown(
              label: attribute.translation?.title,
              value: selectedAttribute?.attributeValue?.translation?.title,
              list: attribute.values
                      ?.map((e) => e.translation?.title ?? '')
                      .toList() ??
                  [],
              onChanged: (v) {
                onChanged?.call(
                  SelectedAttribute(
                    attributeId: attribute.id,
                    valueId: attribute.values
                        ?.firstWhere((e) => e.translation?.title == v,
                            orElse: () => Attributes())
                        .id,
                    type: attribute.type,
                    title: attribute.translation?.title,
                  ),
                );
              },
              colors: colors,
              validator: (attribute.required ?? false)
                  ? AppValidators.emptyCheck
                  : null,
            ),
          if (attribute.type == 'checkbox')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attribute.translation?.title ?? '',
                  style: CustomStyle.interNormal(
                      color: colors.textBlack, size: 14),
                ),
                4.verticalSpace,
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.border),
                    borderRadius: BorderRadius.circular(AppConstants.radius.r),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: attribute.values?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: REdgeInsets.symmetric(vertical: 6),
                          child: CustomCheckbox(
                            colors: colors,
                            onTap: () {
                              onChanged?.call(
                                SelectedAttribute(
                                  attributeId: attribute.id,
                                  values: [(attribute.values?[index].id ?? -1)],
                                  attributeValue: AttributeValue.fromJson(
                                      attribute.values?[index].toJson() ?? {}),
                                  title: attribute.translation?.title,
                                  type: attribute.type,
                                ),
                              );
                            },
                            active: selectedAttribute?.values
                                    ?.contains(attribute.values?[index].id) ??
                                false,
                            title: attribute.values?[index].translation?.title,
                          ),
                        );
                      }),
                ),
              ],
            ),
          if (attribute.type == 'radio')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attribute.translation?.title ?? '',
                  style: CustomStyle.interNormal(
                      color: colors.textBlack, size: 14),
                ),
                4.verticalSpace,
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.border),
                    borderRadius: BorderRadius.circular(AppConstants.radius.r),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: attribute.values?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: REdgeInsets.symmetric(vertical: 6),
                          child: CustomRadio(
                            colors: colors,
                            onTap: () {
                              onChanged?.call(
                                SelectedAttribute(
                                  attributeId: attribute.id,
                                  valueId: (attribute.values?[index].id ?? -1),
                                  attributeValue: AttributeValue.fromJson(
                                      attribute.values?[index].toJson() ?? {}),
                                  type: attribute.type,
                                  title: attribute.translation?.title,
                                ),
                              );
                            },
                            active: selectedAttribute?.valueId ==
                                attribute.values?[index].id,
                            title: attribute.values?[index].translation?.title,
                          ),
                        );
                      }),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
