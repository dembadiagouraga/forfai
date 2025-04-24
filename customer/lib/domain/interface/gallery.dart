import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/enums.dart';

abstract class GalleryInterface {
  Future<Either<GalleryUploadResponse, dynamic>> uploadImage(
    String file,
    UploadType uploadType,
  );

  Future<Either<GalleryListUploadResponse, dynamic>> uploadMultipleImage(
      List files,
      UploadType uploadType,
      );
}
