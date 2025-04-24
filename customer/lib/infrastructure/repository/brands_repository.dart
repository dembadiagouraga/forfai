import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/interface/brands.dart';
import 'package:quick/domain/model/models.dart';

import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class BrandsRepository implements BrandsInterface {
  @override
  Future<Either<SingleBrandResponse, dynamic>> getSingleBrand(int id) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/brands/$id');
      return left(SingleBrandResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get brand failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<BrandsPaginateResponse, dynamic>> getAllBrands(
      {String? query, required int page, int? userId}) async {
    final data = {
      'perPage': 10,
      'lang': LocalStorage.getLanguage()?.locale,
      "page": page,
      if(userId != null)
      "user_id": userId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
      if (query != null) 'search': query,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/brands/paginate',
        queryParameters: data,
      );
      return left(BrandsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get all brands failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<UnitsPaginateResponse, dynamic>> getAllUnits(
      {String? query, required int page, int? userId}) async {
    final data = {
      'perPage': 10,
      'lang': LocalStorage.getLanguage()?.locale,
      "page": page,
      if(userId != null)
        "user_id": userId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
      if (query != null) 'search': query,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/units/paginate',
        queryParameters: data,
      );
      return left(UnitsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get all units failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }
}
