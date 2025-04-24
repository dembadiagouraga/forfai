part of 'address_bloc.dart';

@freezed
abstract class AddressEvent with _$AddressEvent {

  const factory AddressEvent.fetchCountry(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) = FetchCountry;

  const factory AddressEvent.searchCountry({
    required BuildContext context,
    String? search,
  }) = SearchCountry;

  const factory AddressEvent.fetchCity(
      {required BuildContext context,
      required int? countyId,
      bool? isRefresh,
      RefreshController? controller}) = FetchCity;

  const factory AddressEvent.searchCity({
    required BuildContext context,
    required int? countyId,
    String? search,
  }) = SearchCity;

  const factory AddressEvent.fetchArea(
      {required BuildContext context,
      required int? cityId,
      bool? isRefresh,
      RefreshController? controller}) = FetchArea;

  const factory AddressEvent.searchArea({
    required BuildContext context,
    required int? cityId,
    String? search,
  }) = SearchArea;
}
