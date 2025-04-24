part of 'unit_bloc.dart';

@freezed
abstract class UnitEvent with _$UnitEvent {
  const factory UnitEvent.fetchUnits(
      {required BuildContext context,
      bool? isRefresh,
      String? query,
      RefreshController? controller}) = FetchUnits;
}
