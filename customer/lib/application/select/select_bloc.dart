

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick/domain/model/response/filter_response.dart';

part 'select_event.dart';

part 'select_state.dart';

part 'select_bloc.freezed.dart';

class SelectBloc extends Bloc<SelectEvent, SelectState> {
  SelectBloc() : super(const SelectState()) {
    on<ChangeIndex>(changeIndex);
    on<SelectIds>(selectIds);
    on<SelectValue>(selectValue);
  }

  changeIndex(event, emit) {
    emit(state.copyWith(selectIndex: event.selectIndex));
  }

  selectIds(event, emit) {
    List<Value> list = [];
    list.addAll(event.ids);
    emit(state.copyWith(selectIds: list));
  }

  selectValue(SelectValue event, emit) {
    if (event.value == null) return;
    List<Value> list = List.from(state.selectIds);
    if (list.any((e) =>
        (e.valueId ?? e.value) ==
        (event.value?.valueId ?? event.value?.value))) {
      list.removeWhere((e) =>
          (e.valueId ?? e.value) ==
          (event.value?.valueId ?? event.value?.value));
    } else {
      list.add(event.value!);
    }
    emit(state.copyWith(selectIds: list));
  }
}
