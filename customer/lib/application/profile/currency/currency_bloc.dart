
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/currency_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_event.dart';
part 'currency_state.dart';
part 'currency_bloc.freezed.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  int all = 0;

  CurrencyBloc() : super(const CurrencyState()) {
    on<GetCurrency>(getCurrency);
  }

  getCurrency(event, emit) async {
    emit(state.copyWith(isLoading: state.currency.isEmpty));
    final res = await settingsRepository.getCurrencies();
    res.fold(
      (l) {
        emit(state.copyWith(
          isLoading: false,
          currency: l.data ?? [],
        ));
      },
      (r) {
        emit(state.copyWith(isLoading: false));
        return AppHelpers.errorSnackBar(
          context: event.context,
          message: r.toString(),
        );
      },
    );
  }
}
