import 'package:flutter/foundation.dart';

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
  final String? audioDuration; // Duration of voice message in seconds (customer app format)
  final dynamic duration; // Duration of voice message in seconds (admin app format)
  final bool? isUploading; // Flag to indicate if voice message is uploading
  final bool? isLocalVoiceMessage; // Flag to indicate if this is a local voice message before upload
  final String? localAudioPath; // Local audio file path before upload

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
      this.duration,
      this.isUploading = false,
      this.isLocalVoiceMessage = false,
      this.localAudioPath,
      required this.doc});

  factory MessageModel.fromJson(Map? message, String doc) {
    // Special handling for voice messages
    String? mediaUrl = message?["media"];
    String? messageType = message?["type"];
    String? audioDurationStr = message?["audioDuration"];

    // For voice messages, the URL might be in different fields depending on the sender
    if (messageType == "voice") {
      // For admin messages (senderId = 103 or any admin ID), the URL is in the message field
      // Check if message field contains a URL (admin messages store URL in message field)
      final msgStr = message?["message"]?.toString() ?? "";
      if (msgStr.startsWith('http') && message?["message"] != null) {
        // Use message field as media URL for admin messages
        mediaUrl = message?["message"];

        // For admin messages, if duration field exists but audioDuration doesn't, convert duration to audioDuration
        if (audioDurationStr == null && message?["duration"] != null) {
          // Get the duration value
          dynamic durationValue = message?["duration"];

          // Use the actual duration value from admin messages
          // Don't enforce a minimum of 10 seconds as this causes display issues
          audioDurationStr = durationValue.toString();
          debugPrint('Admin voice message using ACTUAL duration: $audioDurationStr from senderId: ${message?["senderId"]}');
        }
      }
      // If we still don't have a URL, try to extract it from the message field
      else if (mediaUrl == null && message?["message"] != null) {
        // Try to extract URL using regex
        final urlRegex = RegExp(r'https?://[^\s]+');
        final msgStr = message?["message"]?.toString() ?? "";
        final match = urlRegex.firstMatch(msgStr);
        if (match != null) {
          mediaUrl = match.group(0);
        }
      }
    }

    return MessageModel(
        message: message?["message"],
        time: DateTime.tryParse(message?["time"])?.toLocal(),
        read: message?["read"],
        product: message?["product"] == null
            ? null
            : Product.fromJson(message?["product"]),
        senderId: message?["senderId"],
        media: mediaUrl,
        type: messageType,
        replyDocId: message?["replyDocId"],
        audioDuration: audioDurationStr, // Use our processed audioDuration string
        duration: message?["duration"], // Keep original duration field
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
      if (duration != null) "duration": duration, // Include duration field
      "doc": doc, // Include document ID for debugging
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
