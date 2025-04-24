part of 'create_product_bloc.dart';

@freezed
class CreateProductState with _$CreateProductState {
  const factory CreateProductState({
    @Default(null) int? countryId,
    @Default(null) int? cityId,
    @Default(true) bool active,
    @Default(false) bool isLoading,
    @Default([]) List<String> images,
    @Default([]) List<Galleries> listOfUrls,
    @Default(null) Galleries? video,
    @Default({}) Map<String, List<String>> translations,
    @Default([]) List<SelectedAttribute> attributes,
  }) = _CreateProductState;

  const CreateProductState._();
}
