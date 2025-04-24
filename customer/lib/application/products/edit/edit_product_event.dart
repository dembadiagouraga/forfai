part of 'edit_product_bloc.dart';

@freezed
class EditProductEvent with _$EditProductEvent {
  const factory EditProductEvent.setCountry({int? countryId}) = SetCountry;

  const factory EditProductEvent.setCity({int? cityId}) = SetCity;

  const factory EditProductEvent.setArea({int? cityId}) = SetArea;

  const factory EditProductEvent.setImageFile({required String file}) =
      SetImageFile;

  const factory EditProductEvent.setVideo({required Galleries gallery}) =
      SetVideo;

  const factory EditProductEvent.deleteImage({required String value}) =
      DeleteImage;

  const factory EditProductEvent.deleteVideo() = DeleteVideo;

  const factory EditProductEvent.fetchProduct({required ProductData product}) =
      FetchProduct;

  const factory EditProductEvent.selectAttribute(
      {required SelectedAttribute attribute}) = SelectAttribute;

  const factory EditProductEvent.editProduct({
    required BuildContext context,
    required ProductRequest productRequest,
    VoidCallback? updated,
    VoidCallback? onError,
  }) = EditProduct;
}
