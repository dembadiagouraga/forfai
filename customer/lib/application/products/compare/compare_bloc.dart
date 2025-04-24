

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'compare_event.dart';

part 'compare_state.dart';

part 'compare_bloc.freezed.dart';

class CompareBloc extends Bloc<CompareEvent, CompareState> {
  int page = 0;

  CompareBloc() : super(const CompareState()) {
    on<FetchProducts>(fetchProducts);

    on<SetExtraGroup>(setExtraGroup);
  }

  fetchProducts(FetchProducts event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      page = 0;
      emit(state.copyWith(compare: [], isLoading: true));
    }
    final res = await productsRepository.getCompare(page: page);
    res.fold((l) {
      List<List<ProductData>> list = List.from(state.compare);
      list.addAll(l.compare ?? []);
      emit(state.copyWith(isLoading: false, compare: list));
      if (event.isRefresh ?? false) {
        event.controller?.refreshCompleted();
        return;
      } else if (l.compare?.isEmpty ?? true) {
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

  setExtraGroup(SetExtraGroup event, emit) {
    List<AttributesData> attributes = [];
    for (var element in event.products) {
      element.attributes?.forEach((value) {
        if (!(attributes.any((e) => e.id == value.id))) {
          attributes.add(value);
        }
      });
    }
    emit(state.copyWith(attributes: attributes));
  }
}
