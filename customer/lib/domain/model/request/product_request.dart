import 'package:quick/infrastructure/local_storage/local_storage.dart';

import 'selected_request.dart';

class ProductRequest {
  int? categoryId;
  int? regionId;
  int? countryId;
  int? brandId;
  int? unitId;
  num? price;
  int? cityId;
  int? areaId;
  String? title;
  String? desc;
  String? type;
  String? condition;
  List<String>? images;
  List<String>? previews;
  List<SelectedAttribute>? attributes;
  int? currencyId;
  int? ageLimit;
  String? phone;
  String? email;
  String? name;

  ProductRequest({
    this.categoryId,
    this.regionId,
    this.countryId,
    required this.unitId,
    required this.brandId,
    required this.price,
    required this.type,
    required this.condition,
    this.cityId,
    this.areaId,
    this.images,
    this.previews,
    this.currencyId,
    this.attributes,
    required this.title,
    required this.ageLimit,
    required this.desc,
    required this.name,
    required this.phone,
    required this.email,
  });

  ProductRequest copyWith({
    int? cityId,
    int? areaId,
    int? regionId,
    int? countryId,
    List<String>? images,
    List<String>? previews,
    List<SelectedAttribute>? attributes,
  }) =>
      ProductRequest(
        categoryId: categoryId,
        unitId: unitId,
        countryId: countryId ?? this.countryId,
        areaId: areaId ?? this.areaId,
        regionId: regionId ?? this.regionId,
        cityId: cityId ?? this.cityId,
        images: images ?? this.images,
        previews: previews ?? this.previews,
        brandId: brandId,
        price: price,
        title: title,
        desc: desc,
        ageLimit: ageLimit,
        currencyId: currencyId,
        type: type,
        condition: condition,
        phone: phone,
        name: name,
        email: email,
        attributes: attributes,
      );

  Map<String, dynamic> toJson() => {
        if (categoryId != null) "category_id": categoryId,
        if (countryId != null) "country_id": countryId,
        if (regionId != null) "region_id": regionId,
        if (brandId != null) "brand_id": brandId,
        if (unitId != null) "unit_id": unitId,
        if (cityId != null) "city_id": cityId,
        if (areaId != null) "area_id": areaId,
        if (price != null) "price": price,
        if (images != null) "images": images,
        if (ageLimit != null) "age_limit": ageLimit,
        if (previews != null) "previews": previews,
        if (phone != null) "phone": phone,
        if (email != null) "email": email,
        if (name != null) "contact_name": name,
        "state": condition == 'new' ? 1 : 0,
        if (type != null) "type": type,
        if (attributes != null)
          "attribute_values": attributes == null
              ? []
              : List.from(attributes!.map((x) => x.toJson())),
        "active": 1,
        "currency_id": currencyId ?? LocalStorage.getSelectedCurrency()?.id,
        if (title?.isNotEmpty ?? false)
          'title': {LocalStorage.getLanguage()?.locale ?? 'en': title},
        if (desc?.isNotEmpty ?? false)
          'description': {LocalStorage.getLanguage()?.locale ?? 'en': desc},
      };
}
