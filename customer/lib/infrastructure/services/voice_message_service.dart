import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quick/infrastructure/service/http_service.dart';
import 'package:quick/infrastructure/service/helper.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/infrastructure/service/tr_keys.dart';

class VoiceMessageService {
  final HttpService _httpService;

  VoiceMessageService(this._httpService);

  /// Upload voice message to AWS S3 via backend API
  Future<Either<Map<String, dynamic>, String>> uploadVoiceMessage({
    required String audioPath,
    required String chatId,
    required int duration,
  }) async {
    try {
      debugPrint('Uploading voice message to AWS S3: $audioPath');

      // Check if file exists
      final file = File(audioPath);
      if (!await file.exists()) {
        return right(AppHelpers.getTranslation(TrKeys.audioFileNotFound));
      }

      // Create form data
      final formData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(audioPath),
        'chat_id': chatId,
        'duration': duration.toString(),
      });

      // Add auth token
      final token = LocalStorage.getToken();
      final headers = {'Authorization': 'Bearer $token'};

      // Make API request
      final client = _httpService.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/chat/voice-message',
        data: formData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        debugPrint('Voice message uploaded successfully: ${data['url']}');
        return left(data);
      } else {
        debugPrint('Error uploading voice message: ${response.statusMessage}');
        return right(response.statusMessage ?? 'Unknown error');
      }
    } catch (e) {
      debugPrint('Exception uploading voice message: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }
}
