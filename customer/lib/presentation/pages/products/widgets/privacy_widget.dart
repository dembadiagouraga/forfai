import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/select/select_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/components/custom_checkbox.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class PrivacyWidget extends StatelessWidget {
  final CustomColorSet colors;

  const PrivacyWidget({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.all(4),
          child: BlocBuilder<SelectBloc, SelectState>(
            builder: (context, state) {
              return ButtonEffectAnimation(
                onTap: () {
                  context.read<SelectBloc>().add(SelectEvent.changeIndex(
                      selectIndex: state.selectIndex == 0 ? 1 : 0));
                },
                child: CustomCheckbox(
                  colors: colors,
                  active: state.selectIndex == 1,
                ),
              );
            },
          ),
        ),
        6.horizontalSpace,
        Expanded(
          child: ButtonEffectAnimation(
            onTap: () async {
              await SettingRoute.goPolicy(context: context);
              if (context.mounted) {
                context
                    .read<SelectBloc>()
                    .add(SelectEvent.changeIndex(selectIndex: 1));
              }
            },
            child: Text(
              AppHelpers.getTranslation(TrKeys.privacyTitle),
              style: CustomStyle.interRegular(color: colors.textHint, size: 13),
            ),
          ),
        ),
      ],
    );
  }
}
