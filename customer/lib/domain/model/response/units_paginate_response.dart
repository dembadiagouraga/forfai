import '../model/units_data.dart';
import 'response.dart';

class UnitsPaginateResponse {
  List<UnitsData>? data;
  Links? links;
  Meta? meta;

  UnitsPaginateResponse({
    this.data,
    this.links,
    this.meta,
  });

  UnitsPaginateResponse copyWith({
    List<UnitsData>? data,
    Links? links,
    Meta? meta,
  }) =>
      UnitsPaginateResponse(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory UnitsPaginateResponse.fromJson(Map<String, dynamic> json) => UnitsPaginateResponse(
    data: json["data"] == null ? [] : List<UnitsData>.from(json["data"]!.map((x) => UnitsData.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}



