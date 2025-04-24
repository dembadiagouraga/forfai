import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/theme/theme.dart';

import 'bottom_sheets/modal_wrap.dart';
import 'button/custom_button.dart';
import '../style/style.dart';

class DeleteModal extends StatelessWidget {
  final VoidCallback onDelete;
  final CustomColorSet colors;

  const DeleteModal({
    super.key,
    required this.onDelete,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      colors: colors,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            Text(
              '${AppHelpers.getTranslation(TrKeys.areYouSureToDelete)}?',
              textAlign: TextAlign.center,
              style: CustomStyle.interNormal(color: colors.textBlack,size: 18),
            ),
            36.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: TrKeys.cancel,
                    onTap: () => Navigator.pop(context),
                    bgColor: CustomStyle.transparent,
                    borderColor: colors.textBlack,
                    titleColor: colors.textBlack,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: CustomButton(
                    title: TrKeys.yes,
                    onTap: () {
                      onDelete.call();
                      Navigator.pop(context);
                    },
                    bgColor: CustomStyle.red,
                    borderColor: CustomStyle.red,
                    titleColor:  colors.white,
                  ),
                ),
              ],
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
