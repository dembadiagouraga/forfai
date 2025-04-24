part of 'product_bloc.dart';

@freezed
abstract class ProductEvent with _$ProductEvent {
  const factory ProductEvent.fetchAdsProduct(
      {required BuildContext context,
      bool? isRefresh,
      int? userId,
      RefreshController? controller}) = FetchAdsProduct;

  const factory ProductEvent.fetchAllProduct(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) = FetchAllProduct;

  const factory ProductEvent.fetchLikeProduct(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) = FetchLikeProduct;

  const factory ProductEvent.fetchProducts({
    required BuildContext context,
    bool? isRefresh,
    RefreshController? controller,
    List<ProductData>? list,
    bool? isNew,
    bool? isPopular,
    bool? minPrice,
    bool? maxPrice,
    int? categoryId,
    int? userId,
    int? bannerId,
    String? query,
    List<int>? brandId,
    List<int>? categoryIds,
    List<Value>? attributes,
    num? priceTo,
    num? priceFrom,
  }) = FetchProducts;

  const factory ProductEvent.fetchFullProducts({
    required BuildContext context,
    bool? isRefresh,
    RefreshController? controller,
    int? categoryId,
    int? userId,
  }) = FetchFullProducts;

  const factory ProductEvent.updateState() = UpdateState;

}
