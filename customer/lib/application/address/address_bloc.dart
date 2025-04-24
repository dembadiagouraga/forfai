
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/area_model.dart';
import 'package:quick/domain/model/model/country_model.dart';
import 'package:quick/domain/model/response/city_pagination_response.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'address_event.dart';

part 'address_state.dart';

part 'address_bloc.freezed.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  int page = 0;
  int city = 0;
  int area = 0;

  AddressBloc() : super(const AddressState()) {
    on<FetchCountry>(fetchCountry);
    on<SearchCountry>(searchCountry);
    on<FetchCity>(fetchCity);
    on<SearchCity>(searchCity);
    on<FetchArea>(fetchArea);
    on<SearchArea>(searchArea);
  }

  fetchCountry(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      page = 0;
      emit(state.copyWith(countries: [], isLoading: true));
    }
    final res = await addressRepository.getCountry(page: ++page);
    res.fold((l) {
      List<CountryModel> list = List.from(state.countries);
      list.addAll(l.data ?? []);
      emit(state.copyWith(isLoading: false, countries: list));
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
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  searchCountry(event, emit) async {
    final res =
        await addressRepository.searchCountry(search: event.search ?? "");
    res.fold((l) {
      emit(state.copyWith(countries: l.data ?? []));
    }, (r) {
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  fetchCity(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      city = 0;
      emit(state.copyWith(cities: [], isCityLoading: true));
    }
    final res =
        await addressRepository.getCity(page: ++city, countyId: event.countyId);
    res.fold((l) {
      List<CityModel> list = List.from(state.cities);
      list.addAll(l.data ?? []);
      emit(state.copyWith(isCityLoading: false, cities: list));
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
      emit(state.copyWith(isCityLoading: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();

      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  searchCity(event, emit) async {
    final res = await addressRepository.searchCity(
        search: event.search ?? "", countyId: event.countyId);
    res.fold((l) {
      emit(state.copyWith(cities: l.data ?? []));
    }, (r) {
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  fetchArea(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      area = 0;
      emit(state.copyWith(areas: [], isAreaLoading: true));
    }
    final res =
        await addressRepository.getArea(page: ++area, cityId: event.cityId);
    res.fold((l) {
      List<AreaModel> list = List.from(state.areas);
      list.addAll(l.data ?? []);
      emit(state.copyWith(isAreaLoading: false, areas: list));
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
      emit(state.copyWith(isAreaLoading: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();

      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }

  searchArea(event, emit) async {
    final res = await addressRepository.searchArea(
        search: event.search ?? "", cityId: event.cityId);
    res.fold((l) {
      emit(state.copyWith(areas: l.data ?? []));
    }, (r) {
      AppHelpers.errorSnackBar(context: event.context, message: r);
    });
  }
}
