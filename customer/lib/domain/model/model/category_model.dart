import 'product_model.dart';
import 'translation_model.dart';

class CategoryData {
  CategoryData({
    int? id,
    String? uuid,
    String? keywords,
    int? parentId,
    String? type,
    String? img,
    bool? active,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
    List<CategoryData>? children,
    List<ProductData>? products,
  }) {
    _id = id;
    _uuid = uuid;
    _keywords = keywords;
    _parentId = parentId;
    _type = type;
    _img = img;
    _active = active;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
    _children = children;
    _products = products;
  }

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _keywords = json['keywords'];
    _parentId = json['parent_id'];
    _type = json['type'];
    _img = json['img'];
    _active = json['active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(CategoryData.fromJson(v));
      });
    }
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(ProductData.fromJson(v));
      });
    }
  }

  int? _id;
  String? _uuid;
  String? _keywords;
  int? _parentId;
  String? _type;
  String? _img;
  bool? _active;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;
  List<CategoryData>? _children;
  List<ProductData>? _products;

  CategoryData copyWith({
    int? id,
    String? uuid,
    String? keywords,
    int? parentId,
    String? type,
    String? img,
    bool? active,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
    List<CategoryData>? children,
    List<ProductData>? products,
  }) =>
      CategoryData(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        keywords: keywords ?? _keywords,
        parentId: parentId ?? _parentId,
        type: type ?? _type,
        img: img ?? _img,
        active: active ?? _active,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
        children: children ?? _children,
        products: products ?? _products,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get keywords => _keywords;

  int? get parentId => _parentId;

  String? get type => _type;

  String? get img => _img;

  bool? get active => _active;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  List<CategoryData>? get children => _children;

  List<ProductData>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['keywords'] = _keywords;
    map['parent_id'] = _parentId;
    map['type'] = _type;
    map['img'] = _img;
    map['active'] = _active;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }   if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
