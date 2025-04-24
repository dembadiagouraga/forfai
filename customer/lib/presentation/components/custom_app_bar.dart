import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:remixicon/remixicon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CustomColorSet colors;
  final BuildContext context;
  final String? title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.colors,
    required this.context,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.1,
      backgroundColor: colors.backgroundColor,
      leading: IconButton(
        splashRadius: 20.r,
        icon: Icon(
          LocalStorage.getLangLtr()
              ? Remix.arrow_left_s_line
              : Remix.arrow_right_s_line,
          size: 24.r,
          color: colors.textBlack,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: actions,
      title: Row(
        children: [
          Expanded(
            child: Text(
              AppHelpers.getTranslation(title ?? ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomStyle.interNormal(color: colors.textBlack),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(54.r);
}
