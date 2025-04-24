import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/interface/banner.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class BannersRepository implements BannersInterface {
  @override
  Future<Either<BannersPaginateResponse, dynamic>> getBannersPaginate({
    int? page,
  }) async {
    final data = {
      'perPage': 50,
      'page': page,
      'lang': LocalStorage.getLanguage()?.locale,
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
        '/api/v1/rest/banners/paginate',
        queryParameters: data,
      );
      return left(BannersPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get banners paginate failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }


  @override
  Future<Either<List<ProductData>, dynamic>> getBannerById(
      {required int id}) async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale,
      if (LocalStorage.getAddress()?.regionId != null)
        'region_id': LocalStorage.getAddress()?.regionId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
      'banner_id': id,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/paginate',
        queryParameters: data,
      );
      return left(
          ProductsPaginateResponse.fromJson(response.data).data ??
              []);
    } catch (e) {
      debugPrint('==> get look by id failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<List<List<StoryModel?>?>, dynamic>> getStory(int page) async {
    final data = {
      'perPage': 30,
      'page': page,
      'lang': LocalStorage.getLanguage()?.locale,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/stories/paginate',
        queryParameters: data,
      );
      return left(storyModelFromJson(response.data) ?? []);
    } catch (e) {
      debugPrint('==> get all shops failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

}