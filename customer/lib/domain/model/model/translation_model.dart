class Translation {
  int? id;
  String? locale;
  String? title;
  String? description;
  String? placeholder;
  String? shortDesc;

  Translation({
    this.id,
    this.locale,
    this.title,
    this.description,
    this.placeholder,
    this.shortDesc,
  });

  Translation copyWith({
    int? id,
    String? locale,
    String? title,
    String? description,
    String? placeholder,
    String? shortDesc,
  }) =>
      Translation(
        id: id ?? this.id,
        locale: locale ?? this.locale,
        title: title ?? this.title,
        description: description ?? this.description,
        placeholder: placeholder ?? this.placeholder,
      );

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    locale: json["locale"],
    title: json["title"],
    description: json["description"],
    placeholder: json["placeholder"],
      shortDesc : json['short_desc'] ?? json['faq']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "locale": locale,
    "title": title,
    "description": description,
    "placeholder": placeholder,
    "short_desc": shortDesc,
  };
}
