import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:remixicon/remixicon.dart';

class LogoutButton extends StatelessWidget {
  final CustomColorSet colors;

  const LogoutButton({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: () {
        if (LocalStorage.getToken().isEmpty) {
          AuthRoute.goLogin(context);
          return;
        }
        SettingRoute.goMyAccount(context: context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radius.r)),
        child: LocalStorage.getToken().isNotEmpty
            ? BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (p, n) {
                  return p.isLoading != n.isLoading;
                },
                builder: (context, state) {
                  return Row(
                    children: [
                      CustomNetworkImage(
                        url: LocalStorage.getUser().img,
                        name: LocalStorage.getUser().firstname ??
                            LocalStorage.getUser().lastname,
                        height: 50,
                        width: 50,
                        radius: AppConstants.radius,
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocalStorage.getUser().firstname ?? "",
                              style: CustomStyle.interSemi(
                                  color: colors.textBlack, size: 18),
                              maxLines: 1,
                            ),
                            Text(
                              "${AppHelpers.getTranslation(TrKeys.id.toUpperCase())}-${LocalStorage.getUser().id ?? " "}",
                              style: CustomStyle.interRegular(
                                  color: colors.textHint, size: 14),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SettingRoute.goMyAccount(context: context);
                        },
                        icon: Icon(
                          Remix.edit_line,
                          color: colors.textBlack,
                        ),
                      )
                    ],
                  );
                },
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.r),
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.signIn),
                    style: CustomStyle.interSemi(
                        color: colors.textBlack, size: 16),
                  ),
                ),
              ),
      ),
    );
  }
}
