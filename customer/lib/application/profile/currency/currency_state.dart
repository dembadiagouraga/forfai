part of 'currency_bloc.dart';

@freezed
class CurrencyState with _$CurrencyState {
  const factory CurrencyState({
    @Default(false) bool isLoading,
    @Default([]) List<CurrencyData> currency,
  }) = _CurrencyState;
}
