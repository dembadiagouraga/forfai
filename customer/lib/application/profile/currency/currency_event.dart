part of 'currency_bloc.dart';

@freezed
abstract class CurrencyEvent with _$CurrencyEvent {
  const factory CurrencyEvent.getCurrency({required BuildContext context}) =
      GetCurrency;
}
