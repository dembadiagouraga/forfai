part of 'ads_bloc.dart';

@freezed
class AdsState with _$AdsState {
  const factory AdsState({
    @Default([]) List<AdModel> adsBanners,
    @Default([]) List<AdModel> userAds,
    @Default([]) List<PaymentData> payments,
    @Default(-1) int selectAds,
    @Default(null) PaymentData? selectPayment,
    @Default(true) bool isPaymentLoading,
    @Default(false) bool isPurchaseLoading,
    @Default(true) bool isLoading,
  }) = _AdsState;
}
