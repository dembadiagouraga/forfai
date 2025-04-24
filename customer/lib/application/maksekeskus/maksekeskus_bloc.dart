

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/maksekeskus_data.dart';
import 'package:quick/infrastructure/service/services.dart';

part 'maksekeskus_event.dart';

part 'maksekeskus_state.dart';

part 'maksekeskus_bloc.freezed.dart';

class MaksekeskusBloc extends Bloc<MaksekeskusEvent, MaksekeskusState> {
  MaksekeskusBloc() : super(const MaksekeskusState()) {
    on<SelectMethod>(selectMethod);
    on<FetchMaksekeskus>(fetchMaksekeskus);
  }

  selectMethod(event, emit) async {
    emit(state.copyWith(selectMethodLink: event.link));
  }

  fetchMaksekeskus(event, emit) async {
    emit(state.copyWith(isLoading: true));
    final res = await paymentsRepository.paymentMaksekeskusView(
      wallet: event.wallet ?? false,
    );
    res.fold((l) async {
      emit(state.copyWith(isLoading: false, maksekeskus: l.data));
    }, (r) {
      emit(state.copyWith(isLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }
}
