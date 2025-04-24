class MessageModel {
  final String? message;
  final DateTime? time;
  final bool read;
  final int senderId;
  final String? media;
  final String? type; // Can be text, image, voice, etc.
  final String? replyDocId;
  final String? doc;
  final Product? product;
  final String? audioDuration; // Duration of voice message in seconds

  MessageModel(
      {required this.message,
      this.time,
      this.read = false,
      required this.senderId,
      this.media,
      this.product,
      this.type,
      this.replyDocId,
      this.audioDuration,
      required this.doc});

  factory MessageModel.fromJson(Map? message, String doc) {
    return MessageModel(
        message: message?["message"],
        time: DateTime.tryParse(message?["time"])?.toLocal(),
        read: message?["read"],
        product: message?["product"] == null
            ? null
            : Product.fromJson(message?["product"]),
        senderId: message?["senderId"],
        media: message?["media"],
        type: message?["type"],
        replyDocId: message?["replyDocId"],
        audioDuration: message?["audioDuration"],
        doc: doc);
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "message": message,
      "time": DateTime.now().toUtc().toString(),
      "read": read,
      "product": product?.toJson(),
      if (media != null) "media": media,
      if (type != null) "type": type,
      if (replyDocId != null) "replyDocId": replyDocId,
      if (audioDuration != null) "audioDuration": audioDuration,
    };
  }
}

class Product {
  int? id;
  String? title;
  String? img;
  String? slug;
  String? currency;
  double? price;

  Product({
    this.id,
    this.title,
    this.img,
    this.slug,
    this.price,
    this.currency,
  });

  Product copyWith({
    int? id,
    String? title,
    String? img,
    String? slug,
    String? currency,
    double? price,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        img: img ?? this.img,
        slug: slug ?? this.slug,
        currency: currency ?? this.currency,
        price: price ?? this.price,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        img: json["img"],
        slug: json["slug"],
        currency: json["currency"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": img,
        "currency": currency,
        "slug": slug,
        "price": price,
      };
}
