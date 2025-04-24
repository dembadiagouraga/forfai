import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';

abstract class ProductsInterface {
  Future<Either<ProductsPaginateResponse, dynamic>> fetchProducts(
      {required ProductFilterModel filter});

  Future<Either<FullProductsResponse, dynamic>> fetchFullProducts(
      {required ProductFilterModel filter});

  Future<Either<ProductsPaginateResponse, dynamic>> fetchUserProducts(
      {required ProductFilterModel filter});

  Future<Either<SingleProductResponse, dynamic>> getProductDetails(String slug);

  Future<Either<SingleProductResponse, dynamic>> getUserProductDetails(
      String slug);

  Future<Either<ProductsPaginateResponse, dynamic>> getMostSoldProducts(
      {required ProductFilterModel filter});

  Future<Either<ProductsPaginateResponse, dynamic>> getRelatedProducts(
      {String? productSlug, required int page});

  Future<Either<ProductsPaginateResponse, dynamic>> getAllProducts(
      {required ProductFilterModel filter});

  Future<Either<ProductsPaginateResponse, dynamic>> getProductsByIds(
    List<int> ids,
  );

  Future<Either<ProductsPaginateResponse, dynamic>> getProductsViewed(
      {required int page, required int productId});

  Future<Either<CompareResponse, dynamic>> getCompare({required int page});

  Future<Either<ProductsPaginateResponse, dynamic>> getDiscountProducts({
    int? page,
  });

  Future<Either<FilterResponse, dynamic>> fetchFilter(
      {required FilterModel filter});

  Future<Either<SingleProductResponse, dynamic>> createProduct(
      {required ProductRequest productRequest});

  Future<Either<SingleProductResponse, dynamic>> updateProduct({
    required ProductRequest productRequest,
    required String slug,
  });

  Future<Either<String, dynamic>> getPhone({required String slug});

  Future<Either<String, dynamic>> getMessage({required String slug});

  Future<Either<bool, dynamic>> changeActive({required String slug});

  Future<Either<bool, dynamic>> deleteProduct({required int id});

  Future<Either<String, dynamic>> feedback({
    required int productId,
    required bool helpful,
  });

  Future<Either<AttributesResponse, dynamic>> fetchAttribute(int categoryId);
}
