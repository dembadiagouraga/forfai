import 'package:quick/domain/model/model/category_model.dart';

import 'product_model.dart';
import 'translation_model.dart';

class AdModel {
  int? id;
  int? categoryId;
  int? regionId;
  int? countryId;
  int? cityId;
  int? areaId;
  int? active;
  int? count;
  String? timeType;
  String? type;
  int? time;
  double? price;
  Translation? translation;
  List<Translation?>? translations;
  CategoryData? category;
  AdsPackage? adsPackages;

  AdModel({
    this.id,
    this.categoryId,
    this.regionId,
    this.countryId,
    this.cityId,
    this.areaId,
    this.active,
    this.count,
    this.timeType,
    this.time,
    this.type,
    this.price,
    this.translation,
    this.translations,
    this.category,
    this.adsPackages,
  });

  AdModel copyWith({
    int? id,
    int? categoryId,
    int? regionId,
    int? countryId,
    int? cityId,
    int? areaId,
    int? active,
    int? count,
    String? timeType,
    String? type,
    int? time,
    double? price,
    Translation? translation,
    List<Translation?>? translations,
    CategoryData? category,
  }) =>
      AdModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        regionId: regionId ?? this.regionId,
        countryId: countryId ?? this.countryId,
        cityId: cityId ?? this.cityId,
        areaId: areaId ?? this.areaId,
        active: active ?? this.active,
        count: count ?? this.count,
        timeType: timeType ?? this.timeType,
        time: time ?? this.time,
        price: price ?? this.price,
        translation: translation ?? this.translation,
        translations: translations ?? this.translations,
        category: category ?? this.category,
        type: type ?? this.type,
      );

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
        id: json["id"],
        categoryId: json["category_id"],
        regionId: json["region_id"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        areaId: json["area_id"],
        active: json["active"],
        count: json["count"],
        timeType: json["time_type"],
        time: json["time"],
        type: json["type"],
        price: json["price"]?.toDouble(),
        translation: json["translation"] == null
            ? null
            : Translation?.fromJson(json["translation"]),
        translations: json["translations"] == null
            ? []
            : List<Translation?>.from(
                json["translations"]!.map((x) => Translation.fromJson(x))),
        category: json["category"] == null
            ? null
            : CategoryData.fromJson(json["category"]),
        adsPackages: json["ads_package"] == null
            ? null
            : AdsPackage.fromJson(json["ads_package"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "region_id": regionId,
        "country_id": countryId,
        "city_id": cityId,
        "area_id": areaId,
        "active": active,
        "count": count,
        "time_type": timeType,
        "time": time,
        "price": price,
        "type": type,
        "translation": translation,
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x)),
        "category": category?.toJson(),
        "ads_package": adsPackages?.toJson(),
      };
}

class AdsPackage {
  int id;
  int categoryId;
  int active;
  int count;
  String timeType;
  int time;
  double price;
  Translation translation;

  AdsPackage({
    required this.id,
    required this.categoryId,
    required this.active,
    required this.count,
    required this.timeType,
    required this.time,
    required this.price,
    required this.translation,
  });

  factory AdsPackage.fromJson(Map<String, dynamic> json) => AdsPackage(
        id: json["id"],
        categoryId: json["category_id"],
        active: json["active"],
        count: json["count"],
        timeType: json["time_type"],
        time: json["time"],
        price: json["price"]?.toDouble(),
        translation: Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "active": active,
        "count": count,
        "time_type": timeType,
        "time": time,
        "price": price,
        "translation": translation.toJson(),
      };
}

class ShopAdsPackage {
  int? id;
  bool? active;
  int? adsPackageId;
  int? userId;
  String? status;
  DateTime? expiredAt;
  List<ProductData>? shopAdsProducts;

  ShopAdsPackage({
    this.id,
    this.active,
    this.adsPackageId,
    this.userId,
    this.status,
    this.expiredAt,
    this.shopAdsProducts,
  });

  ShopAdsPackage copyWith({
    int? id,
    bool? active,
    int? adsPackageId,
    int? userId,
    String? status,
    DateTime? expiredAt,
    List<ProductData>? shopAdsProducts,
  }) =>
      ShopAdsPackage(
        id: id ?? this.id,
        active: active ?? this.active,
        adsPackageId: adsPackageId ?? this.adsPackageId,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        expiredAt: expiredAt ?? this.expiredAt,
        shopAdsProducts: shopAdsProducts ?? this.shopAdsProducts,
      );

  factory ShopAdsPackage.fromJson(Map<String, dynamic> json) => ShopAdsPackage(
        id: json["id"],
        active: json["active"],
        adsPackageId: json["ads_package_id"],
        userId: json["user_id"],
        status: json["status"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
        shopAdsProducts: json["shop_ads_products"] == null
            ? []
            : List<ProductData>.from(json["shop_ads_products"]!
                .map((x) => ProductData.fromJson(x["product"]))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "ads_package_id": adsPackageId,
        "user_id": userId,
        "status": status,
        "expired_at": expiredAt?.toIso8601String(),
        "shop_ads_products": shopAdsProducts == null
            ? []
            : List<dynamic>.from(shopAdsProducts!.map((x) => x.toJson())),
      };
}
