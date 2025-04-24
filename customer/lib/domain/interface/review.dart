import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';

abstract class ReviewInterface {
  Future addReview(
    String productSlug,
    String comment,
    double rating,
    String? imageUrl,
  );

  Future<Either<ReviewResponseModel, dynamic>> fetchReviewList(
      {required ReviewRequestModel requestModel});

  Future<Either<ReviewCountModel, dynamic>> fetchReview({
    int? userId,
    int? driverId,
    int? productId,
  });

  Future<Either<bool, dynamic>> sendReviewProduct({
    required String? productUuid,
    required String? title,
    required num? rate,
    required List list,
  });

  Future<Either<bool, dynamic>> sendReviewShop({
    required int? userId,
    required String? title,
    required num? rate,
    required List list,
  });

  Future<Either<bool, dynamic>> sendReviewOrder({
    required int? orderId,
    required String? title,
    required num? rate,
    required List list,
  });

  Future<Either<bool, dynamic>> sendReviewBlog({
    required int? blogId,
    required String? title,
    required num? rate,
    required List list,
  });

  Future<Either<ReviewCheckResponse, dynamic>> checkReview({
    int? userId,
    int? productId,
    int? blogId,
  });
}
