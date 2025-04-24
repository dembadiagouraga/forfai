import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/auth/auth_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/bottom_sheets/modal_wrap.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/pages/auth/widgets/send_again_button.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ConfirmScreen extends StatefulWidget {
  final CustomColorSet colors;
  final String phone;
  final String? email;
  final bool editPhone;
  final bool isReset;

  const ConfirmScreen({
    super.key,
    required this.colors,
    required this.phone,
    this.editPhone = false,
    this.email,
    this.isReset = false,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.editPhone
        ? _editPhone()
        : ModalWrap(
            colors: widget.colors,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.switchScreen(AuthType.login));
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Remix.arrow_left_s_line,
                              color: widget.colors.textBlack,
                              size: 26.r,
                            )),
                        const Spacer(),
                        Text(
                          AppHelpers.getTranslation(TrKeys.enterOtpCode),
                          style: CustomStyle.interSemi(
                              color: widget.colors.textBlack, size: 20),
                        ),
                        const Spacer(),
                        SizedBox(width: 42.r)
                      ],
                    ),
                    16.verticalSpace,
                    Center(
                      child: Text(
                        "${AppHelpers.getTranslation(TrKeys.weAreSendOTPCodeTo)} ${widget.phone}",
                        style: CustomStyle.interRegular(
                          size: 16,
                          color: widget.colors.textBlack,
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    SizedBox(
                      height: 64,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (n, l) {
                          return n.isError != l.isError;
                        },
                        builder: (context, state) {
                          return PinFieldAutoFill(
                            codeLength: 6,
                            controller: controller,
                            currentCode: controller.text,
                            onCodeSubmitted: (number) {
                              context.read<AuthBloc>().add(
                                  AuthEvent.checkVerify(
                                      context: context,
                                      verifyId: state.verificationId,
                                      code: number));
                            },
                            cursor: Cursor(
                              width: 1,
                              height: 24,
                              color: widget.colors.textBlack,
                              enabled: true,
                            ),
                            decoration: BoxLooseDecoration(
                              gapSpace: 10.r,
                              textStyle: CustomStyle.interNormal(
                                size: 15,
                                color: widget.colors.textBlack,
                              ),
                              bgColorBuilder: FixedColorBuilder(
                                widget.colors.transparent,
                              ),
                              radius: Radius.circular(30.r),
                              strokeColorBuilder: FixedColorBuilder(
                                state.isError
                                    ? widget.colors.error
                                    : widget.colors.icon,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    16.verticalSpace,
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (l, n) {
                        return l.isLoading != n.isLoading;
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SendAgainButton(
                                isLoading: state.isLoading,
                                colors: widget.colors,
                                phone: widget.phone,
                              ),
                            ),
                            8.horizontalSpace,
                            Expanded(
                              flex: 2,
                              child: CustomButton(
                                  isLoading: state.isLoading,
                                  title: TrKeys.confirm,
                                  bgColor: widget.colors.textBlack,
                                  titleColor: widget.colors.textWhite,
                                  changeColor: true,
                                  onTap: () {
                                    if (widget.isReset) {
                                      if (widget.email != null) {
                                        context.read<AuthBloc>().add(
                                                AuthEvent.forgotPasswordConfirm(
                                              context: context,
                                              code: controller.text,
                                              email: widget.email ?? '',
                                            ));
                                        return;
                                      }
                                      context.read<AuthBloc>().add(
                                          AuthEvent.checkVerify(
                                              editPhone: widget.editPhone,
                                              context: context,
                                              verifyId: state.verificationId,
                                              code: controller.text));
                                      return;
                                    }

                                    if (widget.email != null) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthEvent.checkVerifyEmail(
                                            context: context,
                                            code: controller.text,
                                          ));
                                      return;
                                    }
                                    context.read<AuthBloc>().add(
                                        AuthEvent.checkVerify(
                                            editPhone: widget.editPhone,
                                            context: context,
                                            verifyId: state.verificationId,
                                            code: controller.text));
                                  }),
                            ),
                          ],
                        );
                      },
                    ),
                    KeyboardVisibilityBuilder(builder: (s, isKeyboard) {
                      return isKeyboard ? 270.verticalSpace : 24.verticalSpace;
                    })
                  ],
                ),
              ),
            ),
          );
  }

  checkVerify(String verifyId) {
    if (widget.isReset) {
      if (widget.email != null) {
        context.read<AuthBloc>().add(AuthEvent.forgotPasswordConfirm(
              context: context,
              code: controller.text,
              email: widget.email ?? '',
            ));
        return;
      }
      context.read<AuthBloc>().add(AuthEvent.checkVerify(
          editPhone: widget.editPhone,
          context: context,
          verifyId: verifyId,
          code: controller.text));
      return;
    }

    if (widget.email != null) {
      context.read<AuthBloc>().add(AuthEvent.checkVerifyEmail(
            context: context,
            code: controller.text,
          ));
      return;
    }
    context.read<AuthBloc>().add(AuthEvent.checkVerify(
        editPhone: widget.editPhone,
        context: context,
        verifyId: verifyId,
        code: controller.text));
  }

  Container _editPhone() {
    return Container(
      height: 300.r,
      decoration: BoxDecoration(color: widget.colors.backgroundColor),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.confirmation),
                style: CustomStyle.interSemi(
                    color: widget.colors.textBlack, size: 30),
              ),
              16.verticalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.weAreSendOTPCodeTo),
                style: CustomStyle.interRegular(
                  size: 16,
                  color: widget.colors.textBlack,
                ),
              ),
              Text(
                widget.phone,
                style: CustomStyle.interRegular(
                  size: 16,
                  color: widget.colors.textBlack,
                ),
              ),
              24.verticalSpace,
              SizedBox(
                height: 64,
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (n, l) {
                    return n.isError != l.isError;
                  },
                  builder: (context, state) {
                    return PinFieldAutoFill(
                      codeLength: 6,
                      controller: controller,
                      currentCode: controller.text,
                      onCodeSubmitted: (number) {
                        context.read<AuthBloc>().add(AuthEvent.checkVerify(
                            context: context,
                            verifyId: state.verificationId,
                            code: number));
                      },
                      cursor: Cursor(
                        width: 1,
                        height: 24,
                        color: widget.colors.textBlack,
                        enabled: true,
                      ),
                      decoration: BoxLooseDecoration(
                        gapSpace: 10.r,
                        textStyle: CustomStyle.interNormal(
                          size: 15,
                          color: widget.colors.textBlack,
                        ),
                        bgColorBuilder: FixedColorBuilder(
                          widget.colors.transparent,
                        ),
                        strokeColorBuilder: FixedColorBuilder(
                          state.isError
                              ? widget.colors.error
                              : widget.colors.bottomBarColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              16.verticalSpace,
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (l, n) {
                  return l.isLoading != n.isLoading;
                },
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SendAgainButton(
                            isLoading: state.isLoading,
                            colors: widget.colors,
                            phone: widget.phone),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                            isLoading: state.isLoading,
                            title: TrKeys.confirm,
                            bgColor: widget.colors.primary,
                            titleColor: CustomStyle.white,
                            onTap: () {
                              context.read<AuthBloc>().add(
                                  AuthEvent.checkVerify(
                                      editPhone: widget.editPhone,
                                      context: context,
                                      verifyId: state.verificationId,
                                      code: controller.text));
                            }),
                      ),
                    ],
                  );
                },
              ),
              KeyboardVisibilityBuilder(builder: (s, isKeyboard) {
                return isKeyboard ? 270.verticalSpace : 24.verticalSpace;
              })
            ],
          ),
        ),
      ),
    );
  }
}
