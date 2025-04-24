import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';


abstract class BrandsInterface {
  Future<Either<SingleBrandResponse, dynamic>> getSingleBrand(int id);

  Future<Either<BrandsPaginateResponse, dynamic>> getAllBrands(
      {String? query, required int page, int? userId});

  Future<Either<UnitsPaginateResponse, dynamic>> getAllUnits(
      {String? query, required int page, int? userId});
}
