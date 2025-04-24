import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscure;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validation;
  final TextInputType? inputType;
  final String? initialText;
  final bool readOnly;
  final bool isError;
  final bool autoFocus;
  final int? maxLines;
  final int? minLines;
  final int maxLength;
  final double radius;
  final TextStyle? labelStyle;
  final bool filled;
  final bool isCounter;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.obscure,
    this.validation,
    this.onChanged,
    this.controller,
    this.inputType,
    this.initialText,
    this.contentPadding,
    this.readOnly = false,
    this.isError = false,
    this.hint = "",
    this.maxLines,
    this.maxLength = 220,
    this.radius = AppConstants.radius,
    this.autoFocus = false,
    this.filled = false,
    this.textInputAction,
    this.labelStyle,
    this.inputFormatters,
    this.minLines,
    this.isCounter = false,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, c) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: REdgeInsets.only(right: 6, bottom: 4),
              child: Text(
                "${AppHelpers.getTranslation(label ?? '')} ${validation != null ? '*' : ''}",
                style: labelStyle ??
                    CustomStyle.interNormal(size: 14, color: colors.textBlack),
              ),
            ),
          TextFormField(
            autofocus: autoFocus,
            onTap: onTap,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            minLines: minLines,
            onChanged: onChanged,
            autocorrect: true,
            maxLines: maxLines,
            textInputAction: textInputAction,
            obscureText: !(obscure ?? true),
            obscuringCharacter: '*',
            controller: controller,
            validator: validation,
            style: CustomStyle.interNormal(
              size: 15,
              color: colors.textBlack,
            ),
            cursorWidth: 1,
            cursorColor: colors.textBlack,
            keyboardType: inputType,
            initialValue: initialText,
            readOnly: readOnly,
            decoration: InputDecoration(
              counterText: isCounter ? null : "",
              counterStyle: CustomStyle.interNormal(
                size: 10,
                color: CustomStyle.textHint,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
              hintText: AppHelpers.getTranslation(hint ?? ''),
              hintStyle: CustomStyle.interNormal(
                size: 15,
                color: CustomStyle.textHint,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              fillColor: filled ? colors.newBoxColor : colors.transparent,
              filled: filled,
              enabledBorder:
                  _border(filled ? colors.newBoxColor : colors.border),
              errorBorder: _border(filled ? colors.newBoxColor : colors.border),
              border: _border(filled ? colors.newBoxColor : colors.border),
              focusedErrorBorder:
                  _border(filled ? colors.newBoxColor : colors.border),
              disabledBorder:
                  _border(filled ? colors.newBoxColor : colors.border),
              focusedBorder:
                  _border(filled ? colors.newBoxColor : colors.border),
            ),
          ),
        ],
      );
    });
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
