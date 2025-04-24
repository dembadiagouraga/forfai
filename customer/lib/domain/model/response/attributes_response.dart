import '../model/attributes_data.dart';

class AttributesResponse {
  List<AttributesData>? data;

  AttributesResponse({this.data});

  factory AttributesResponse.fromJson(Map<String, dynamic> json) =>
      AttributesResponse(
        data: json["data"] == null
            ? []
            : List<AttributesData>.from(
                json["data"]!.map((x) => AttributesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
