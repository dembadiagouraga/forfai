import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/auth/auth_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
// Removed unused import: import 'package:quick/infrastructure/firebase/firebase_service.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/app_assets.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:upgrader/upgrader.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late TextEditingController phone;

  @override
  void initState() {
    phone = TextEditingController();
    // FirebaseService.initDynamicLinks(context); is already commented out
    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(languageCode: LocalStorage.getLanguage()?.locale),
      showLater: AppConstants.showLater,
      showIgnore: AppConstants.showIgnore,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScaffold(
          bgColor: CustomStyle.transparent,
          body: (colors) => BlocListener<AuthBloc, AuthState>(
            listenWhen: (prev, next) {
              return prev.screenType.name != next.screenType.name;
            },
            listener: (context, state) {
              if (state.screenType == AuthType.confirm) {
                AuthRoute.goConfirmBottomSheet(
                  context: context,
                  colors: colors,
                  phone: phone.text,
                  isReset: state.isReset,
                  email: AppHelpers.checkPhone(phone.text) ? null : phone.text,
                );
                return;
              }
              if (state.screenType == AuthType.signUpFull) {
                AuthRoute.goSignUpFieldBottomSheet(context, colors, phone.text);
                return;
              }
              if (state.screenType == AuthType.updatePassword) {
                AuthRoute.goUpdatePasswordBottomSheet(context, colors, phone);
                return;
              }
            },
            child: Column(
              children: [
                MediaQuery.paddingOf(context).top.verticalSpace,
                12.verticalSpace,
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        AppHelpers.getAppName(),
                        style: CustomStyle.interNormal(color: colors.textBlack),
                      ),
                      const Spacer(),
                      SecondButton(
                        title: TrKeys.skip,
                        bgColor: CustomStyle.black,
                        titleColor: CustomStyle.white,
                        onTap: () {
                          if (AppConstants.isDemo &&
                              LocalStorage.getUiType() == null) {
                            SettingRoute.goSelectUIType(context: context);
                            return;
                          }
                          AppRoute.goMain(context);
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(gradient: colors.whiteGradient),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppHelpers.getTranslation(
                                  TrKeys.buySellOrFindJustAboutAnything)
                              .toUpperCase(),
                          style: CustomStyle.interBold(
                              color: colors.textBlack, size: 26),
                          textAlign: TextAlign.center,
                        ),
                        32.verticalSpace,
                        CustomButton(
                            title: TrKeys.login,
                            bgColor: colors.textBlack,
                            titleColor: colors.textWhite,
                            onTap: () {
                              AuthRoute.goLoginBottomSheet(
                                  context, colors, phone);
                            }),
                        10.verticalSpace,
                        CustomButton(
                            title: TrKeys.signUp,
                            bgColor: colors.transparent,
                            titleColor: colors.textBlack,
                            borderColor: colors.textBlack,
                            onTap: () {
                              AuthRoute.goSignUpBottomSheet(
                                  context, colors, phone);
                            }),
                        32.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
