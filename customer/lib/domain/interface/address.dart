import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick/domain/model/models.dart';

abstract class AddressInterface {

  Future<Either<CountryPaginationResponse, dynamic>> getCountry(
      {required int page});

  Future<Either<CountryPaginationResponse, dynamic>> searchCountry(
      {required String search});

  Future<Either<CityResponseModel, dynamic>> getCity(
      {required int page, required int countyId});

  Future<Either<CityResponseModel, dynamic>> searchCity(
      {required String search, required int countyId});

  Future<Either<AreaResponseModel, dynamic>> getArea(
      {required int page, required int cityId});

  Future<Either<AreaResponseModel, dynamic>> searchArea(
      {required String search, required int cityId});

  Future<Either<DrawRouting, dynamic>> getRouting({
    required LatLng start,
    required LatLng end,
  });


}
