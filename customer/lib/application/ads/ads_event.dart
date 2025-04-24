part of 'ads_bloc.dart';

@freezed
class AdsEvent with _$AdsEvent {
  const factory AdsEvent.fetchAds(
      {required BuildContext context,
      int? categoryId,
      AreaModel? area,
      bool? isRefresh,
      RefreshController? controller}) = FetchAds;

  const factory AdsEvent.fetchPayments({required BuildContext context}) =
      FetchPayments;

  const factory AdsEvent.fetchUserAds(
      {required BuildContext context,
      int? categoryId,
      AreaModel? area,
      bool? isRefresh,
      RefreshController? controller}) = FetchUserAds;

  const factory AdsEvent.changePayment({required PaymentData payment}) =
      ChangePayment;

  const factory AdsEvent.selectAds({required int id}) = SelectAds;

  const factory AdsEvent.purchaseAds({
    required BuildContext context,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) = PurchaseAds;

  const factory AdsEvent.boost({
    required BuildContext context,
    required int? productId,
    required int? adsId,
  }) = Boost;

  const factory AdsEvent.setPayment({required int id}) = setPayment;
}
