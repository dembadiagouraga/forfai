import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/interface/review.dart';
import 'package:quick/domain/model/models.dart';

import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class ReviewRepository implements ReviewInterface {
  @override
  Future addReview(
    String productSlug,
    String comment,
    double rating,
    String? imageUrl,
  ) async {
    final data = {
      'rating': rating,
      'comment': comment,
      if (imageUrl != null) 'images': [imageUrl],
    };
    debugPrint('===> add review data: $data');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/user/products/review/$productSlug',
        data: data,
      );
      return;
    } catch (e) {
      debugPrint('==> add review failure: $e');
      return;
    }
  }

  @override
  Future<Either<ReviewCountModel, dynamic>> fetchReview({
    int? userId,
    int? productId,
    int? driverId,
  }) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final Response response;
      if (userId != null) {
        response =
            await client.get('/api/v1/rest/shops/$userId/reviews-group-rating');
      } else if (driverId != null) {
        response = await client
            .get('/api/v1/rest/users/$driverId/reviews-group-rating');
      } else {
        response = await client
            .get('/api/v1/rest/products/$productId/reviews-group-rating');
      }
      return left(ReviewCountModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get review failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ReviewResponseModel, dynamic>> fetchReviewList(
      {required ReviewRequestModel requestModel}) async {
    final data = {"column": "user"};
    try {
      final client =
          dioHttp.client(requireAuth: LocalStorage.getToken().isNotEmpty);
      final Response response;
      if (requestModel.userId != null) {
        response = await client.get(
            '/api/v1/rest/shops/${requestModel.userId}/reviews',
            queryParameters: data);
      } else if (requestModel.productSlug != null) {
        response = await client.get(
            '/api/v1/rest/products/reviews/${requestModel.productSlug}',
            queryParameters: data);
      } else if (requestModel.driverId != null) {
        response = await client.get(
            '/api/v1/rest/users/reviews?assign=deliveryman1&assign_id=${requestModel.driverId}',
            queryParameters: data);
      } else {
        response = await client.get(
            '/api/v1/rest/blogs/${requestModel.blogId}/reviews',
            queryParameters: data);
      }
      return left(ReviewResponseModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get review shop failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<bool, dynamic>> sendReviewProduct(
      {required String? productUuid,
      required String? title,
      required List list,
      required num? rate}) async {
    try {
      final data = {
        'rating': rate,
        if (title != "") 'comment': title,
        "images": [for (int i = 0; i < list.length; i++) list[i]]
      };
      final client = dioHttp.client(requireAuth: true);
      await client.post('/api/v1/dashboard/user/products/review/$productUuid',
          data: data);
      return left(true);
    } catch (e) {
      debugPrint('==> send review product failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<bool, dynamic>> sendReviewShop(
      {required int? userId,
      required String? title,
      required List list,
      required num? rate}) async {
    try {
      final data = {
        'rating': rate,
        if (title != "") 'comment': title,
        "images": [for (int i = 0; i < list.length; i++) list[i]]
      };
      final client = dioHttp.client(requireAuth: true);

      await client.post('/api/v1/dashboard/user/shops/review/$userId',
          data: data);
      return left(true);
    } catch (e) {
      debugPrint('==> send review shop failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<bool, dynamic>> sendReviewOrder(
      {required int? orderId,
      required String? title,
      required List list,
      required num? rate}) async {
    try {
      final data = {
        'rating': rate,
        if (title != "") 'comment': title,
        "images": [for (int i = 0; i < list.length; i++) list[i]]
      };
      final client = dioHttp.client(requireAuth: true);

      await client.post(
          '/api/v1/dashboard/user/orders/deliveryman-review/$orderId',
          data: data);
      return left(true);
    } catch (e) {
      debugPrint('==> send review shop failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<bool, dynamic>> sendReviewBlog(
      {required int? blogId,
      required String? title,
      required List list,
      required num? rate}) async {
    try {
      final data = {
        'rating': rate,
        if (title != "") 'comment': title,
        "images": [for (int i = 0; i < list.length; i++) list[i]]
      };
      final client = dioHttp.client(requireAuth: true);

      await client.post('/api/v1/dashboard/user/blogs/review/$blogId',
          data: data);
      return left(true);
    } catch (e) {
      debugPrint('==> send review blog failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<ReviewCheckResponse, dynamic>> checkReview(
      {int? userId, int? productId, int? blogId}) async {
    try {
      final data = {
        'type': userId != null
            ? "shop"
            : productId != null
                ? "product"
                : "blog",
        "type_id": userId ?? productId ?? blogId
      };
      final client =
          dioHttp.client(requireAuth: LocalStorage.getToken().isNotEmpty);

      final res =
          await client.get('/api/v1/rest/added-review', queryParameters: data);
      return left(ReviewCheckResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> check review failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }
}
