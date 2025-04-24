import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_text_field/phone_text_field.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:quick/app_constants.dart';

class CustomPhoneField extends StatelessWidget {
  final ValueChanged<String>? onchange;
  final String? initialValue;
  final double radius;
  final bool filled;
  final bool isLabel;
  final TextEditingController controller;
  final CustomColorSet colors;
  final String? Function(String?)? validator;

  const CustomPhoneField({
    super.key,
    this.onchange,
    this.initialValue,
    this.radius = AppConstants.radius,
    required this.colors,
    this.filled = false,
    this.isLabel = false,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLabel)
          Padding(
            padding: REdgeInsets.only(right: 6, bottom: 4),
            child: Text(
              "${AppHelpers.getTranslation(TrKeys.phoneNumber)} ${validator != null ? '*' : ''}",
              style: CustomStyle.interNormal(size: 14, color: colors.textBlack),
            ),
          ),
        PhoneTextField(
          isRequired: validator != null,
          countryViewOptions: CountryViewOptions.countryCodeWithFlag,
          initialCountryCode: LocalStorage.getAddress()?.countryCode,
          initialValue: controller.text,
          textStyle: CustomStyle.interNormal(color: colors.textBlack,size: 15),
          invalidNumberMessage: AppHelpers.getTranslation(TrKeys.invalidPhone),
          dialogTitle: AppHelpers.getTranslation(TrKeys.selectCountry),
          dropdownIcon: Icon(
            Icons.arrow_drop_down,
            color: colors.textBlack,
          ),
          locale: Locale(LocalStorage.getLanguage()?.locale ?? 'en'),
          searchFieldInputDecoration: InputDecoration(
            hintText:
                AppHelpers.getTranslation(TrKeys.searchByNameOrCountryCode),
            suffixIcon: const Icon(Icons.search),
          ),
          decoration: InputDecoration(
            hintText: isLabel ? null : AppHelpers.getTranslation(TrKeys.phoneNumber),
            hintStyle:
                CustomStyle.interNormal(size: 14, color: colors.textHint),
            contentPadding: REdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
          onChanged: (s) {
            controller.text = s.completeNumber;
            onchange?.call(s.completeNumber);
          },
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
