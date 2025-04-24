part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default([]) List<ProductAd> adProducts,
    @Default([]) List<ProductData> commonProduct,
    @Default([]) List<ProductData> likeProducts,
    @Default([]) List<ProductData> allProductList,
    @Default([]) List<CategoryData> fullProducts,
    @Default(true) bool isLoadingAd,
    @Default(true) bool isLoading,
    @Default(true) bool isLoadingLike,
    @Default(0) int totalCount,
  }) = _ProductState;
}
