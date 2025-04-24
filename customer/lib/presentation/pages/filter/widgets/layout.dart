import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/filter/filter_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'layout_item.dart';

class LayoutScreen extends StatelessWidget {
  final CustomColorSet colors;
  final LayoutType selectType;

  const LayoutScreen(
      {super.key, required this.colors, required this.selectType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(bottom: 8),
      padding: REdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.newBoxColor,
        borderRadius: BorderRadius.circular(AppConstants.radius.r),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: CustomStyle.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(
            AppHelpers.getTranslation(TrKeys.layouts),
            style: CustomStyle.interNormal(color: colors.textBlack, size: 15),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: AppConstants.filterLayouts
                  .map(
                    (e) => ButtonEffectAnimation(
                      onTap: () {
                        context
                            .read<FilterBloc>()
                            .add(FilterEvent.selectType(selectType: e));
                      },
                      child: LayoutItem(
                        colors: colors,
                        type: e,
                        selectType: selectType,
                      ),
                    ),
                  )
                  .toList(),
            ),
            8.verticalSpace,
          ],
        ),
      ),
    );
  }
}
