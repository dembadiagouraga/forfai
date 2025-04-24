import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/product_filter_model.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'user_product_event.dart';

part 'user_product_state.dart';

part 'user_product_bloc.freezed.dart';

class UserProductBloc extends Bloc<UserProductEvent, UserProductState> {
  int activePage = 0;
  int unActivePage = 0;
  int waitingPage = 0;

  UserProductBloc() : super(const UserProductState()) {
    on<FetchActiveProduct>(fetchActiveProduct);
    on<FetchUnActiveProduct>(fetchUnActiveProduct);
    on<FetchWaitingProduct>(fetchWaitingProduct);
    on<UpdateState>(updateState);
    on<ChangeActivate>(changeActivate);
    on<SetIndex>(setIndex);
    on<DeleteProduct>(deleteProduct);
  }

  fetchActiveProduct(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      activePage = 0;
      emit(state.copyWith(activeProducts: [], isLoadingActive: true));
    }
    final res = await productsRepository.fetchUserProducts(
        filter: ProductFilterModel(
      page: ++activePage,
      active: true,
      status: 'published',
    ));
    res.fold((l) {
      List<ProductData> list = List.from(state.activeProducts);
      list.addAll(l.data ?? []);
      emit(state.copyWith(
        isLoadingActive: false,
        activeProducts: list,
        activeLength: l.meta?.total,
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
      emit(state.copyWith(isLoadingActive: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  fetchUnActiveProduct(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      unActivePage = 0;
      emit(state.copyWith(unActiveProducts: [], isLoadingUnActive: true));
    }
    final res = await productsRepository.fetchUserProducts(
        filter: ProductFilterModel(
      page: ++unActivePage,
      active: false,
    ));
    res.fold((l) {
      List<ProductData> list = List.from(state.unActiveProducts);
      list.addAll(l.data ?? []);
      emit(state.copyWith(
        isLoadingUnActive: false,
        unActiveProducts: list,
        unActiveLength: l.meta?.total,
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
      emit(state.copyWith(isLoadingUnActive: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  fetchWaitingProduct(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      waitingPage = 0;
      emit(state.copyWith(waitingProducts: [], isLoadingWaiting: true));
    }
    final res = await productsRepository.fetchUserProducts(
        filter: ProductFilterModel(
      page: ++waitingPage,
      status: "pending",
      active: true,
    ));
    res.fold((l) {
      List<ProductData> list = List.from(state.waitingProducts);
      list.addAll(l.data ?? []);
      emit(state.copyWith(
        isLoadingWaiting: false,
        waitingProducts: list,
        waitingLength: l.meta?.total,
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
      emit(state.copyWith(isLoadingWaiting: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  changeActivate(event, emit) async {
    emit(state.copyWith(isLoadingUnActive: true));

    final res = await productsRepository.changeActive(
      slug: event.product?.slug ?? '',
    );
    res.fold((l) async {
      add(UserProductEvent.fetchActiveProduct(
          context: event.context, isRefresh: true));
      add(UserProductEvent.fetchUnActiveProduct(
          context: event.context, isRefresh: true));
      emit(state.copyWith(isLoadingUnActive: false));
      if (event.help != null) {
        productsRepository.feedback(
            productId: event.product.id, helpful: event.help);
      }
      Navigator.pop(event.context);
    }, (r) {
      emit(state.copyWith(isLoadingUnActive: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  deleteProduct(event, emit) async {
    emit(state.copyWith(isButtonLoading: true));

    final res = await productsRepository.deleteProduct(id: event.product?.id);
    res.fold((l) async {
      add(UserProductEvent.fetchActiveProduct(
          context: event.context, isRefresh: true));
      add(UserProductEvent.fetchWaitingProduct(
          context: event.context, isRefresh: true));
      add(UserProductEvent.fetchUnActiveProduct(
          context: event.context, isRefresh: true));
      emit(state.copyWith(isButtonLoading: false));
      Navigator.pop(event.context);
    }, (r) {
      emit(state.copyWith(isButtonLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  updateState(event, emit) {
    emit(state.copyWith(isLoadingActive: !state.isLoadingActive));
    emit(state.copyWith(isLoadingActive: !state.isLoadingActive));
  }

  setIndex(event, emit) {
    emit(state.copyWith(tabIndex: event.index));
  }
}
