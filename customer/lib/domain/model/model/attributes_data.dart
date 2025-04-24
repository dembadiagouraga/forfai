import 'package:quick/domain/model/request/selected_request.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'category_model.dart';
import 'translation_model.dart';

class AttributesData {
  int? id;
  String? type;
  int? categoryId;
  bool? required;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Attributes>? values;
  CategoryData? category;
  Translation? translation;
  List<Translation>? translations;
  List<String>? locales;
  String? value;
  Attribute? attribute;
  AttributeValue? attributeValue;

  AttributesData({
    this.id,
    this.type,
    this.required,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.values,
    this.category,
    this.translation,
    this.translations,
    this.locales,
    this.value,
    this.attribute,
    this.attributeValue,
  });

  AttributesData copyWith({
    int? id,
    String? type,
    bool? required,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Attributes>? values,
    CategoryData? category,
    Translation? translation,
    List<Translation>? translations,
    List<String>? locales,
    String? value,
    Attribute? attribute,
    AttributeValue? attributeValue,
  }) =>
      AttributesData(
        id: id ?? this.id,
        type: type ?? this.type,
        required: required ?? this.required,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        values: values ?? this.values,
        category: category ?? this.category,
        translation: translation ?? this.translation,
        translations: translations ?? this.translations,
        locales: locales ?? this.locales,
        value: value ?? this.value,
        attribute: attribute ?? this.attribute,
        attributeValue: attributeValue ?? this.attributeValue,
      );

  factory AttributesData.fromJson(Map<String, dynamic> json) => AttributesData(
        id: json["id"] ?? json["attribute_id"] ,
        type: json["type"],
        required: json["required"].toString().toBool(),
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        values: json["values"] == null
            ? []
            : List<Attributes>.from(
                json["values"]!.map((x) => Attributes.fromJson(x))),
        category: json["category"] == null
            ? null
            : CategoryData.fromJson(json["category"]),
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
        translations: json["translations"] == null
            ? []
            : List<Translation>.from(
                json["translations"]!.map((x) => Translation.fromJson(x))),
        locales: json["locales"] == null
            ? []
            : List<String>.from(json["locales"]!.map((x) => x)),
    value: json["value"],
    attribute: json["attribute"] == null ? null : Attribute.fromJson(json["attribute"]),
    attributeValue: json["attribute_value"] == null ? null : AttributeValue.fromJson(json["attribute_value"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "required": required,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
        "category": category?.toJson(),
        "translation": translation?.toJson(),
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "locales":
            locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
    "value": value,
    "attribute": attribute?.toJson(),
    "attribute_value": attributeValue?.toJson(),
      };

  SelectedAttribute toSelectedAttribute() => SelectedAttribute(
        attributeId: id,
        type: type,
        title: translation?.title,
        values:
            type == 'checkbox' ? values?.map((e) => e.id ?? 0).toList() : [],
        valueId: type != 'checkbox' && type != 'input'
            ? values?.map((e) => e.attributeValueId ?? 0).toList().first
            : null,
        attributeValue: type != 'checkbox' && type != 'input'
            ? values
                ?.map((e) => e.attributeValue ?? AttributeValue())
                .toList()
                .first
            : null,
        value: type == 'input'
            ? values?.map((e) => e.value ?? '').toList().first
            : null,
      );
}

class Attributes {
  int? id;
  Translation? translation;
  List<Translation>? translations;
  List<String>? locales;
  int? attributeValueId;
  AttributeValue? attributeValue;
  String? value;

  Attributes({
    this.id,
    this.translation,
    this.translations,
    this.locales,
    this.attributeValueId,
    this.attributeValue,
    this.value,
  });

  Attributes copyWith({
    int? id,
    Translation? translation,
    List<Translation>? translations,
    List<String>? locales,
  }) =>
      Attributes(
        id: id ?? this.id,
        translation: translation ?? this.translation,
        translations: translations ?? this.translations,
        locales: locales ?? this.locales,
      );

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id: json["id"],
        attributeValueId: json["attribute_value_id"],
        value: json["value"],
        attributeValue: json["attribute_value"] == null
            ? null
            : AttributeValue.fromJson(json["attribute_value"]),
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
        translations: json["translations"] == null
            ? []
            : List<Translation>.from(
                json["translations"]!.map((x) => Translation.fromJson(x))),
        locales: json["locales"] == null
            ? []
            : List<String>.from(json["locales"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "attribute_value_id": attributeValueId,
        "translation": translation?.toJson(),
        "attribute_value": attributeValue?.toJson(),
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "locales":
            locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
      };
}

class AttributeValue {
  int? id;
  int? attributeId;
  Translation? translation;

  AttributeValue({
    this.id,
    this.attributeId,
    this.translation,
  });

  AttributeValue copyWith({
    int? id,
    int? attributeId,
    Translation? translation,
  }) =>
      AttributeValue(
        id: id ?? this.id,
        attributeId: attributeId ?? this.attributeId,
        translation: translation ?? this.translation,
      );

  factory AttributeValue.fromJson(Map<String, dynamic> json) => AttributeValue(
        id: json["id"],
        attributeId: json["attribute_id"],
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attribute_id": attributeId,
        "translation": translation?.toJson(),
      };
}
class Attribute {
  int? id;
  String? type;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? required;
  Translation? translation;

  Attribute({
    this.id,
    this.type,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.required,
    this.translation,
  });

  Attribute copyWith({
    int? id,
    String? type,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? required,
    Translation? translation,
  }) =>
      Attribute(
        id: id ?? this.id,
        type: type ?? this.type,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        required: required ?? this.required,
        translation: translation ?? this.translation,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    type: json["type"],
    categoryId: json["category_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    required: json["required"],
    translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "category_id": categoryId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "required": required,
    "translation": translation?.toJson(),
  };
}
