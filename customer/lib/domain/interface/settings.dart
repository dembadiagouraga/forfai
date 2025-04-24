import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';

abstract class SettingsInterface {

  Future<Either<GlobalSettingsResponse,dynamic>> getGlobalSettings();

  Future<Either<MobileTranslationsResponse,dynamic>> getMobileTranslations({String? lang});

  Future<Either<LanguagesResponse,dynamic>> getLanguages();

  Future<Either<CurrenciesResponse,dynamic>> getCurrencies();

  Future<Either<HelpResponseModel,dynamic>> getFaq();

  Future<Either<bool,dynamic>> getAdminInfo();

  Future<Either<Translation,dynamic>> getPolicy();

  Future<Either<Translation,dynamic>> getTerm();
}
