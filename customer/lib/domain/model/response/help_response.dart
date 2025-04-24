class HelpResponseModel {
  HelpResponseModel({
    this.data,
  });

  List<HelpModel>? data;


  factory HelpResponseModel.fromJson(Map<String, dynamic> json) => HelpResponseModel(
        data: List<HelpModel>.from(json["data"].map((x) => HelpModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),

      };
}

class HelpModel {
  HelpModel({
    this.id,
    this.uuid,
    this.type,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.translation,
    this.locales,
  });

  int? id;
  String? uuid;
  String? type;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  TranslationHelp? translation;
  List<String>? locales;

  factory HelpModel.fromJson(Map<String, dynamic> json) => HelpModel(
        id: json["id"],
        uuid: json["slug"],
        type: json["type"],
        active: json["active"],
        createdAt: DateTime.tryParse(json["created_at"])?.toLocal(),
        updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
        translation: json["translation"] != null
            ? TranslationHelp.fromJson(json["translation"])
            : null,
    
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "type": type,
        "active": active,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "translation": translation?.toJson(),
        "locales": List<dynamic>.from(locales!.map((x) => x)),
      };
}

class TranslationHelp {
  TranslationHelp({
    this.id,
    this.locale,
    this.question,
    this.answer,
  });

  int? id;
  String? locale;
  String? question;
  String? answer;

  factory TranslationHelp.fromJson(Map<String, dynamic> json) => TranslationHelp(
        id: json["id"],
        locale: json["locale"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locale": locale,
        "question": question,
        "answer": answer,
      };
}
