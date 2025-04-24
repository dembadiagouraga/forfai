import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';

abstract class BlogInterface {
  Future<Either<BlogsPaginateResponse,dynamic>> getBlogs(int page, String type);

  Future<Either<BlogDetailsResponse,dynamic>> getBlogDetails(int id);
}
