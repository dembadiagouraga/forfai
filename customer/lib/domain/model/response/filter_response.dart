class FilterResponse {
  List<Brand>? brands;
  List<Brand>? categories;
  List<Attribute>? attributes;
  Price? price;
  int? count;

  FilterResponse({
    this.brands,
    this.categories,
    this.attributes,
    this.price,
    this.count,
  });

  FilterResponse copyWith({
    List<Brand>? brands,
    List<Brand>? categories,
    List<Attribute>? attributes,
    Price? price,
    int? count,
  }) =>
      FilterResponse(
        brands: brands ?? this.brands,
        categories: categories ?? this.categories,
        attributes: attributes ?? this.attributes,
        price: price ?? this.price,
        count: count ?? this.count,
      );

  factory FilterResponse.fromJson(Map<String, dynamic> json) => FilterResponse(
        brands: json["brands"] == null
            ? []
            : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<Brand>.from(
                json["categories"]!.map((x) => Brand.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "brands": brands == null
            ? []
            : List<dynamic>.from(brands!.map((x) => x.toJson())),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "price": price?.toJson(),
        "count": count,
      };
}

class Brand {
  int? id;
  String? title;
  String? image;

  Brand({
    this.id,
    this.title,
    this.image,
  });

  Brand copyWith({
    int? id,
    String? title,
    String? image,
  }) =>
      Brand(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"],
        image: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": image,
      };
}

class Attribute {
  int? id;
  String? title;
  List<Value>? values;

  Attribute({
    this.id,
    this.title,
    this.values,
  });

  Attribute copyWith({
    int? id,
    String? title,
    List<Value>? values,
  }) =>
      Attribute(
        id: id ?? this.id,
        title: title ?? this.title,
        values: values ?? this.values,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        title: json["title"],
        values: json["values"] == null
            ? []
            : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class Value {
  int? valueId;
  String? value;
  String? title;

  Value({
    this.valueId,
    this.value,
    this.title,
  });

  Value copyWith({
    int? valueId,
    String? value,
    String? title,
  }) =>
      Value(
        valueId: valueId ?? this.valueId,
        value: value ?? this.value,
        title: title ?? this.title,
      );

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        valueId: json["value_id"],
        value: json["value"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        if (valueId != null) "value_id": valueId,
        if (value != null) "value": value,
      };
}

class Price {
  num? min;
  num? max;

  Price({
    this.min,
    this.max,
  });

  Price copyWith({
    num? min,
    num? max,
  }) =>
      Price(
        min: min ?? this.min,
        max: max ?? this.max,
      );

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}
