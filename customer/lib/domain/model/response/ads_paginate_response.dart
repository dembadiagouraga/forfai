import '../model/ad_model.dart';
import 'response.dart';

class AdsPaginateResponse {
  List<AdModel>? data;
  Links? links;
  Meta? meta;

  AdsPaginateResponse({
    this.data,
    this.links,
    this.meta,
  });

  AdsPaginateResponse copyWith({
    List<AdModel>? data,
    Links? links,
    Meta? meta,
  }) =>
      AdsPaginateResponse(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory AdsPaginateResponse.fromJson(Map<String, dynamic> json) =>
      AdsPaginateResponse(
        data: json["data"] == null ? [] : List<AdModel>.from(
            json["data"]!.map((x) => AdModel.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "data": data == null ? [] : List<dynamic>.from(
            data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}




