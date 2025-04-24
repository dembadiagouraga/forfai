import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/interface/ads.dart';
import 'package:quick/domain/model/models.dart';

import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class AdsRepository implements AdsInterface {
  @override
  Future<Either<AdsPaginateResponse, dynamic>> getAdsPaginate({
    int? page,
    int? categoryId,
    AreaModel? area,
  }) async {
    final data = {
      'perPage': 5,
      'page': page,
      'lang': LocalStorage.getLanguage()?.locale,
      if (area?.regionId != null) 'region_id': area?.regionId,
      if (area?.countryId != null) 'country_id': area?.countryId,
      if (area?.cityId != null) 'city_id': area?.cityId,
      if (area?.id != null) 'area_id': area?.id,
      if (categoryId != null) 'category_id': categoryId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/ads-packages',
        queryParameters: data,
      );
      return left(AdsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get ads failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<AdsPaginateResponse, dynamic>> getUserAds({
    int? page,
    int? categoryId,
    AreaModel? area,
  }) async {
    final data = {
      'perPage': 5,
      'page': page,
      'active': 1,
      'lang': LocalStorage.getLanguage()?.locale,
      if (area?.regionId != null) 'region_id': area?.regionId,
      if (area?.countryId != null) 'country_id': area?.countryId,
      if (area?.cityId != null) 'city_id': area?.cityId,
      if (area?.id != null) 'area_id': area?.id,
      if (categoryId != null) 'category_id': categoryId,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/user-ads-packages',
        queryParameters: data,
      );
      return left(AdsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get user ads failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<String, dynamic>> paymentWebView({
    required PaymentData payment,
    required int? id,
  }) async {
    try {
      final wallet = {'payment_sys_id': payment.id};
      final data = {
        'ads_package_id': id,
        'currency_id': LocalStorage.getSelectedCurrency()?.id,
      };
      final client = dioHttp.client(requireAuth: true);
      Response res;
      if (payment.tag == 'wallet') {
        res = await client.post(
          '/api/v1/payments/ads/$id/transactions',
          data: wallet,
        );
        return left("");
      } else {
        res = await client.post(
          '/api/v1/dashboard/user/${payment.tag}-process',
          data: data,
        );
        return left(res.data["data"]["data"]["url"] ?? "");
      }
    } catch (e) {
      debugPrint('==> web view failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<AdModel, dynamic>> getAdsById({required int id}) async {
    final data = {'lang': LocalStorage.getLanguage()?.locale};
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/ads-packages/$id',
        queryParameters: data,
      );
      return left(AdModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get ads by id failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<AdsProductsResponse, dynamic>> getAdsListProductPaginate({
    int? page,
    int? userId,
  }) async {
    final data = {
      'perPage': 10,
      'page': page,
      "column": "id",
      'sort': 'desc',
      if (userId != null) "user_id": userId,
      'lang': LocalStorage.getLanguage()?.locale,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      if (LocalStorage.getAddress()?.regionId != null)
        'region_id': LocalStorage.getAddress()?.regionId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products-ads-packages',
        queryParameters: data,
      );
      return left(AdsProductsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get ads product by id failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<AdModel, dynamic>> setProductAds({
    required int productId,
    required int adsId,
  }) async {
    final data = {
      'user_ads_package_id': adsId,
      'product_id': productId,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/user/product-ads-packages',
        data: data,
      );
      return left(AdModel());
    } catch (e) {
      debugPrint('==> get ads by id failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }
}
