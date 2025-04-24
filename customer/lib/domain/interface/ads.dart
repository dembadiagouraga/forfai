import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';

abstract class AdsInterface {
  Future<Either<AdsPaginateResponse, dynamic>> getAdsPaginate({
    int? page,
    int? categoryId,
    AreaModel? area,
  });

  Future<Either<AdsPaginateResponse, dynamic>> getUserAds({
    int? page,
    int? categoryId,
    AreaModel? area,
  });

  Future<Either<String, dynamic>> paymentWebView({
    required PaymentData payment,
    required int? id,
  });

  Future<Either<AdsProductsResponse, dynamic>> getAdsListProductPaginate({
    int? page,
    int? userId,
  });

  Future<Either<AdModel, dynamic>> getAdsById({
    required int id,
  });

  Future<Either<AdModel, dynamic>> setProductAds({
    required int productId,
    required int adsId,
  });
}
