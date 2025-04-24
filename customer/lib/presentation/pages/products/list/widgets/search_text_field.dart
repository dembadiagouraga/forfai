import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:remixicon/remixicon.dart';

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? textEditingController;
  final ValueSetter<String>? onChanged;
  final bool isVisible;
  final CustomColorSet colors;

  const SearchTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.textEditingController,
    this.onChanged,
    this.isVisible = true,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      style: CustomStyle.interNormal(
        size: 13,
        color: colors.textBlack,
      ),
      onChanged: onChanged,
      controller: textEditingController,
      cursorColor: colors.textBlack,
      cursorWidth: 1,
      decoration: InputDecoration(
        hintStyle: CustomStyle.interNormal(
          size: 13,
          color: colors.textHint,
        ),
        hintText: hintText ?? AppHelpers.getTranslation(TrKeys.searchProducts),
        contentPadding: REdgeInsets.symmetric(horizontal: 12),
        prefixIcon: isVisible
            ? Icon(
               Remix.search_2_line,
                size: 20.r,
                color: colors.textBlack,
              )
            : const SizedBox.shrink(),
        suffixIcon: suffixIcon,
        fillColor: colors.newBoxColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.newBoxColor),
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colors.newBoxColor),
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.newBoxColor),
          borderRadius: BorderRadius.circular(AppConstants.radius.r),
        ),
      ),
    );
  }
}
