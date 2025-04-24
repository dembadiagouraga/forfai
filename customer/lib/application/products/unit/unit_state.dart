part of 'unit_bloc.dart';


@freezed
class UnitState with _$UnitState {
  const factory UnitState({
    @Default([]) List<UnitsData> units,
    @Default(true) bool isLoading,
  }) = _UnitState;
}
