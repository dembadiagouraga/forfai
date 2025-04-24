part of 'edit_product_bloc.dart';

@freezed
class EditProductState with _$EditProductState {
  const factory EditProductState({
    @Default(null) int? regionId,
    @Default(null) int? countryId,
    @Default(null) int? cityId,
    @Default(null) int? areaId,
    @Default(true) bool active,
    @Default(false) bool isLoading,
    @Default([]) List<String> images,
    @Default([]) List<Galleries> listOfUrls,
    @Default([]) List<SelectedAttribute> attributes,
    @Default(null) Galleries? video,
    @Default(null) ProductData? product,
    @Default({}) Map<String, List<String>> translations,
  }) = _EditProductState;

  const EditProductState._();
}
