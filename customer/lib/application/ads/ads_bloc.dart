import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/route/app_route.dart';

part 'ads_event.dart';

part 'ads_state.dart';

part 'ads_bloc.freezed.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  int ads = 0;

  AdsBloc() : super(const AdsState()) {
    on<FetchAds>(fetchAds);
    on<SelectAds>(selectAds);
    on<FetchUserAds>(fetchUserAds);
    on<FetchPayments>(fetchPayments);
    on<ChangePayment>(changePayment);
    on<PurchaseAds>(purchaseAds);
    on<Boost>(boost);
  }

  int? categoryId;

  fetchAds(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      ads = 0;
      emit(state.copyWith(adsBanners: [], isLoading: true));
    }
    final res = await adsRepository.getAdsPaginate(
      page: ++ads,
      categoryId: event.categoryId,
      area: event.area,
    );
    res.fold((l) async {
      List<AdModel> list = List.from(state.adsBanners);
      list.addAll(l.data ?? []);
      emit(state.copyWith(adsBanners: list, isLoading: false));
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

  fetchUserAds(event, emit) async {
    categoryId = event.categoryId;
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      ads = 0;
      emit(state.copyWith(userAds: [], isLoading: true));
    }
    final res = await adsRepository.getUserAds(
      page: ++ads,
      categoryId: event.categoryId,
      area: event.area,
    );
    res.fold((l) async {
      List<AdModel> list = List.from(state.userAds);
      list.addAll(l.data ?? []);
      emit(state.copyWith(userAds: list, isLoading: false));
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

  changePayment(event, emit) async {
    emit(state.copyWith(selectPayment: event.payment));
  }

  selectAds(event, emit) async {
    emit(state.copyWith(selectAds: event.id));
  }

  fetchPayments(event, emit) async {
    final res = await paymentsRepository.getPayments();
    res.fold((l) {
      final payments = (l.data ?? [])
          .where((e) => e.tag != 'cash')
          .toList()
          .reversed
          .toList();
      int index = l.data?.indexWhere((e) => e.tag == 'wallet') ?? -1;
      emit(state.copyWith(payments: payments, selectPayment: l.data?[index]));
    }, (r) {
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  purchaseAds(event, emit) async {
    if (state.selectPayment == null) return;
    emit(state.copyWith(isPurchaseLoading: true));
    final res = await adsRepository.paymentWebView(
      payment: state.selectPayment!,
      id: state.selectAds,
    );

    res.fold((l) async {
      emit(state.copyWith(isPurchaseLoading: false));

      if (state.selectPayment?.tag == 'wallet') {
        add(AdsEvent.fetchUserAds(
          context: event.context,
          categoryId: categoryId,
          isRefresh: true,
        ));
        event.onSuccess.call();
        return;
      }
      final isPay = await AppRoute.goWebView(url: l, context: event.context);
      if (!(isPay ?? false)) {
        event.onFailure.call();
        return;
      } else {
        add(AdsEvent.fetchUserAds(
          context: event.context,
          categoryId: categoryId,
          isRefresh: true,
        ));
        event.onSuccess.call();
      }
    }, (r) {
      emit(state.copyWith(isPurchaseLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  boost(event, emit) async {
    emit(state.copyWith(isPurchaseLoading: true));
    final res = await adsRepository.setProductAds(
      productId: event.productId,
      adsId: event.adsId,
    );

    res.fold((l) async {
      emit(state.copyWith(isPurchaseLoading: false));
      Navigator.pop(event.context, true);
    }, (r) {
      emit(state.copyWith(isPurchaseLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }
}
