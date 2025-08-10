import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/domain/model/model/category_model.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

import '../response/city_pagination_response.dart';
import 'area_model.dart';
import 'brand_data.dart';
import 'country_model.dart';
import 'galleries.dart';
import 'product_ads_model.dart';
import 'review_data.dart';
import 'translation_model.dart';

import 'units_data.dart';
import 'user_model.dart';

class ProductData {
  int? id;
  int? brandId;
  int? interval;
  int? ratingCount;
  String? slug;
  int? categoryId;
  String? status;
  String? _img;

  String? get img {
    // Fix double storage issue
    if (_img == null) return null;

    String fixedImg = _img!;

    // Fix host issues - replace 127.0.0.1 with the correct IP
    if (fixedImg.contains('127.0.0.1')) {
      fixedImg = AppConstants.fixLocalIpUrl(fixedImg);
    }

    // Fix double storage path issue
    if (fixedImg.contains('/storage/storage/')) {
      fixedImg = fixedImg.replaceAll('/storage/storage/', '/storage/');
    }

    // Fix double slash issue
    if (fixedImg.contains('//storage/')) {
      fixedImg = fixedImg.replaceAll('//storage/', '/storage/');
    }

    return fixedImg;
  }

  set img(String? value) {
    _img = value;
  }
  String? type;
  String? phone;
  String? email;
  String? sellerName;
  String? condition;
  String? voiceNoteUrl;
  int? voiceNoteDuration;
  num? price;
  num? ratingAvg;
  num? totalPrice;
  bool? active;
  bool? visibility;
  DateTime? createdAt;
  DateTime? updatedAt;
  Translation? translation;
  List<Translation>? translations;
  List<String>? locales;
  CategoryData? category;
  BrandData? brand;
  UnitsData? unit;
  List<Galleries>? galleries;
  List<String>? tags;
  List<AttributesData>? attributes;
  List<ReviewData>? reviews;
  num? discount;
  int? minQty;
  int? maxQty;
  int? likeCount;
  int? callsCount;
  int? viewsCount;
  int? messageCount;
  UserModel? user;
  num? ordersCount;
  CountryModel? country;
  CityModel? city;
  AreaModel? area;
  ProductAdsModel? productAds;

  ProductData({
    this.id,
    this.brandId,
    this.interval,
    this.ratingCount,
    this.slug,
    this.categoryId,
    this.status,
    String? img,
    this.price,
    this.active,
    this.visibility,
    this.createdAt,
    this.updatedAt,
    this.translation,
    this.translations,
    this.locales,
    this.category,
    this.brand,
    this.unit,
    this.galleries,
    this.tags,
    this.type,
    this.totalPrice,
    this.ratingAvg,
    this.attributes,
    this.discount,
    this.user,
    this.minQty,
    this.maxQty,
    this.ordersCount,
    this.reviews,
    this.country,
    this.city,
    this.area,
    this.productAds,
    this.likeCount,
    this.viewsCount,
    this.callsCount,
    this.messageCount,
    this.phone,
    this.email,
    this.sellerName,
    this.condition,
    this.voiceNoteUrl,
    this.voiceNoteDuration,
  }) {
    this.img = img;
  }

  ProductData copyWith({
    int? id,
    int? brandId,
    int? interval,
    int? ratingCount,
    String? slug,
    String? type,
    int? categoryId,
    String? status,
    String? img,
    String? phone,
    num? price,
    num? totalPrice,
    num? ratingAvg,
    bool? active,
    bool? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    Translation? translation,
    List<Translation>? translations,
    List<String>? locales,
    CategoryData? category,
    BrandData? brand,
    UnitsData? unit,
    List<Galleries>? galleries,
    List<String>? tags,
    List<AttributesData>? attributes,
    CountryModel? country,
    CityModel? city,
    AreaModel? area,
    UserModel? user,
    ProductAdsModel? productAds,
    int? likeCount,
    int? callsCount,
    int? viewsCount,
    int? messageCount,
  }) =>
      ProductData(
        id: id ?? this.id,
        type: type ?? this.type,
        brandId: brandId ?? this.brandId,
        interval: interval ?? this.interval,
        ratingCount: ratingCount ?? this.ratingCount,
        slug: slug ?? this.slug,
        phone: phone ?? this.phone,
        categoryId: categoryId ?? this.categoryId,
        status: status ?? this.status,
        img: img ?? this.img,
        price: price ?? this.price,
        active: active ?? this.active,
        visibility: visibility ?? this.visibility,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        translation: translation ?? this.translation,
        translations: translations ?? this.translations,
        locales: locales ?? this.locales,
        category: category ?? this.category,
        brand: brand ?? this.brand,
        unit: unit ?? this.unit,
        galleries: galleries ?? this.galleries,
        tags: tags ?? this.tags,
        totalPrice: totalPrice ?? this.totalPrice,
        ratingAvg: ratingAvg ?? this.ratingAvg,
        attributes: attributes ?? this.attributes,
        country: country ?? this.country,
        city: city ?? this.city,
        area: area ?? this.area,
        user: user ?? this.user,
        productAds: productAds ?? this.productAds,
        likeCount: likeCount ?? this.likeCount,
        callsCount: callsCount ?? this.callsCount,
        viewsCount: viewsCount ?? this.viewsCount,
        messageCount: messageCount ?? this.messageCount,
      );

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        brandId: json["brand_id"],
        interval: json["interval"],
        ratingCount: json["rating_count"],
        slug: json["slug"],
        type: json["type"],
        categoryId: json["category_id"],
        status: json["status"],
        img: json["img"],
        phone: json["phone"],
        email: json["email"],
        sellerName: json["contact_name"],
        condition: json["state"] == 1 ? "new" : "used",
        voiceNoteUrl: json["voice_note_url"],
        voiceNoteDuration: json["voice_note_duration"],
        viewsCount: json["views_count"],
        messageCount: json["message_click_count"],
        callsCount: json["phone_views_count"],
        likeCount: json["likes_count"],
        price: json["price"],
        active: json["active"],
        visibility: json["visibility"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]).toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]).toLocal(),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
        productAds: json["product_ads_package"] == null
            ? null
            : ProductAdsModel.fromJson(json["product_ads_package"]),
        translations: json["translations"] == null
            ? []
            : List<Translation>.from(
                json["translations"]!.map((x) => Translation.fromJson(x))),
        attributes: json["attributes"] == null
            ? json["attribute_value_products"] == null
                ? []
                : List<AttributesData>.from(json["attribute_value_products"]!
                    .map((x) => AttributesData.fromJson(x)))
            : List<AttributesData>.from(
                json["attributes"]!.map((x) => AttributesData.fromJson(x))),
        locales: json["locales"] == null
            ? []
            : List<String>.from(json["locales"]!.map((x) => x)),
        category: json["category"] == null
            ? null
            : CategoryData.fromJson(json["category"]),
        brand: json["brand"] == null ? null : BrandData.fromJson(json["brand"]),
        unit: json["unit"] == null ? null : UnitsData.fromJson(json["unit"]),
        country: json["country"] == null
            ? null
            : CountryModel.fromJson(json["country"]),
        city: json["city"] == null ? null : CityModel.fromJson(json["city"]),
        area: json["area"] == null ? null : AreaModel.fromJson(json["area"]),
        totalPrice: json["total_price"],
        ratingAvg: json["r_avg"],
        galleries: json["galleries"] == null
            ? []
            : List<Galleries>.from(
                json["galleries"]!.map((x) => Galleries.fromJson(x))),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
      );

  bool get countryActive =>
     ( country != null || city != null || area != null) ? true : false;

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_id": brandId,
        "interval": interval,
        "r_avg": ratingAvg,
        "slug": slug,
        "category_id": categoryId,
        "status": status,
        "phone": phone,
        "img": img,
        "type": type,
        "price": price,
        "attributes": attributes,
        "voice_note_url": voiceNoteUrl,
        "voice_note_duration": voiceNoteDuration,
        "viewsCount": viewsCount,
        "phone_views_count": callsCount,
        "likes_count": likeCount,
        "message_click_count": messageCount,
        "active": active,
        "visibility": visibility,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "translation": translation?.toJson(),
        "user": user?.toJson(),
        "product_ads_package": productAds?.toJson(),
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "locales":
            locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
        "category": category?.toJson(),
        "brand": brand?.toJson(),
        "unit": unit?.toJson(),
        "area": area?.toJson(),
        "city": city?.toJson(),
        "country": country?.toJson(),
        "galleries": galleries == null
            ? []
            : List<dynamic>.from(galleries!.map((x) => x.toJson())),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
      };

  Map<String, dynamic> toJsonForChat() => {
        if (id != null) "id": id,
        if (slug != null) "slug": slug,
        if (img != null) "img": img,
        if (price != null) "price": price,
        if (LocalStorage.getSelectedCurrency()?.symbol != null)
          "currency": LocalStorage.getSelectedCurrency()?.symbol,
        if (translation?.title != null) "title": translation?.title,
      };
}
