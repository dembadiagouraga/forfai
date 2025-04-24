import '../model/category_model.dart';

class FullProductsResponse {
  DateTime? timestamp;
  bool? status;
  String? message;
  List<CategoryData>? data;

  FullProductsResponse({
    this.timestamp,
    this.status,
    this.message,
    this.data,
  });

  FullProductsResponse copyWith({
    DateTime? timestamp,
    bool? status,
    String? message,
    List<CategoryData>? data,
  }) =>
      FullProductsResponse(
        timestamp: timestamp ?? this.timestamp,
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory FullProductsResponse.fromJson(Map<String, dynamic> json) =>
      FullProductsResponse(
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        data: json["data"]["all"] == null
            ? []
            : List<CategoryData>.from(
                json["data"]["all"]!.map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp?.toIso8601String(),
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

