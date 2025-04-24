import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/style.dart';

import 'button/animation_button_effect.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback? onTap;
  final Color titleColor;
  final bool isVip;

  const TitleWidget(
      {super.key,
      required this.title,
      this.subTitle,
      this.onTap,
      required this.titleColor,
      this.isVip = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.r),
                child: Text(
                  title,
                  style: CustomStyle.interSemi(
                    color: titleColor,
                    size: title.length > 20 ? 18 : 20,
                  ),
                  maxLines: 1,
                ),
              ),
              if (isVip)
                Container(
                  margin: EdgeInsets.only(left: 8.r),
                  padding:
                      EdgeInsets.symmetric(vertical: 5.r, horizontal: 10.r),
                  decoration: BoxDecoration(
                      color: CustomStyle.primary,
                      boxShadow: [
                        BoxShadow(
                            color: CustomStyle.primary.withValues(alpha: 0.35),
                            blurRadius: 30.r,
                            offset: const Offset(0, 10))
                      ],
                      borderRadius: BorderRadius.circular(100.r)),
                  child: Row(
                    children: [
                      Icon(
                        Remix.vip_crown_line,
                        color: CustomStyle.white,
                        size: 14.r,
                      ),
                      4.horizontalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.vip.toUpperCase()),
                        style: CustomStyle.interSemi(
                            color: CustomStyle.white, size: 10),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (subTitle != null)
          ButtonEffectAnimation(
            onTap: () {
              onTap?.call();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.r, horizontal: 16.r),
              child: Text(
                subTitle ?? "",
                style: CustomStyle.interNormal(
                    color: CustomStyle.primary, size: 14),
              ),
            ),
          ),
      ],
    );
  }
}
