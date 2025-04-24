import 'package:quick/domain/model/model/attributes_data.dart';

class SelectedAttribute {
  int? attributeId;
  int? valueId;
  String? value;
  String? type;
  String? title;
  AttributeValue? attributeValue;
  List<int>? values;

  SelectedAttribute({
    this.attributeId,
    this.valueId,
    this.value,
    this.type,
    this.title,
    this.values,
    this.attributeValue,
  });

  SelectedAttribute copyWith({
    int? attributeId,
    int? valueId,
    String? value,
    String? type,
    String? title,
    List<int>? values,
  }) =>
      SelectedAttribute(
        attributeId: attributeId ?? this.attributeId,
        valueId: valueId ?? this.valueId,
        value: value ?? this.value,
        type: type ?? this.type,
        title: title ?? this.title,
        values: values ?? this.values,
      );

  factory SelectedAttribute.fromJson(Map<String, dynamic> json) =>
      SelectedAttribute(
        attributeId: json["attribute_id"],
        valueId: json["value_id"],
        value: json["value"],
        title: json["title"],
        values: json["values"] == null
            ? []
            : List<int>.from(json["values"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "attribute_id": attributeId,
        if (type == 'radio' || type == 'drop_down') "value_id": valueId,
        if (type == 'input') "value": value,
        if (type == 'checkbox')
          "values":
              values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
      };
}
