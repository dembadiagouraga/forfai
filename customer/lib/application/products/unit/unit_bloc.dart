

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/units_data.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'unit_event.dart';

part 'unit_state.dart';

part 'unit_bloc.freezed.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  int page = 0;

  UnitBloc() : super(const UnitState()) {
    on<FetchUnits>(fetchUnits);
  }

  fetchUnits(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      page = 0;
      emit(state.copyWith(units: [], isLoading: true));
    }

    final res = await brandsRepository.getAllUnits(
      page: ++page,
      query: event.query,
    );

    res.fold((l) {
      List<UnitsData> list = List.from(state.units);
      list.addAll(l.data ?? []);
      emit(state.copyWith(
        isLoading: false,
        units: list,
      ));
      if (event.isRefresh ?? false) {
        event.controller?.refreshCompleted();
        return;
      } else if (l.data?.isEmpty ?? true) {
        event.controller?.loadNoData();
        return;
      }
      event.controller?.loadComplete();
      return;
    }, (r) {
      emit(state.copyWith(isLoading: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();

      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }
}
