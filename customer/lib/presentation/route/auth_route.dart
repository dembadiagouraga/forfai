part of 'app_route.dart';

abstract class AuthRoute {
  AuthRoute._();

  static goLogin(BuildContext context) =>
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthBloc(),
            child: const AuthPage(),
          ),
        ),
        (route) => false,
      );

  static goLoginBottomSheet(BuildContext context, CustomColorSet colors,
      TextEditingController phone) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: LoginScreen(
          colors: colors,
          phone: phone,
        ),
      ),
    );
  }

  static goConfirmBottomSheet({
    required BuildContext context,
    required CustomColorSet colors,
    String? phone,
    bool isReset = false,
    String? email,
  }) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: ConfirmScreen(
          colors: colors,
          phone: phone ?? '',
          email: email,
          isReset: isReset,
        ),
      ),
    );
  }

  static goForgetPasswordBottomSheet(BuildContext context,
      CustomColorSet colors, TextEditingController phone) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: ForgetPasswordScreen(
          colors: colors,
          phone: phone,
        ),
      ),
    );
  }

  static goUpdatePasswordBottomSheet(BuildContext context,
      CustomColorSet colors, TextEditingController phone) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: UpdatePasswordScreen(
          colors: colors,
          phone: phone.text,
        ),
      ),
    );
  }

  static goSignUpFieldBottomSheet(
      BuildContext context, CustomColorSet colors, String phone) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: SignUpFieldScreen(
            colors: colors,
            isPhone: AppHelpers.checkPhone(phone),
            phone: phone),
      ),
    );
  }

  static goSignUpBottomSheet(BuildContext context, CustomColorSet colors,
      TextEditingController phone) {
    return AppHelpers.showCustomModalBottomSheet(
      context: context,
      modal: BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: SignUpScreen(colors: colors, phone: phone),
      ),
    );
  }
}
