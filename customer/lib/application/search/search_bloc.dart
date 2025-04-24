

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/brand_data.dart';
import 'package:quick/domain/model/model/category_model.dart';
import 'package:quick/domain/model/model/product_filter_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int? userId;
  int? categoryId;

  SearchBloc() : super(const SearchState()) {
    on<SetQuery>(setQuery);

    on<SearchProduct>(searchProduct);

    on<SearchCategory>(searchCategory);

    on<SearchBrand>(searchBrand);

    on<UpdateRecently>(updateRecently);
  }

  setQuery(event, emit) async {
    userId = event.userId;
    categoryId = event.categoryId;
    emit(state.copyWith(query: event.query));
  }

  searchProduct(event, emit) async {
    emit(state.copyWith(isProductLoading: true));

    final res = await productsRepository.fetchProducts(
        filter: ProductFilterModel(
      query: state.query,
      page: 1,
      userId: userId,
      categoryId: categoryId,
    ));
    res.fold((l) {
      emit(state.copyWith(isProductLoading: false, products: l.data ?? []));
    }, (r) {
      emit(state.copyWith(isProductLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  searchCategory(event, emit) async {
    emit(state.copyWith(isCategoryLoading: true));

    final res = await categoriesRepository.getAllCategories(
        query: state.query, page: 1);
    res.fold((l) {
      emit(state.copyWith(isCategoryLoading: false, categories: l.data ?? []));
    }, (r) {
      emit(state.copyWith(isCategoryLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  searchBrand(event, emit) async {
    emit(state.copyWith(isBrandLoading: true));

    final res =
        await brandsRepository.getAllBrands(query: state.query, page: 1);
    res.fold((l) {
      emit(state.copyWith(isBrandLoading: false, brands: l.data ?? []));
    }, (r) {
      emit(state.copyWith(isBrandLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  updateRecently(event, emit) async {
    emit(state.copyWith(isShopLoading: true));
    emit(state.copyWith(isShopLoading: false));
  }
}
