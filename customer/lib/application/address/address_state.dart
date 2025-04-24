part of 'address_bloc.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState({
    @Default([]) List<CountryModel> countries,
    @Default([]) List<CityModel> cities,
    @Default([]) List<AreaModel> areas,
    @Default(true) bool isLoading,
    @Default(true) bool isCityLoading,
    @Default(true) bool isAreaLoading,
  }) = _AddressState;
}
