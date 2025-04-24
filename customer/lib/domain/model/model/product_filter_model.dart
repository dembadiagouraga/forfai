import 'package:quick/domain/model/response/filter_response.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class ProductFilterModel {
  final String? query;
  final String? status;
  final bool? active;
  final int? categoryId;
  final int? brandId;
  final int? userId;
  final int? bannerId;
  final bool? isNew;
  final bool? isPopular;
  final bool? priceMin;
  final bool? priceMax;
  final List<int>? brandIds;
  final List<int>? categoryIds;
  final List<Value>? attributes;
  final num? priceTo;
  final num? priceFrom;
  final int page;

  ProductFilterModel({
    this.query,
    this.status,
    this.active,
    this.categoryId,
    this.brandId,
    this.userId,
    this.bannerId,
    this.isNew,
    this.isPopular,
    this.priceMax,
    this.priceMin,
    this.brandIds,
    this.categoryIds,
    this.attributes,
    this.priceTo,
    this.priceFrom,
    required this.page,
  });

  factory ProductFilterModel.fromJson({
    String? query,
    int? categoryId,
    int? brandId,
    int? userId,
    int? bannerId,
    bool? isNew,
    bool? priceMax,
    bool? priceMin,
    bool? isPopular,
    List<int>? brandIds,
    List<int>? categoryIds,
    List<Value>? attributes,
    num? priceTo,
    num? priceFrom,
    required int page,
  }) {
    return ProductFilterModel(
      query: query,
      categoryId: categoryId,
      brandId: brandId,
      userId: userId,
      bannerId: bannerId,
      isNew: isNew,
      priceMax: priceMax,
      priceMin: priceMin,
      isPopular: isPopular,
      brandIds: brandIds,
      categoryIds: categoryIds,
      attributes: attributes,
      priceTo: priceTo,
      priceFrom: priceFrom,
      page: page,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (query != null) 'search': query,
      if (status != null) 'status': status,
      if (active != null) 'active': active! ? 1 : 0,
      'perPage': 10,
      "page": page,
      if (categoryIds != null)
        for (int i = 0; i < (categoryIds?.length ?? 0); i++)
          'category_ids[$i]': categoryIds?[i],
      if (brandIds != null)
        for (int i = 0; i < (brandIds?.length ?? 0); i++)
          if (brandIds?[i] != -1) 'brand_ids[$i]': brandIds?[i],
      if (attributes != null)
        for (int i = 0; i < (attributes?.length ?? 0); i++)
          'attributes[$i]': attributes?[i].toJson(),
      if (priceTo != null) "price_to": priceTo,
      if (priceFrom != null) 'price_from': priceFrom,
      if (categoryId != null) 'category_id': categoryId,
      if (brandId != null) 'brand_id': brandId,
      if (userId != null) 'user_id': userId,
      if (bannerId != null) 'banner_id': bannerId,
      if (isNew ?? false) "column": "created_at",
      if (isNew ?? false) 'sort': 'desc',
      // if (isPopular ?? false) "column": "r_avg",
      // if (isPopular ?? false) 'sort': 'desc',
      if (isPopular ?? false) 'popular': 1,
      if ((priceMin ?? false) ||( priceMax ?? false)) "column_price": "price",
      if (priceMin ?? false) 'sort': 'asc',
      if (priceMax ?? false) 'sort': 'desc',
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale,
      if (LocalStorage.getAddress()?.regionId != null)
        "region_id": LocalStorage.getAddress()?.regionId,
      if (LocalStorage.getAddress()?.countryId != null)
        'country_id': LocalStorage.getAddress()?.countryId,
      if (LocalStorage.getAddress()?.cityId != null)
        'city_id': LocalStorage.getAddress()?.cityId,
    };
  }
}
