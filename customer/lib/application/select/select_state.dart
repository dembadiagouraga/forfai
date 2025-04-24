part of 'select_bloc.dart';

@freezed
class SelectState with _$SelectState {
  const factory SelectState({
    @Default(0) int selectIndex,
    @Default([]) List<Value> selectIds,
  }) = _SelectState;
}
