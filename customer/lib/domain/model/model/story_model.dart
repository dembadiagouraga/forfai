import 'dart:convert';

List<List<StoryModel?>?>? storyModelFromJson(dynamic str) => str == null
    ? []
    : List<List<StoryModel?>?>.from(str.map((x) => x == null
        ? []
        : List<StoryModel?>.from(x!.map((x) => StoryModel.fromJson(x)))));

String storyModelToJson(List<List<StoryModel?>?>? data) =>
    json.encode(data == null
        ? []
        : List<dynamic>.from(data.map((x) =>
            x == null ? [] : List<dynamic>.from(x.map((x) => x!.toJson())))));

class StoryModel {
  StoryModel({
    this.userId,
    this.logoImg,
    this.title,
    this.productTitle,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  int? userId;
  String? logoImg;
  String? title;
  String? productTitle;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      userId: json["user_id"],
      logoImg: json["logo_img"],
      title: json["title"],
      productTitle: json["product_title"],
      url: json["url"],
      createdAt: DateTime.tryParse(json["created_at"])?.toLocal(),
      updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "logo_img": logoImg,
        "title": title,
        "product_title": productTitle,
        "url": url,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
