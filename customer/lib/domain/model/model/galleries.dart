class Galleries {
  Galleries({
    int? id,
    String? title,
    String? type,
    int? loadableId,
    String? path,
    String? preview,
    String? basePath,
  }) {
    _id = id;
    _title = title;
    _type = type;
    _loadableId = loadableId;
    _path = path;
    _preview = preview;
    _basePath = basePath;
  }

  Galleries.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _type = json['type'];
    _loadableId = json['loadable_id'];
    _path = json['path'];
    _preview = json['preview'];
    _basePath = json['base_path'];
  }

  int? _id;
  String? _title;
  String? _type;
  int? _loadableId;
  String? _path;
  String? _preview;
  String? _basePath;

  Galleries copyWith({
    int? id,
    String? title,
    String? type,
    int? loadableId,
    String? path,
    String? preview,
    String? basePath,
  }) =>
      Galleries(
        id: id ?? _id,
        title: title ?? _title,
        type: type ?? _type,
        loadableId: loadableId ?? _loadableId,
        path: path ?? _path,
        preview: preview ?? _preview,
        basePath: basePath ?? _basePath,
      );

  int? get id => _id;

  String? get title => _title;

  String? get type => _type;

  int? get loadableId => _loadableId;

  String? get path {
    // Fix double storage issue
    if (_path == null) return null;

    String fixedPath = _path!;

    // Fix host issues - replace 127.0.0.1 with the correct IP
    if (fixedPath.contains('127.0.0.1')) {
      fixedPath = fixedPath.replaceAll('127.0.0.1', '192.168.0.107');
    }

    // Fix double storage path issue
    if (fixedPath.contains('/storage/storage/')) {
      fixedPath = fixedPath.replaceAll('/storage/storage/', '/storage/');
    }

    // Fix double slash issue
    if (fixedPath.contains('//storage/')) {
      fixedPath = fixedPath.replaceAll('//storage/', '/storage/');
    }

    return fixedPath;
  }

  String? get preview {
    // Fix double storage issue
    if (_preview == null) return null;

    String fixedPreview = _preview!;

    // Fix host issues - replace 127.0.0.1 with the correct IP
    if (fixedPreview.contains('127.0.0.1')) {
      fixedPreview = fixedPreview.replaceAll('127.0.0.1', '192.168.0.107');
    }

    // Fix double storage path issue
    if (fixedPreview.contains('/storage/storage/')) {
      fixedPreview = fixedPreview.replaceAll('/storage/storage/', '/storage/');
    }

    // Fix double slash issue
    if (fixedPreview.contains('//storage/')) {
      fixedPreview = fixedPreview.replaceAll('//storage/', '/storage/');
    }

    return fixedPreview;
  }

  String? get basePath => _basePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['type'] = _type;
    map['loadable_id'] = _loadableId;
    map['preview'] = _preview;
    map['base_path'] = _basePath;
    return map;
  }
}
