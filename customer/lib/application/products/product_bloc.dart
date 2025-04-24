import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/category_model.dart';
import 'package:quick/domain/model/model/product_filter_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/domain/model/response/ads_products_response.dart';
import 'package:quick/domain/model/response/filter_response.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'product_event.dart';

part 'product_state.dart';

part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  int adPage = 0;
  int common = 0;
  int all = 0;

  ProductBloc() : super(const ProductState()) {
    on<FetchAllProduct>(fetchAllProduct);

    on<FetchAdsProduct>(fetchAdProducts);

    on<FetchLikeProduct>(fetchLikeProduct);

    on<FetchProducts>(fetchProducts);
    on<FetchFullProducts>(fetchFullProducts);

    on<UpdateState>(updateState);
  }

  fetchAllProduct(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      all = 0;
      emit(state.copyWith(allProductList: [], isLoading: true));
    }
    final res = await productsRepository.getAllProducts(
        filter: ProductFilterModel(page: ++all));
    res.fold((l) {
      List<ProductData> list = List.from(state.allProductList);
      list.addAll(l.data ?? []);
      emit(state.copyWith(isLoading: false, allProductList: list));
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

      AppHelpers.errorSnackBar(
        context: event.context,
        message: r,
      );
    });
  }

  fetchAdProducts(event, emit) async {
    if (!AppHelpers.getAds()) return;
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      adPage = 0;
      emit(state.copyWith(adProducts: [], isLoadingAd: true));
    }
    final res = await adsRepository.getAdsListProductPaginate(
        page: ++adPage, userId: event.userId);
    res.fold((l) {
      List<ProductAd> list = List.from(state.adProducts);
      list.addAll(l.data ?? []);
      emit(state.copyWith(isLoadingAd: false, adProducts: list));
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
      emit(state.copyWith(isLoadingAd: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  fetchLikeProduct(event, emit) async {
    if (!(event.isRefresh ?? false)) {
      event.controller?.resetNoData();
      emit(state.copyWith(likeProducts: [], isLoadingLike: true));
    }
    if (LocalStorage.getLikedProductsList().isEmpty &&
        LocalStorage.getToken().isEmpty) {
      emit(state.copyWith(isLoadingLike: false));
      return;
    }
    final res = await productsRepository
        .getProductsByIds(LocalStorage.getLikedProductsList());
    res.fold((l) {
      emit(state.copyWith(
        isLoadingLike: false,
        likeProducts: l.data ?? [],
      ));
      event.controller?.refreshCompleted();
    }, (r) {
      emit(state.copyWith(isLoadingLike: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  fetchProducts(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      common = 0;
      emit(state.copyWith(commonProduct: [], isLoading: true));
    }
    final res = await productsRepository.fetchProducts(
        filter: ProductFilterModel(
      page: ++common,
      categoryId: event.categoryId,
      isNew: event.isNew,
      userId: event.userId,
      isPopular: event.isPopular,
      priceMin: event.minPrice,
      priceMax: event.maxPrice,
      brandIds: event.brandId,
      categoryIds: event.categoryIds,
      attributes: event.attributes,
      priceFrom: event.priceFrom,
      priceTo: event.priceTo,
      bannerId: event.bannerId,
      query: event.query,
    ));

    res.fold((l) {
      List<ProductData> list = List.from(state.commonProduct);
      list.addAll(l.data ?? []);
      emit(state.copyWith(
          isLoading: false,
          commonProduct: list,
          totalCount: l.meta?.total ?? 0));
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

  fetchFullProducts(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      common = 0;
      emit(state.copyWith(commonProduct: [], isLoading: true));
    }
    final res = await productsRepository.fetchFullProducts(
        filter: ProductFilterModel(
      page: ++common,
      categoryId: event.categoryId,
      userId: event.userId,
    ));

    res.fold((l) {
      List<CategoryData> list = List.from(state.fullProducts);
      list.addAll(l.data ?? []);
      emit(state.copyWith(isLoading: false, fullProducts: list));
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

  updateState(event, emit) {
    emit(state.copyWith(isLoading: !state.isLoading));
    emit(state.copyWith(isLoading: !state.isLoading));
  }
}
