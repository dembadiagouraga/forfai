import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/form_field/custom_textform_field.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class SearchField extends StatelessWidget {
  final CustomColorSet colors;
  const SearchField({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.r,
      child: CustomTextFormField(
        onTap: () => AppRoute.goSearchPage(context: context),
        readOnly: true,
        filled: true,
        prefixIcon: Icon(
          Remix.search_2_line,
          color: colors.textBlack,
          size: 21.r,
        ),
        hint: AppHelpers.getTranslation(TrKeys.search),
      ),
    );
  }
}
