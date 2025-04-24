part of 'banner_bloc.dart';

@freezed
abstract class BannerEvent with _$BannerEvent {
  const factory BannerEvent.fetchBanner(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) = FetchBanner;

  const factory BannerEvent.fetchProduct(
      {required BuildContext context, required int id}) = FetchProduct;


  const factory BannerEvent.updateProduct() = UpdateProduct;

}
