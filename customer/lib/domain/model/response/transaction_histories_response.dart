import 'package:quick/domain/model/model/user_model.dart';
import 'package:quick/domain/model/response/transactions_response.dart';

class TransactionPaginationResponse {
  TransactionPaginationResponse({
    List<TransactionModel>? data,
  }) {
    _data = data;
  }

  TransactionPaginationResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TransactionModel.fromJson(v));
      });
    }
  }

  List<TransactionModel>? _data;

  TransactionPaginationResponse copyWith({
    List<TransactionModel>? data,
  }) =>
      TransactionPaginationResponse(
        data: data ?? _data,
      );

  List<TransactionModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

class TransactionModel {
  TransactionModel(
      {int? id,
      String? uuid,
      String? walletUuid,
      int? transactionId,
      String? type,
      num? price,
      String? note,
      String? status,
      String? statusDescription,
      DateTime? createdAt,
      DateTime? updatedAt,
      UserModel? author,
      UserModel? user,
      TransactionData? transactionData,
      PaymentSystem? paymentSystem}) {
    _id = id;
    _uuid = uuid;
    _walletUuid = walletUuid;
    _transactionId = transactionId;
    _type = type;
    _price = price;
    _note = note;
    _status = status;
    _statusDescription = statusDescription;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _author = author;
    _user = user;
    _transactionData = transactionData;
    _paymentSystem = paymentSystem;
  }

  TransactionModel.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _walletUuid = json['wallet_uuid'];
    _transactionId = json['transaction_id'];
    _type = json['type'];
    _price = json['price'];
    _note = json['note'];
    _status = json['status'];
    _statusDescription = json['status_description'];
    _createdAt = json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"])?.toLocal();
    _updatedAt = json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"])?.toLocal();
    _author =
        json['author'] != null ? UserModel.fromJson(json['author']) : null;
    _user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    _paymentSystem = json['payment_system'] != null
        ? PaymentSystem.fromJson(json['payment_system'])
        : null;

    _transactionData = json['transaction'] != null
        ? TransactionData.fromJson(json['transaction'])
        : null;
  }

  int? _id;
  String? _uuid;
  String? _walletUuid;
  int? _transactionId;
  String? _type;
  num? _price;
  String? _note;
  String? _status;
  String? _statusDescription;
  DateTime? _createdAt;
  DateTime? _updatedAt;
  UserModel? _author;
  UserModel? _user;
  TransactionData? _transactionData;
  PaymentSystem? _paymentSystem;

  TransactionModel copyWith({
    int? id,
    String? uuid,
    String? walletUuid,
    int? transactionId,
    String? type,
    num? price,
    String? note,
    String? status,
    String? statusDescription,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? author,
    UserModel? user,
    TransactionData? transactionData,
  }) =>
      TransactionModel(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        walletUuid: walletUuid ?? _walletUuid,
        transactionId: transactionId ?? _transactionId,
        type: type ?? _type,
        price: price ?? _price,
        note: note ?? _note,
        status: status ?? _status,
        statusDescription: statusDescription ?? _statusDescription,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        author: author ?? _author,
        user: user ?? _user,
        transactionData: transactionData ?? _transactionData,
        paymentSystem: paymentSystem ?? _paymentSystem,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get walletUuid => _walletUuid;

  int? get transactionId => _transactionId;

  String? get type => _type;

  num? get price => _price;

  String? get note => _note;

  String? get status => _status;

  String? get statusDescription => _statusDescription;

  DateTime? get createdAt => _createdAt;

  DateTime? get updatedAt => _updatedAt;

  UserModel? get author => _author;

  UserModel? get user => _user;

  TransactionData? get transactionData => _transactionData;

  PaymentSystem? get paymentSystem => _paymentSystem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['wallet_uuid'] = _walletUuid;
    map['transaction_id'] = _transactionId;
    map['type'] = _type;
    map['price'] = _price;
    map['note'] = _note;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_author != null) {
      map['author'] = _author?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_paymentSystem != null) {
      map['payment_system'] = _paymentSystem?.toJson();
    }
    return map;
  }
}

class PaymentSystem {
  int? id;
  String? tag;
  int? input;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentSystem({
    this.id,
    this.tag,
    this.input,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  PaymentSystem copyWith({
    int? id,
    String? tag,
    int? input,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PaymentSystem(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        input: input ?? this.input,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PaymentSystem.fromJson(Map<String, dynamic> json) => PaymentSystem(
        id: json["id"],
        tag: json["tag"],
        input: json["input"],
        active: json["active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
        "input": input,
        "active": active,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
