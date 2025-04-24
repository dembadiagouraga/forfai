import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/auth/auth_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/infrastructure/firebase/firebase_service.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/bottom_sheets/modal_wrap.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/components/form_field/custom_textform_field.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'widgets/social_button.dart';

class SignUpScreen extends StatefulWidget {
  final CustomColorSet colors;
  final TextEditingController phone;

  const SignUpScreen({
    super.key,
    required this.colors,
    required this.phone,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                          Remix.arrow_left_s_line,
                          color: widget.colors.textBlack,
                          size: 26.r,
                        )),
                    const Spacer(),
                    Text(
                      AppHelpers.getTranslation(TrKeys.signUp),
                      style: CustomStyle.interSemi(
                          color: widget.colors.textBlack, size: 20),
                    ),
                    const Spacer(),
                    SizedBox(width: 42.r)
                  ],
                ),
                16.verticalSpace,
                if (AppConstants.signUpType == SignUpType.email)
                  CustomTextFormField(
                    validation: AppValidators.isValidEmail,
                    controller: widget.phone,
                    label: TrKeys.email,
                    inputType: TextInputType.text,
                  ),
                if (AppConstants.signUpType == SignUpType.phone)
                  CustomTextFormField(
                    validation: AppValidators.emptyCheck,
                    controller: widget.phone,
                    label: TrKeys.phoneNumber,
                    inputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                  ),
                if (AppConstants.signUpType == SignUpType.both)
                  CustomTextFormField(
                    validation: AppValidators.emptyCheck,
                    controller: widget.phone,
                    label: TrKeys.phoneNumberOrEmail,
                    inputType: TextInputType.text,
                  ),
                16.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (l, n) {
                    return l.isLoading != n.isLoading;
                  },
                  builder: (context, state) {
                    return CustomButton(
                        isLoading: state.isLoading,
                        title: TrKeys.signUp,
                        changeColor: true,
                        bgColor: widget.colors.textBlack,
                        titleColor: widget.colors.textWhite,
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            if (AppHelpers.checkPhone(
                                widget.phone.text.replaceAll(" ", ""))) {
                              context.read<AuthBloc>().add(AuthEvent.checkPhone(
                                  context: context,
                                  phone: widget.phone.text,
                                  onSuccess: () {
                                    FirebaseService.sendCode(
                                        phone: widget.phone.text,
                                        onSuccess: (id) {
                                          context.read<AuthBloc>().add(
                                              AuthEvent.setVerificationId(
                                                  id: id));
                                          Navigator.pop(context);
                                        },
                                        onError: (e) {
                                          AppHelpers.errorSnackBar(
                                              context: context, message: e);
                                        });
                                  }));
                            } else {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.signUpEmail(
                                context: context,
                                email: widget.phone.text,
                              ));
                            }
                          }
                        });
                  },
                ),
                16.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Divider(color: widget.colors.textBlack)),
                    8.horizontalSpace,
                    Text(
                      AppHelpers.getTranslation(TrKeys.orAccessQuickly),
                      style: CustomStyle.interNormal(
                          color: widget.colors.textBlack, size: 12),
                    ),
                    8.horizontalSpace,
                    Expanded(child: Divider(color: widget.colors.textBlack)),
                  ],
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: AppConstants.socialSignIn
                      .map((e) => SocialButton(
                            iconColor: widget.colors.textBlack.withValues(alpha: .5),
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
                                            LocalStorage.getUiType() == null) {
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
                10.verticalSpace,
                32.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
