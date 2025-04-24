import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';

abstract class CategoryInterface {
  Future<Either<CategoriesPaginateResponse, dynamic>> getAllCategories(
      {required int page, String? query});
}
