import '../model/area_model.dart';
import '../model/translation_model.dart';
import 'response.dart';

class CityResponseModel {
  List<CityModel>? data;
  Links? links;
  Meta? meta;

  CityResponseModel({
    this.data,
    this.links,
    this.meta,
  });

  CityResponseModel copyWith({
    List<CityModel>? data,
    Links? links,
    Meta? meta,
  }) =>
      CityResponseModel(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory CityResponseModel.fromJson(Map<String, dynamic> json) =>
      CityResponseModel(
        data: json["data"] == null
            ? []
            : List<CityModel>.from(
                json["data"]!.map((x) => CityModel.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

class CityModel {
  int? id;
  bool? active;
  int? regionId;
  int? countryId;
  AreaModel? areaModel;
  Translation? translation;

  CityModel({
    this.id,
    this.active,
    this.regionId,
    this.countryId,
    this.translation,
    this.areaModel,
  });

  CityModel copyWith({
    int? id,
    bool? active,
    int? regionId,
    int? countryId,
    AreaModel? areaModel,
    Translation? translation,
  }) =>
      CityModel(
        id: id ?? this.id,
        active: active ?? this.active,
        regionId: regionId ?? this.regionId,
        countryId: countryId ?? this.countryId,
        areaModel: areaModel ?? this.areaModel,
        translation: translation ?? this.translation,
      );

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        active: json["active"],
        regionId: json["region_id"],
        countryId: json["country_id"],
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
        areaModel:
            json["area"] == null ? null : AreaModel.fromJson(json["area"]),
      );

  factory CityModel.fromAddress(Map<String, dynamic>? json) {
    if (json == null) {
      return CityModel();
    }
    return CityModel(
      id: json["city_id"],
      regionId: json["region_id"],
      countryId: json["country_id"],
      translation: json["city"] == null
          ? null
          : Translation(title: json["city"]),
    );

  }


  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "region_id": regionId,
        "country_id": countryId,
        "area": areaModel?.toJson(),
        "translation": translation?.toJson(),
      };
}
