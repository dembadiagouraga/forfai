import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/interface/category.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class CategoryRepository implements CategoryInterface {
  @override
  Future<Either<CategoriesPaginateResponse, dynamic>> getAllCategories(
      {required int page, String? query}) async {
    final data = {
      'per_page': 10,
      "page": page,
      "column": "input",
      'sort': 'asc  ',
      'lang': LocalStorage.getLanguage()?.locale,
      "type": "main",
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
      if (query != null) 'search': query,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/categories/parent',
        queryParameters: data,
      );
      return left(CategoriesPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get categories failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }
}
