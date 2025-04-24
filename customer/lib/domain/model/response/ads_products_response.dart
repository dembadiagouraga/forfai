import 'package:quick/domain/model/model/product_model.dart';

import 'response.dart';

class AdsProductsResponse {
  List<ProductAd>? data;
  Links? links;
  Meta? meta;

  AdsProductsResponse({
    this.data,
    this.links,
    this.meta,
  });

  AdsProductsResponse copyWith({
    List<ProductAd>? data,
    Links? links,
    Meta? meta,
  }) =>
      AdsProductsResponse(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory AdsProductsResponse.fromJson(Map<String, dynamic> json) => AdsProductsResponse(
    data: json["data"] == null ? [] : List<ProductAd>.from(json["data"]!.map((x) => ProductAd.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class ProductAd {
  int? id;
  int? userAdsPackageId;
  int? productId;
  DateTime? expiredAt;
  int? input;
  ProductData? product;

  ProductAd({
    this.id,
    this.userAdsPackageId,
    this.productId,
    this.expiredAt,
    this.input,
    this.product,
  });

  ProductAd copyWith({
    int? id,
    int? userAdsPackageId,
    int? productId,
    DateTime? expiredAt,
    int? input,
    ProductData? product,
  }) =>
      ProductAd(
        id: id ?? this.id,
        userAdsPackageId: userAdsPackageId ?? this.userAdsPackageId,
        productId: productId ?? this.productId,
        expiredAt: expiredAt ?? this.expiredAt,
        input: input ?? this.input,
        product: product ?? this.product,
      );

  factory ProductAd.fromJson(Map<String, dynamic> json) => ProductAd(
    id: json["id"],
    userAdsPackageId: json["user_ads_package_id"],
    productId: json["product_id"],
    expiredAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
    input: json["input"],
    product: json["product"] == null ? null : ProductData.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_ads_package_id": userAdsPackageId,
    "product_id": productId,
    "expired_at": expiredAt?.toIso8601String(),
    "input": input,
    "product": product?.toJson(),
  };
}








