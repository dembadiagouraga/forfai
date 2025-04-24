import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/auth/auth_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/bottom_sheets/modal_wrap.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/components/form_field/custom_textform_field.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class SignUpFieldScreen extends StatefulWidget {
  final CustomColorSet colors;
  final bool isPhone;
  final String phone;

  const SignUpFieldScreen(
      {super.key,
      required this.colors,
      required this.isPhone,
      required this.phone});

  @override
  State<SignUpFieldScreen> createState() => _SignUpFieldScreenState();
}

class _SignUpFieldScreenState extends State<SignUpFieldScreen> {
  late TextEditingController firstName;
  late TextEditingController userName;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController referral;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstName = TextEditingController();
    userName = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    confirmPassword = TextEditingController();
    password = TextEditingController();
    referral = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    userName.dispose();
    phone.dispose();
    email.dispose();
    confirmPassword.dispose();
    password.dispose();
    referral.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      colors: widget.colors,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Remix.arrow_left_line,
                          color: widget.colors.white,
                          size: 26.r,
                        )),
                    const Spacer(),
                    Text(
                      AppHelpers.getTranslation(TrKeys.signUp),
                      style: CustomStyle.interSemi(
                          color: widget.colors.white, size: 20),
                    ),
                    const Spacer(),
                    SizedBox(width: 42.r)
                  ],
                ),
                32.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: widget.colors.socialButtonColor,
                  ),
                  child: CustomTextFormField(
                    validation: AppValidators.emptyCheck,
                    controller: firstName,
                    hint: AppHelpers.getTranslation(TrKeys.fullName),
                  ),
                ),
                16.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: widget.colors.socialButtonColor,
                  ),
                  child: CustomTextFormField(
                    validation: AppValidators.emptyCheck,
                    controller: userName,
                    hint: AppHelpers.getTranslation(TrKeys.userName),
                  ),
                ),
                if (!widget.isPhone) 16.verticalSpace,
                if (!widget.isPhone)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: widget.colors.socialButtonColor,
                    ),
                    child: CustomTextFormField(
                      validation: AppValidators.emptyCheck,
                      controller: phone,
                      inputFormatters: [InputFormatter.digitsOnly],
                      hint: AppHelpers.getTranslation(TrKeys.phoneNumber),
                    ),
                  ),
                if (widget.isPhone) 16.verticalSpace,
                if (widget.isPhone)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: widget.colors.socialButtonColor,
                    ),
                    child: CustomTextFormField(
                      validation: AppValidators.isValidEmail,
                      controller: email,
                      hint: AppHelpers.getTranslation(TrKeys.email),
                    ),
                  ),
                16.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (l, n) {
                    return l.isShowPassword != n.isShowPassword;
                  },
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: widget.colors.socialButtonColor,
                      ),
                      child: CustomTextFormField(
                        obscure: state.isShowPassword,
                        maxLines: 1,
                        controller: password,
                        validation: AppValidators.isValidPassword,
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
                        hint: AppHelpers.getTranslation(TrKeys.password),
                      ),
                    );
                  },
                ),
                16.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (l, n) {
                    return l.isShowConfirmPassword != n.isShowConfirmPassword;
                  },
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: widget.colors.socialButtonColor,
                      ),
                      child: CustomTextFormField(
                        obscure: state.isShowConfirmPassword,
                        maxLines: 1,
                        controller: confirmPassword,
                        validation: (s) => AppValidators.isValidConfirmPassword(
                            password.text, s),
                        suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEvent.showConfirmPassword());
                          },
                          icon: Icon(
                            !state.isShowConfirmPassword
                                ? Remix.eye_close_line
                                : Remix.eye_line,
                            color: widget.colors.textBlack,
                          ),
                        ),
                        hint: AppHelpers.getTranslation(TrKeys.confirmPassword),
                      ),
                    );
                  },
                ),
                16.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: widget.colors.socialButtonColor,
                  ),
                  child: CustomTextFormField(
                    controller: referral,
                    hint: AppHelpers.getTranslation(TrKeys.referral),
                  ),
                ),
                16.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (l, n) {
                    return l.isLoading != n.isLoading;
                  },
                  builder: (context, state) {
                    return CustomButton(
                        title: TrKeys.signUp,
                        bgColor: widget.colors.textBlack,
                        titleColor: widget.colors.textWhite,
                        isLoading: state.isLoading,
                        changeColor: true,
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            if (LocalStorage.getToken().isNotEmpty) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.signUpWithData(
                                context: context,
                                firstname: firstName.text,
                                lastname: userName.text,
                                phone: phone.text,
                                password: password.text,
                                referral: referral.text,
                                onSuccess: () {
                                  AppRoute.goMain(context);
                                },
                              ));
                              return;
                            }
                            context.read<AuthBloc>().add(AuthEvent.signUp(
                              context: context,
                              firstname: firstName.text,
                              lastname: userName.text,
                              email: email.text,
                              phone: widget.phone,
                              password: password.text,
                              referral: referral.text,
                              onSuccess: () {
                                AppRoute.goMain(context);
                              },
                            ));
                          }
                        });
                  },
                ),
                KeyboardVisibilityBuilder(builder: (s, isKeyboard) {
                  return isKeyboard ? 200.verticalSpace : 24.verticalSpace;
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
