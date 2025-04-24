part of 'banner_bloc.dart';

@freezed
class BannerState with _$BannerState {
  const factory BannerState({
    @Default([]) List<BannerData> banners,
    @Default([]) List<ProductData> products,
    @Default(true) bool isLoadingBanner,
    @Default(true) bool isLoadingProduct,
  }) = _BannerState;
}
