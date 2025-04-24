

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'transactions_event.dart';

part 'transactions_state.dart';

part 'transactions_bloc.freezed.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  int page = 0;

  TransactionsBloc() : super(const TransactionsState()) {
    on<FetchTransactions>(fetchTransactions);




  }

  fetchTransactions(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      page = 0;
      emit(state.copyWith(transactions: [], isLoading: true));
    }
    final res = await userRepository.getTransactions(++page);
    res.fold((l) {
      List<TransactionModel> list = List.from(state.transactions);
      list.addAll(l.data ?? []);
      emit(state.copyWith(isLoading: false, transactions: list));
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
