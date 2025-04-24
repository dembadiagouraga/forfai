import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/interface/products.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class ProductsRepository implements ProductsInterface {
  @override
  Future<Either<ProductsPaginateResponse, dynamic>> fetchProducts(
      {required ProductFilterModel filter}) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/paginate',
        queryParameters: filter.toJson(),
      );
      return left(ProductsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> fetch products failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<FullProductsResponse, dynamic>> fetchFullProducts(
      {required ProductFilterModel filter}) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/',
        queryParameters: filter.toJson(),
      );
      return left(FullProductsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> fetch full products failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ProductsPaginateResponse, dynamic>> fetchUserProducts(
      {required ProductFilterModel filter}) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/products/paginate',
        queryParameters: filter.toJson(),
      );
      return left(ProductsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> fetch products failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<SingleProductResponse, dynamic>> getProductDetails(
    String slug,
  ) async {
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale,
    };
    try {
      final client =
          dioHttp.client(requireAuth: LocalStorage.getToken().isNotEmpty);
      final response = await client.get(
        '/api/v1/rest/products/$slug',
        queryParameters: data,
      );
      return left(SingleProductResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get product details failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<SingleProductResponse, dynamic>> getUserProductDetails(
    String slug,
  ) async {
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/products/$slug',
        queryParameters: data,
      );
      return left(SingleProductResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get user product details failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ProductsPaginateResponse, dynamic>> getMostSoldProducts(
      {required ProductFilterModel filter}) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/paginate',
        queryParameters: filter.toJson(),
      );
      return left(ProductsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get most sold products failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ProductsPaginateResponse, dynamic>> getProductsByIds(
    List<int> ids,
  ) async {
    Map<String, Object?> data;
    if (LocalStorage.getToken().isEmpty) {
      data = {
        'currency_id': LocalStorage.getSelectedCurrency()?.id,
        'lang': LocalStorage.getLanguage()?.locale,
        if (LocalStorage.getAddress()?.regionId != null)
          'region_id': LocalStorage.getAddress()?.regionId,
        if (LocalStorage.getAddress()?.countryId != null)
          'country_id': LocalStorage.getAddress()?.countryId,
        if (LocalStorage.getAddress()?.cityId != null)
          'city_id': LocalStorage.getAddress()?.cityId,
      };
      for (int i = 0; i < ids.length; i++) {
        data['products[$i]'] = ids[i];
      }
    } else {
      data = {
        'currency_id': LocalStorage.getSelectedCurrency()?.id,
        'lang': LocalStorage.getLanguage()?.locale,
        'type': "product",
        if (LocalStorage.getAddress()?.regionId != null)
          "region_id": LocalStorage.getAddress()?.regionId,
        if (LocalStorage.getAddress()?.countryId != null)
          'country_id': LocalStorage.getAddress()?.countryId,
        if (LocalStorage.getAddress()?.cityId != null)
          'city_id': LocalStorage.getAddress()?.cityId,
      };
    }

    try {
      final client =
          dioHttp.client(requireAuth: LocalStorage.getToken().isNotEmpty);
      final response = await client.get(
        LocalStorage.getToken().isEmpty
            ? '/api/v1/rest/products/ids'
            : "/api/v1/dashboard/likes",
        queryParameters: data,
      );
      if (LocalStorage.getToken().isNotEmpty) {
        if (ProductsPaginateResponse.fromJson(response.data).data?.isEmpty ??
            true) {
          LocalStorage.deleteLikedProductsList();
        }
        ProductsPaginateResponse.fromJson(response.data)
            .data
            ?.forEach((element) {
          if (!LocalStorage.getLikedProductsList().contains(element.id)) {
            LocalStorage.setLikedProductsList(element.id ?? 0);
          }
        });
      }
      return left(ProductsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get products by ids failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ProductsPaginateResponse, dynamic>> getDiscountProducts({
    int? page,
  }) async {
    final data = {
      if (page != null) 'page': page,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'perPage': 10,
      'has_discount': 1,
      'lang': LocalStorage.getLanguage()?.locale,
      if (LocalStorage.getAddress()?.regionId != null)
        "region_id": LocalStorage.getAddress()?.regionId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/paginate',
        queryParameters: data,
      );
      return left(ProductsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get discount products failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<FilterResponse, dynamic>> fetchFilter(
      {required FilterModel filter}) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/filter',
        queryParameters: filter.toJson(),
      );
      return left(FilterResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> fetch filter failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ProductsPaginateResponse, dynamic>> getRelatedProducts(
      {String? productSlug, required int page}) async {
    final data = {
      'page': page,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'perPage': 10,
      'column': 'category_id',
      'sort': 'desc',
      'lang': LocalStorage.getLanguage()?.locale,
      if (LocalStorage.getAddress()?.regionId != null)
        "region_id": LocalStorage.getAddress()?.regionId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/related/$productSlug',
        queryParameters: data,
      );
      return left(ProductsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get discount products failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ProductsPaginateResponse, dynamic>> getProductsViewed(
      {required int page, required int productId}) async {
    final data = {
      'page': page,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'perPage': 10,
      "id": productId,
      'lang': LocalStorage.getLanguage()?.locale,
      if (LocalStorage.getAddress()?.regionId != null)
        "region_id": LocalStorage.getAddress()?.regionId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/product-histories/paginate',
        queryParameters: data,
      );
      return left(ProductsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get viewed products failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<CompareResponse, dynamic>> getCompare(
      {required int page}) async {
    List ids = LocalStorage.getCompareList();
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale,
      if (LocalStorage.getAddress()?.regionId != null)
        "region_id": LocalStorage.getAddress()?.regionId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
    };
    for (int i = 0; i < ids.length; i++) {
      data['ids[$i]'] = ids[i];
    }

    try {
      final client =
          dioHttp.client(requireAuth: LocalStorage.getToken().isNotEmpty);
      final response = await client.get(
        "/api/v1/rest/compare",
        queryParameters: data,
      );
      return left(CompareResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> compare failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ProductsPaginateResponse, dynamic>> getAllProducts(
      {required ProductFilterModel filter}) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/paginate',
        queryParameters: filter.toJson(),
      );
      return left(ProductsPaginateResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get most sold products failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<SingleProductResponse, dynamic>> createProduct(
      {required ProductRequest productRequest}) async {
    debugPrint('===> create product ${jsonEncode(productRequest.toJson())}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/user/products',
        data: productRequest.toJson(),
      );
      return left(SingleProductResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> create product failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<SingleProductResponse, dynamic>> updateProduct({
    required ProductRequest productRequest,
    required String slug,
  }) async {
    log('===> update product ${jsonEncode(productRequest.toJson())}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/user/products/$slug',
        data: productRequest.toJson(),
      );
      return left(SingleProductResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> update product failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<String, dynamic>> getPhone({required String slug}) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/$slug/phone',
      );
      return left(response.data['data']["phone"]);
    } catch (e) {
      debugPrint('==> get product phone failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<String, dynamic>> getMessage({required String slug}) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/$slug/message',
      );
      return left(response.data.toString());
    } catch (e) {
      debugPrint('==> get product message failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<bool, dynamic>> changeActive({required String slug}) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/user/products/$slug/active',
      );
      return left(response.data['data']['active']);
    } catch (e) {
      debugPrint('==> change active failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<bool, dynamic>> deleteProduct({required int id}) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete('/api/v1/dashboard/user/products/delete',
          queryParameters: {"ids[0]": id});
      return left(true);
    } catch (e) {
      debugPrint('==> change active failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<String, dynamic>> feedback({
    required int productId,
    required bool helpful,
  }) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/user/product/feedback',
        data: {
          'product_id': productId,
          'helpful': helpful ? 1 : 0,
        },
      );
      return left(response.data.toString());
    } catch (e) {
      debugPrint('==> change active failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<AttributesResponse, dynamic>> fetchAttribute(
      int categoryId) async {
    try {
      final client = dioHttp.client();
      final response = await client.get(
        '/api/v1/rest/attributes/$categoryId',
      );
      return left(AttributesResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> fetch attributes failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }
}
