import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:quick/infrastructure/local_storage/local_storage.dart';

abstract class GeminiService {
  GeminiService._();

  static final gemini = Gemini.instance;

  static const imageDescribePrompt =
      "I want to sell the ones in this picture. You write me a better description";
  static const imageTitlePrompt =
      "I want to sell the ones in this picture. You write me a better short title";
  static const imageCategoryPrompt =
      "I have Transportation, Reality , Animals category. Which category in the picture best fits.Return only that category to me";

  static Future<Either<String, dynamic>> imageToDesc({
    required List<String> images,
    List<String>? networkImages,
  }) async {
    final language = " in ${LocalStorage.getLanguage()?.title} language. ";
    const size = "Do not exceed 300 symbols";
    try {
      final List<Uint8List> list = [];
      for (int i = 0; i < (networkImages?.length ?? 0); i++) {
        final res = await getImageFromNetwork(networkImages![i]);
        list.add(res);
      }

      // Use the new prompt API
      final prompt = imageDescribePrompt + language + size;

      // Create parts list for the prompt
      final List<Part> parts = [];

      // Add text part
      parts.add(Part.text(prompt));

      // Add image parts
      for (final imagePath in images) {
        final bytes = File(imagePath).readAsBytesSync();
        parts.add(Part.bytes(bytes));
      }

      // Add network images
      for (final imageBytes in list) {
        parts.add(Part.bytes(imageBytes));
      }

      // Use the new API
      final res = await gemini.prompt(parts: parts);

      final responseText = res?.output ?? '';
      debugPrint('image to desc success ==> $responseText');
      return left(responseText);
    } catch (e) {
      debugPrint('image to desc error ==> $e');
      return right(e.toString());
    }
  }

  static Future<Uint8List> getImageFromNetwork(String imageUrl) async {
    final http.Response responseData = await http.get(Uri.parse(imageUrl));
    Uint8List imageBytes = responseData.bodyBytes;
    return imageBytes;
  }
}
