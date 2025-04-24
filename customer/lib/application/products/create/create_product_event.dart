part of 'create_product_bloc.dart';

@freezed
class CreateProductEvent with _$CreateProductEvent {
  const factory CreateProductEvent.setCountry({int? countryId}) = SetCountry;

  const factory CreateProductEvent.setCity({int? cityId}) = SetCity;

  const factory CreateProductEvent.setImageFile({required String file}) =
      SetImageFile;

  const factory CreateProductEvent.setVideo({required Galleries gallery}) =
      SetVideo;

  const factory CreateProductEvent.deleteImage({required String value}) =
      DeleteImage;

  const factory CreateProductEvent.selectAttribute({required SelectedAttribute attribute}) =
      SelectAttribute;

  const factory CreateProductEvent.deleteVideo() = DeleteVideo;

  const factory CreateProductEvent.createProduct({
    required BuildContext context,
    required ProductRequest productRequest,
    ValueChanged<ProductData?>? created,
    VoidCallback? onError,
  }) = CreateProduct;
}
