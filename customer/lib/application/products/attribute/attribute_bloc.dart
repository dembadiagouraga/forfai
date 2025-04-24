

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'attribute_event.dart';

part 'attribute_state.dart';

part 'attribute_bloc.freezed.dart';

class AttributeBloc extends Bloc<AttributeEvent, AttributeState> {
  int page = 0;

  AttributeBloc() : super(const AttributeState()) {
    on<FetchAttributes>(fetchAttributes);
  }

  fetchAttributes(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      page = 0;
      emit(state.copyWith(attribute: [], isLoading: true));
    }

    final res = await productsRepository.fetchAttribute(
        // page: ++page,
        // query: event.query,
        event.categoryId);

    res.fold((l) {
      List<AttributesData> list = List.from(state.attribute);
      list.addAll(l.data ?? []);
      emit(state.copyWith(
        isLoading: false,
        attribute: list,
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
