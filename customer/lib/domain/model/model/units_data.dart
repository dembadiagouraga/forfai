import 'translation_model.dart';

class UnitsData {
  int? id;
  bool? active;
  String? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  Translation? translation;

  UnitsData({
    this.id,
    this.active,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.translation,
  });

  UnitsData copyWith({
    int? id,
    bool? active,
    String? position,
    DateTime? createdAt,
    DateTime? updatedAt,
    Translation? translation,
  }) =>
      UnitsData(
        id: id ?? this.id,
        active: active ?? this.active,
        position: position ?? this.position,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        translation: translation ?? this.translation,
      );

  factory UnitsData.fromJson(Map<String, dynamic> json) => UnitsData(
    id: json["id"],
    active: json["active"],
    position: json["position"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]).toLocal(),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]).toLocal(),
    translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "position": position,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "translation": translation?.toJson(),
  };
}

