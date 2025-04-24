import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/auth/auth_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  final CustomColorSet colors;
  final TextEditingController phone;

  const LoginScreen({super.key, required this.colors, required this.phone});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      colors: widget.colors,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Remix.arrow_left_s_line,
                              color: widget.colors.textBlack,
                              size: 26.r,
                            )),
                        const Spacer(),
                        Text(
                          AppHelpers.getTranslation(TrKeys.login),
                          style: CustomStyle.interSemi(
                              color: widget.colors.textBlack, size: 20),
                        ),
                        const Spacer(),
                        SizedBox(width: 42.r)
                      ],
                    ),
                    16.verticalSpace,
                    CustomTextFormField(
                      validation: AppValidators.emptyCheck,
                      controller: widget.phone,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      label: AppHelpers.getTranslation(TrKeys.phoneNumberOrEmail),
                    ),
                    16.verticalSpace,
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (l, n) {
                        return l.isShowPassword != n.isShowPassword;
                      },
                      builder: (context, state) {
                        return CustomTextFormField(
                          obscure: state.isShowPassword,
                          controller: password,
                          maxLines: 1,
                          validation: AppValidators.isValidPassword,
                          label: AppHelpers.getTranslation(TrKeys.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthEvent.showPassword());
                            },
                            icon: Icon(
                              !state.isShowPassword
                                  ? Remix.eye_close_line
                                  : Remix.eye_line,
                              color: widget.colors.textBlack,
                            ),
                          ),
                        );
                      },
                    ),
                    16.verticalSpace,
                    Row(children: [
                      const Spacer(),
                      ButtonEffectAnimation(
                        onTap: () {
                          context.read<AuthBloc>().add(
                              const AuthEvent.switchScreen(
                                  AuthType.forgetPassword));
                          Navigator.pop(context);
                          AuthRoute.goForgetPasswordBottomSheet(
                              context, widget.colors, widget.phone);
                        },
                        child: Text(
                          '${AppHelpers.getTranslation(TrKeys.forgetPassword)}?',
                          style: CustomStyle.interNormal(
                            color: widget.colors.textBlack,
                            size: 14,
                          ),
                        ),
                      ),
                    ]),
                    32.verticalSpace,
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (l, n) {
                        return l.isLoading != n.isLoading;
                      },
                      builder: (context, state) {
                        return CustomButton(
                            isLoading: state.isLoading,
                            title: TrKeys.login,
                            bgColor: widget.colors.textBlack,
                            titleColor: widget.colors.textWhite,
                            changeColor: true,
                            onTap: () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(AuthEvent.login(
                                    context: context,
                                    phone: widget.phone.text,
                                    password: password.text,
                                    onSuccess: () {
                                      if (AppConstants.isDemo &&
                                          LocalStorage.getUiType() == null) {
                                        SettingRoute.goSelectUIType(
                                            context: context);
                                        return;
                                      }
                                      AppRoute.goMain(context);
                                    }));
                              }
                            });
                      },
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                            child: Divider(color: widget.colors.textBlack)),
                        8.horizontalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.orAccessQuickly),
                          style: CustomStyle.interNormal(
                              color: widget.colors.textBlack, size: 12),
                        ),
                        8.horizontalSpace,
                        Expanded(
                            child: Divider(color: widget.colors.textBlack)),
                      ],
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: AppConstants.socialSignIn
                          .map((e) => SocialButton(
                                iconColor:
                                    widget.colors.textBlack.withValues(alpha: .5),
                                bgColor: widget.colors.socialButtonColor,
                                icon: e,
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthEvent.socialSignIn(
                                          context: context,
                                          type: e,
                                          onSuccess: () {
                                            if (AppConstants.isDemo &&
                                                LocalStorage.getUiType() ==
                                                    null) {
                                              SettingRoute.goSelectUIType(
                                                  context: context);
                                              return;
                                            }
                                            AppRoute.goMain(context);
                                          }));
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              32.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
