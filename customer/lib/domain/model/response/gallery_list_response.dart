
class GalleryListUploadResponse {
  DateTime? timestamp;
  bool? status;
  String? message;
  GalleryData? data;

  GalleryListUploadResponse({
    this.timestamp,
    this.status,
    this.message,
    this.data,
  });

  GalleryListUploadResponse copyWith({
    DateTime? timestamp,
    bool? status,
    String? message,
    GalleryData? data,
  }) =>
      GalleryListUploadResponse(
        timestamp: timestamp ?? this.timestamp,
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GalleryListUploadResponse.fromJson(Map<String, dynamic> json) => GalleryListUploadResponse(
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : GalleryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class GalleryData {
  List<String>? title;
  String? type;

  GalleryData({
    this.title,
    this.type,
  });

  GalleryData copyWith({
    List<String>? title,
    String? type,
  }) =>
      GalleryData(
        title: title ?? this.title,
        type: type ?? this.type,
      );

  factory GalleryData.fromJson(Map<String, dynamic> json) => GalleryData(
    title: json["title"] == null ? [] : List<String>.from(json["title"]!.map((x) => x)),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? [] : List<dynamic>.from(title!.map((x) => x)),
    "type": type,
  };
}
