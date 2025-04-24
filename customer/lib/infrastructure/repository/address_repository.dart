import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/interface/address.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class AddressRepository implements AddressInterface {
  @override
  Future<Either<CountryPaginationResponse, dynamic>> getCountry(
      {required int page}) async {
    final data = {
      'perPage': 20,
      'page': page,
      'has_price': 1,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/countries',
        queryParameters: data,
      );
      return left(CountryPaginationResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get country paginate failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<CountryPaginationResponse, dynamic>> searchCountry(
      {required String search}) async {
    final data = {
      'perPage': 48,
      'has_price': 1,
      "search": search,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/countries',
        queryParameters: data,
      );
      return left(CountryPaginationResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> search country paginate failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<CityResponseModel, dynamic>> getCity(
      {required int page, required int countyId}) async {
    final data = {
      'perPage': 48,
      'has_price': 1,
      'page': page,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
      'country_id': countyId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/cities',
        queryParameters: data,
      );
      return left(CityResponseModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get city paginate failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<CityResponseModel, dynamic>> searchCity(
      {required String search, required int countyId}) async {
    final data = {
      'perPage': 48,
      'has_price': 1,
      "search": search,
      'country_id': countyId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/cities',
        queryParameters: data,
      );
      return left(CityResponseModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> search city paginate failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<AreaResponseModel, dynamic>> getArea(
      {required int page, required int cityId}) async {
    final data = {
      'perPage': 48,
      'has_price': 1,
      'page': page,
      'city_id': cityId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/areas',
        queryParameters: data,
      );
      return left(AreaResponseModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get areas paginate failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<AreaResponseModel, dynamic>> searchArea(
      {required String search, required int cityId}) async {
    final data = {
      'perPage': 48,
      'has_price': 1,
      "search": search,
      'city_id': cityId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/areas',
        queryParameters: data,
      );
      return left(AreaResponseModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> search areas paginate failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<DrawRouting, dynamic>> getRouting(
      {required LatLng start, required LatLng end}) async {
    try {
      final client = dioHttp.client(requireAuth: false, routing: true);
      final response = await client.get(
        '/v2/directions/driving-car?api_key=${AppConstants.routingKey}&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}',
      );
      return left(
        DrawRouting.fromJson(response.data),
      );
    } catch (e) {
      return right((e.runtimeType == DioException)
          ? (e as DioException).response?.data["error"]["message"]
          : e.toString());
    }
  }

}
