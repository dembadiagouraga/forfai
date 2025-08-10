import 'package:get_it/get_it.dart';
import 'package:quick/domain/interface/address.dart';
import 'package:quick/domain/interface/ads.dart';
import 'package:quick/domain/interface/auth.dart';
import 'package:quick/domain/interface/banner.dart';
import 'package:quick/domain/interface/blog.dart';
import 'package:quick/domain/interface/brands.dart';
import 'package:quick/domain/interface/category.dart';
import 'package:quick/domain/interface/chat.dart';
import 'package:quick/domain/interface/gallery.dart';
import 'package:quick/domain/interface/payments.dart';
import 'package:quick/domain/interface/products.dart';
import 'package:quick/domain/interface/review.dart';
import 'package:quick/domain/interface/settings.dart';
import 'package:quick/domain/interface/user.dart';
import 'package:quick/infrastructure/service/http_service.dart';
import 'package:quick/infrastructure/repository/address_repository.dart';
import 'package:quick/infrastructure/repository/ads_repository.dart';
import 'package:quick/infrastructure/repository/auth_repository.dart';
import 'package:quick/infrastructure/repository/banners_repository.dart';
import 'package:quick/infrastructure/repository/blogs_repository.dart';
import 'package:quick/infrastructure/repository/brands_repository.dart';
import 'package:quick/infrastructure/repository/categories_repository.dart';
import 'package:quick/infrastructure/repository/chat_repository.dart';
import 'package:quick/infrastructure/repository/gallery_repository.dart';
import 'package:quick/infrastructure/repository/payments_repository.dart';
import 'package:quick/infrastructure/repository/products_repository.dart';
import 'package:quick/infrastructure/repository/review_repository.dart';
import 'package:quick/infrastructure/repository/settings_repository.dart';
import 'package:quick/infrastructure/repository/user_repository.dart';
import 'package:quick/infrastructure/services/voice_message_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  getIt.registerSingleton<HttpService>(HttpService());
  getIt.registerLazySingleton<SettingsInterface>(() => SettingsRepository());
  getIt.registerLazySingleton<AuthInterface>(() => AuthRepository());
  getIt.registerLazySingleton<CategoryInterface>(() => CategoryRepository());
  getIt.registerLazySingleton<BannersInterface>(() => BannersRepository());
  getIt.registerLazySingleton<ProductsInterface>(() => ProductsRepository());
  getIt.registerLazySingleton<BlogInterface>(() => BlogsRepository());
  getIt.registerLazySingleton<BrandsInterface>(() => BrandsRepository());
  getIt.registerLazySingleton<GalleryInterface>(() => GalleryRepository());
  getIt.registerLazySingleton<UserInterface>(() => UserRepository());
  getIt.registerLazySingleton<ChatInterface>(() => ChatRepository());
  getIt.registerLazySingleton<AddressInterface>(() => AddressRepository());
  getIt.registerLazySingleton<AdsInterface>(() => AdsRepository());
  getIt.registerLazySingleton<PaymentsInterface>(() => PaymentsRepository());
  getIt.registerLazySingleton<ReviewInterface>(() => ReviewRepository());

  // Register services
  getIt.registerLazySingleton<VoiceMessageService>(
    () => VoiceMessageService(getIt.get<HttpService>())
  );
}

final settingsRepository = getIt.get<SettingsInterface>();
final dioHttp = getIt.get<HttpService>();
final adsRepository = getIt.get<AdsInterface>();
final authRepository = getIt.get<AuthInterface>();
final categoriesRepository = getIt.get<CategoryInterface>();
final bannersRepository = getIt.get<BannersInterface>();
final productsRepository = getIt.get<ProductsInterface>();
final blogsRepository = getIt.get<BlogInterface>();
final brandsRepository = getIt.get<BrandsInterface>();
final galleryRepository = getIt.get<GalleryInterface>();
final userRepository = getIt.get<UserInterface>();
final chatRepository = getIt.get<ChatInterface>();
final addressRepository = getIt.get<AddressInterface>();
final paymentsRepository = getIt.get<PaymentsInterface>();
final voiceMessageService = getIt.get<VoiceMessageService>();
final reviewRepository = getIt.get<ReviewInterface>();
