import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class WalletScreen extends StatelessWidget {
  final CustomColorSet colors;

  const WalletScreen({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: () {
        SettingRoute.goWalletHistory(context: context);
      },
      child: Container(
        height: 148.r,
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
            color: colors.newBoxColor,
            borderRadius: BorderRadius.circular(AppConstants.radius.r)),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (p, n) {
            return p.isLoading != n.isLoading;
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: REdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(color: colors.textBlack),
                          shape: BoxShape.circle),
                      child: Icon(
                        Remix.wallet_3_line,
                        color: colors.textBlack,
                        size: 18.r,
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      AppHelpers.getTranslation(TrKeys.myWallet),
                      style: CustomStyle.interNormal(
                          color: colors.textBlack, size: 16),
                    ),
                    const Spacer(),
                    Text(
                      AppHelpers.getAppName(),
                      style: CustomStyle.interSemi(
                          color: colors.textBlack, size: 16),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  AppHelpers.getTranslation(TrKeys.balance),
                  style:
                      CustomStyle.interNormal(color: colors.textHint, size: 14),
                ),
                AutoSizeText(
                  AppHelpers.numberFormat(
                    LocalStorage.getUser().wallet?.price),
                  style: CustomStyle.interSemi(
                      color: colors.textBlack, size: 32),
                  maxLines: 1,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
