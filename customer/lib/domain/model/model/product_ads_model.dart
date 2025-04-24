import 'translation_model.dart';

class ProductAdsModel {
  int? id;
  int? userAdsPackageId;
  int? productId;
  DateTime? expiredAt;
  int? input;
  UserAdsPackage? userAdsPackage;

  ProductAdsModel({
    this.id,
    this.userAdsPackageId,
    this.productId,
    this.expiredAt,
    this.input,
    this.userAdsPackage,
  });

  ProductAdsModel copyWith({
    int? id,
    int? userAdsPackageId,
    int? productId,
    DateTime? expiredAt,
    int? input,
    UserAdsPackage? userAdsPackage,
  }) =>
      ProductAdsModel(
        id: id ?? this.id,
        userAdsPackageId: userAdsPackageId ?? this.userAdsPackageId,
        productId: productId ?? this.productId,
        expiredAt: expiredAt ?? this.expiredAt,
        input: input ?? this.input,
        userAdsPackage: userAdsPackage ?? this.userAdsPackage,
      );

  factory ProductAdsModel.fromJson(Map<String, dynamic> json) => ProductAdsModel(
    id: json["id"],
    userAdsPackageId: json["user_ads_package_id"],
    productId: json["product_id"],
    expiredAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
    input: json["input"],
    userAdsPackage: json["user_ads_package"] == null ? null : UserAdsPackage.fromJson(json["user_ads_package"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_ads_package_id": userAdsPackageId,
    "product_id": productId,
    "expired_at": expiredAt?.toIso8601String(),
    "input": input,
    "user_ads_package": userAdsPackage?.toJson(),
  };
}

class UserAdsPackage {
  int? id;
  int? adsPackageId;
  int? count;
  AdsPackage? adsPackage;

  UserAdsPackage({
    this.id,
    this.adsPackageId,
    this.count,
    this.adsPackage,
  });

  UserAdsPackage copyWith({
    int? id,
    int? adsPackageId,
    int? count,
    AdsPackage? adsPackage,
  }) =>
      UserAdsPackage(
        id: id ?? this.id,
        adsPackageId: adsPackageId ?? this.adsPackageId,
        count: count ?? this.count,
        adsPackage: adsPackage ?? this.adsPackage,
      );

  factory UserAdsPackage.fromJson(Map<String, dynamic> json) => UserAdsPackage(
    id: json["id"],
    adsPackageId: json["ads_package_id"],
    count: json["count"],
    adsPackage: json["ads_package"] == null ? null : AdsPackage.fromJson(json["ads_package"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ads_package_id": adsPackageId,
    "count": count,
    "ads_package": adsPackage?.toJson(),
  };
}

class AdsPackage {
  int? id;
  Translation? translation;

  AdsPackage({
    this.id,
    this.translation,
  });

  AdsPackage copyWith({
    int? id,
    Translation? translation,
  }) =>
      AdsPackage(
        id: id ?? this.id,
        translation: translation ?? this.translation,
      );

  factory AdsPackage.fromJson(Map<String, dynamic> json) => AdsPackage(
    id: json["id"],
    translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "translation": translation?.toJson(),
  };
}
