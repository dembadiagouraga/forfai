import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';


abstract class BannersInterface {
  Future<Either<BannersPaginateResponse, dynamic>> getBannersPaginate({
    int? page,
  });

  Future<Either<List<ProductData>, dynamic>> getBannerById({
    required int id,
  });

  Future<Either<List<List<StoryModel?>?>, dynamic>> getStory(int page);
}
