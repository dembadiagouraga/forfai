import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ClassicDropDown extends StatelessWidget {
  final String? value;
  final String? hint;
  final String? label;
  final List<String> list;
  final CustomColorSet colors;
  final ValueChanged<String> onChanged;
  final double radius;
  final bool filled;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;

  const ClassicDropDown({
    super.key,
    this.value,
    required this.list,
    required this.onChanged,
    this.hint,
    this.label,
    this.radius = AppConstants.radius,
    this.contentPadding,
    this.validator,
    required this.colors,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: REdgeInsets.only(right: 6, bottom: 4),
            child: Text(
              "${AppHelpers.getTranslation(label ?? '')} ${validator != null ? '*' : ''}",
              style: CustomStyle.interNormal(size: 14, color: colors.textBlack),
            ),
          ),
        DropdownButtonFormField2(
          hint: Text(
            AppHelpers.getTranslation(hint ?? ''),
            style: CustomStyle.interNormal(size: 14, color: colors.textBlack),
          ),
          value: value,
          validator: validator,
          items: list.map((e) {
            return DropdownMenuItem(value: e, child: Text(AppHelpers.getTranslation(e)));
          }).toList(),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: colors.textBlack,
            ),
          ),
          onChanged: (s) => onChanged.call(s.toString()),
          dropdownStyleData: DropdownStyleData(
            elevation: 4,
            maxHeight: 224.r,
            scrollbarTheme: ScrollbarThemeData(
              trackColor: WidgetStatePropertyAll(colors.white),
              thumbColor: WidgetStatePropertyAll(colors.white),
              trackBorderColor: WidgetStatePropertyAll(colors.white),
            ),
            decoration: BoxDecoration(
              color: colors.backgroundColor,
              borderRadius: BorderRadius.circular(AppConstants.radius.r),
            ),
          ),
          // menuItemStyleData: MenuItemStyleData(
          //   padding: EdgeInsets.zero
          // ),
          style: CustomStyle.interNormal(size: 14, color: colors.textBlack),
          decoration: InputDecoration(
            contentPadding: contentPadding ??
                REdgeInsets.only(right: 12, top: 16, bottom: 16),
            hintText: hint,
            hintStyle: CustomStyle.interNormal(
              size: 14,
              color: CustomStyle.textHint,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: filled ? colors.newBoxColor : colors.transparent,
            filled: filled,
            enabledBorder: _border(filled ? colors.newBoxColor : colors.border),
            errorBorder: _border(filled ? colors.newBoxColor : colors.border),
            border: _border(filled ? colors.newBoxColor : colors.border),
            focusedErrorBorder:
                _border(filled ? colors.newBoxColor : colors.border),
            disabledBorder:
                _border(filled ? colors.newBoxColor : colors.border),
            focusedBorder: _border(filled ? colors.newBoxColor : colors.border),
          ),
        ),
      ],
    );
  }

  _border(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide.merge(
          BorderSide(color: color),
          BorderSide(color: color),
        ),
        borderRadius: BorderRadius.circular(radius.r));
  }
}
