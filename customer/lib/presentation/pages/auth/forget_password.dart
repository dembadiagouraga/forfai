import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/app_constants.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/auth/auth_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/infrastructure/firebase/firebase_service.dart';
import 'package:quick/presentation/components/bottom_sheets/modal_wrap.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/components/form_field/custom_textform_field.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final CustomColorSet colors;
  final TextEditingController phone;

  const ForgetPasswordScreen(
      {super.key, required this.colors, required this.phone});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
                      AppHelpers.getTranslation(TrKeys.forgetPassword),
                      style: CustomStyle.interSemi(
                          color: widget.colors.textBlack, size: 20),
                    ),
                    const Spacer(),
                    SizedBox(width: 42.r)
                  ],
                ),
                32.verticalSpace,
                if (AppConstants.signUpType == SignUpType.email)
                  CustomTextFormField(
                    validation: AppValidators.isValidEmail,
                    controller: widget.phone,
                    label: TrKeys.email,
                    hint: TrKeys.typeSomething,
                    inputType: TextInputType.text,
                  ),
                if (AppConstants.signUpType == SignUpType.phone)
                  CustomTextFormField(
                    validation: AppValidators.emptyCheck,
                    controller: widget.phone,
                    label: TrKeys.phoneNumber,
                    hint: TrKeys.typeSomething,
                    inputType: TextInputType.phone,
                  ),
                if (AppConstants.signUpType == SignUpType.both)
                  CustomTextFormField(
                    validation: AppValidators.emptyCheck,
                    controller: widget.phone,
                    label: TrKeys.phoneNumberOrEmail,
                    hint: TrKeys.typeSomething,
                    inputType: TextInputType.text,
                  ),
                32.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (l, n) {
                    return l.isLoading != n.isLoading;
                  },
                  builder: (context, state) {
                    return CustomButton(
                        isLoading: state.isLoading,
                        title: TrKeys.continueText,
                        bgColor: widget.colors.textBlack,
                        changeColor: true,
                        titleColor: widget.colors.textWhite,
                        onTap: () {
                          final event = context.read<AuthBloc>();
                          if (formKey.currentState?.validate() ?? false) {
                            if (AppValidators.isEmail(widget.phone.text)){
                              event.add(AuthEvent.forgotPassword(
                                  context: context,
                                  email: widget.phone.text,
                                  onSuccess: () {
                                    event.add(
                                        AuthEvent.setVerificationId(id: "id"));
                                  }));
                              return;
                            }
                            if (AppHelpers.checkPhone(
                                widget.phone.text.replaceAll(" ", ""))) {
                              event.add(AuthEvent.checkPhone(
                                  context: context,
                                  phone: widget.phone.text,
                                  onSuccess: () {
                                    FirebaseService.sendCode(
                                        phone: widget.phone.text,
                                        onSuccess: (id) {
                                          event.add(AuthEvent.setVerificationId(
                                              id: id));
                                        },
                                        onError: (e) {
                                          AppHelpers.errorSnackBar(
                                              context: context, message: e);
                                        });
                                  }));
                            } else {
                              AppHelpers.errorSnackBar(
                                  context: context,
                                  message: AppHelpers.getTranslation(
                                      TrKeys.thisNotPhoneNumber));
                            }
                          }
                        });
                  },
                ),
                32.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
