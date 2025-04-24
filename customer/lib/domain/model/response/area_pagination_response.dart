import '../model/area_model.dart';
import 'response.dart';

class AreaResponseModel {
  List<AreaModel>? data;
  Links? links;
  Meta? meta;

  AreaResponseModel({
    this.data,
    this.links,
    this.meta,
  });

  AreaResponseModel copyWith({
    List<AreaModel>? data,
    Links? links,
    Meta? meta,
  }) =>
      AreaResponseModel(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory AreaResponseModel.fromJson(Map<String, dynamic> json) =>
      AreaResponseModel(
        data: json["data"] == null
            ? []
            : List<AreaModel>.from(
                json["data"]!.map((x) => AreaModel.fromJson(x))),
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
