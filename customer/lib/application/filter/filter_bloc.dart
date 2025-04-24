import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/domain/model/models.dart';

part 'filter_event.dart';

part 'filter_state.dart';

part 'filter_bloc.freezed.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<ClearFilter>(clearFilter);

    on<SelectType>(selectType);

    on<SelectSort>(selectSort);

    on<SetRangePrice>(setRangePrice);

    on<SetExtras>(setExtras);

    on<SetCategory>(setCategory);

    on<SetBrands>(setBrands);

    on<FetchExtras>(fetchExtras);
  }

  clearFilter(event, emit) {
    emit(state.copyWith(
      categories: [],
      brands: [],
      attributes: [],
      selectType: LayoutType.twoH,
      type: FilterType.news,
      rangeValues: null,
    ));
  }

  selectType(event, emit) {
    emit(state.copyWith(selectType: event.selectType));
  }

  selectSort(event, emit) {
    emit(state.copyWith(type: event.type));
  }

  setRangePrice(event, emit) {
    emit(state.copyWith(rangeValues: event.price));
  }

  setExtras(event, emit) {
    List<Value> list = [];
    list.addAll(event.ids);
    emit(state.copyWith(attributes: list));
  }

  setCategory(event, emit) {
    emit(state.copyWith(category: event.category));
  }

  setBrands(event, emit) {
    List<int> list = [];
    list.addAll(event.ids);
    emit(state.copyWith(brands: list));
  }

  fetchExtras(event, emit) async {
    if (event.isPrice) {
      emit(state.copyWith(rangeValues: null));
    }
    if (event.type != null) {
      emit(state.copyWith(type: event.type ?? "category"));
    }

    emit(state.copyWith(isLoading: true));
    final res = await productsRepository.fetchFilter(
      filter: FilterModel(
        type: 'category',
        attributes: state.attributes,
        parentId: event.categoryId ?? state.category?.id,
        brandId: state.brands,
        priceFrom: state.rangeValues?.start,
        priceTo: state.rangeValues?.end,
        filterType: state.type,
      ),
    );
    res.fold((l) {
      if (event.isPrice) {
        emit(
          state.copyWith(
              isLoading: false,
              filter: l,
              filterPrices: l.price,
              rangeValues: RangeValues(
                (l.price?.min ?? 0).toDouble(),
                (l.price?.max ?? 0).toDouble(),
              ),
              prices: List.generate(
                  (30).round(), (index) => (Random().nextInt(8) + 1))),
        );
        return;
      }
      emit(
        state.copyWith(isLoading: false, filter: l),
      );
    }, (r) {
      emit(state.copyWith(isLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }
}
