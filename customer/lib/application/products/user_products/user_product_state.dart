part of 'user_product_bloc.dart';

@freezed
class UserProductState with _$UserProductState {
  const factory UserProductState({
    @Default([]) List<ProductData> activeProducts,
    @Default([]) List<ProductData> unActiveProducts,
    @Default([]) List<ProductData> waitingProducts,
    @Default(true) bool isLoadingActive,
    @Default(true) bool isLoadingUnActive,
    @Default(true) bool isLoadingWaiting,
    @Default(true) bool isButtonLoading,
    @Default(0) int tabIndex,
    int? activeLength,
    int? unActiveLength,
    int? waitingLength,
  }) = _UserProductState;
}
