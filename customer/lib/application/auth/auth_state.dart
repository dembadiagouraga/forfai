part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isShowPassword,
    @Default(false) bool isShowConfirmPassword,
    @Default(false) bool isAcceptTerm,
    @Default(AuthType.login) AuthType screenType,
    @Default(false) bool isError,
    @Default(false) bool isReset,
    @Default("") String verificationId,
    @Default('02:00') String timerText,
  }) = _AuthState;
}
