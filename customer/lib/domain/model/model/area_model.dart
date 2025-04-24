import 'translation_model.dart';

class AreaModel {
  int? id;
  bool? active;
  int? regionId;
  int? countryId;
  int? cityId;
  Translation? translation;

  AreaModel({
    this.id,
    this.active,
    this.regionId,
    this.countryId,
    this.cityId,
    this.translation,
  });

  AreaModel copyWith({
    int? id,
    bool? active,
    int? regionId,
    int? countryId,
    int? cityId,
    Translation? translation,
  }) =>
      AreaModel(
        id: id ?? this.id,
        active: active ?? this.active,
        regionId: regionId ?? this.regionId,
        countryId: countryId ?? this.countryId,
        cityId: cityId ?? this.cityId,
        translation: translation ?? this.translation,
      );

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        id: json["id"],
        active: json["active"],
        regionId: json["region_id"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "region_id": regionId,
        "country_id": countryId,
        "city_id": cityId,
        "translation": translation?.toJson(),
      };
}
