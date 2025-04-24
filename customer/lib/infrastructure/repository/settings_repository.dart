import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/interface/settings.dart';
import 'package:quick/domain/model/models.dart';

import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/service/http_service.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

class SettingsRepository implements SettingsInterface {
  @override
  Future<Either<GlobalSettingsResponse, dynamic>> getGlobalSettings() async {
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/settings');
      LocalStorage.setSettingsList(
          GlobalSettingsResponse.fromJson(response.data).data ?? []);
      return left(GlobalSettingsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get settings failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<MobileTranslationsResponse, dynamic>> getMobileTranslations(
      {String? lang}) async {
    final data = {'lang': lang ?? LocalStorage.getLanguage()?.locale ?? 'en'};
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/translations/paginate',
        queryParameters: data,
      );
      await LocalStorage.setTranslations(
          MobileTranslationsResponse.fromJson(response.data).data);
      return left(MobileTranslationsResponse.fromJson(response.data));
    } catch (e, s) {
      debugPrint('==> get translations failure: $e,$s');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<LanguagesResponse, dynamic>> getLanguages(
      {bool arg = false}) async {
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('http://192.168.0.107:8000/api/v1/rest/languages/active');

      if (LocalStorage.getLanguage() == null ||
          !(LanguagesResponse.fromJson(response.data)
                  .data
                  ?.map((e) => e.id)
                  .contains(LocalStorage.getLanguage()?.id) ??
              true)) {
        LanguagesResponse.fromJson(response.data).data?.forEach((element) {
          if (element.isDefault ?? false) {
            LocalStorage.setLanguageData(element);
          }
        });
      }

      return left(LanguagesResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get languages failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<CurrenciesResponse, dynamic>> getCurrencies() async {
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/currencies/active');
      if (LocalStorage.getSelectedCurrency() == null ||
          !(CurrenciesResponse.fromJson(response.data)
                  .data
                  ?.map((e) => e.id)
                  .contains(LocalStorage.getSelectedCurrency()?.id) ??
              true)) {
        CurrenciesResponse.fromJson(response.data).data?.forEach((element) {
          if (element.isDefault ?? false) {
            LocalStorage.setSelectedCurrency(element);
          }
        });
      }
      return left(CurrenciesResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get currencies failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<HelpResponseModel, dynamic>> getFaq() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response =
          await client.get('/api/v1/rest/faqs/paginate', queryParameters: {
        "lang": LocalStorage.getLanguage()?.locale,
      });

      return left(HelpResponseModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get helps failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<bool, dynamic>> getAdminInfo() async {
    try {
      final client =
          dioHttp.client(requireAuth: LocalStorage.getToken().isNotEmpty);
      final res = await client.get('/api/v1/dashboard/user/admin-info');
      LocalStorage.setAdmin(UserModel.fromJson(res.data["data"]));
      return left(true);
    } catch (e) {
      debugPrint('==> get helps failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<Translation, dynamic>> getPolicy() async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final res = await client.get('/api/v1/rest/policy');

      return left(Translation.fromJson(res.data["data"]["translation"]));
    } catch (e) {
      debugPrint('==> get policy failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<Either<Translation, dynamic>> getTerm() async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final res = await client.get('/api/v1/rest/term');

      return left(Translation.fromJson(res.data["data"]["translation"]));
    } catch (e) {
      debugPrint('==> get term failure: $e');
      return right(AppHelpers.errorHandler(e));
    }
  }
}
