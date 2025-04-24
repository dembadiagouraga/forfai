
import '../model/galleries.dart';
import '../model/translation_model.dart';

class BannersPaginateResponse {
  BannersPaginateResponse({List<BannerData>? data}) {
    _data = data;
  }

  BannersPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BannerData.fromJson(v));
      });
    }
  }

  List<BannerData>? _data;

  BannersPaginateResponse copyWith({List<BannerData>? data}) =>
      BannersPaginateResponse(data: data ?? _data);

  List<BannerData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BannerData {
  BannerData({
    int? id,
    int? userId,
    String? img,
    List<Galleries>? galleries,
    bool? active,
    int? likes,
    int? productsCount,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) {
    _id = id;
    _userId = userId;
    _img = img;
    _galleries = galleries;
    _active = active;
    _likes = likes;
    _productsCount = productsCount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
  }

  BannerData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _img = json['img'];
    _active = json['active'].runtimeType == int
        ? json['active'] == 1
        : json['active'];
    _likes = json['likes'];
    _productsCount = json['products_count'];
    _galleries = json["galleries"] != null
        ? List<Galleries>.from(
            json["galleries"].map((x) => Galleries.fromJson(x)))
        : [];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  int? _userId;
  String? _img;
  List<Galleries>? _galleries;
  bool? _active;
  int? _likes;
  int? _productsCount;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;

  BannerData copyWith({
    int? id,
    int? userId,
    String? url,
    List<Galleries>? galleries,
    bool? active,
    int? likes,
    int? productsCount,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) =>
      BannerData(
        id: id ?? _id,
        userId: userId ?? _userId,
        img: url ?? _img,
        galleries: galleries ?? _galleries,
        active: active ?? _active,
        likes: likes ?? _likes,
        productsCount: productsCount ?? _productsCount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  int? get userId => _userId;

  String? get img => _img;

  List<Galleries>? get galleries => _galleries;

  bool? get active => _active;

  int? get likes => _likes;
  int? get productsCount => _productsCount;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['img'] = _img;
    map['active'] = _active;
    map['likes'] = _likes;
    map['products_count'] = _productsCount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_galleries != null) {
      map['galleries'] = _galleries?.map((v) => v.toJson()).toList();
    }
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}
