import 'package:remixicon/remixicon.dart';
import 'infrastructure/service/enums.dart';

abstract class AppConstants {
  AppConstants._();

  static const bool isDemo = false;

  // If this is true, it will fix the words that are not included in the translation from the General setting.
  static const bool autoTrn = true;

  // If you set this to false, AI integration will not work in the app. If true, the AI worked
  static const bool activeAi = true;
  // Upgrader
  static const bool showLater = true;
  static const bool showIgnore = false;

  static const SignUpType signUpType = SignUpType.email;
  static const bool isPhoneFirebase = false;
  /// api urls
  static const String baseUrl = "http://192.168.0.107:8000";
  static const String webUrl = "http://192.168.0.107:3000";
  static const String adminPageUrl = "http://192.168.0.107:3001";
  static const String imageUrl = "$baseUrl/storage/"; // Image base URL - must match backend's IMG_HOST
  static const String googleApiKey = "YOUR_GOOGLE_MAPS_API_KEY";
  static const String firebaseWebKey = "AIzaSyAR2vkM7_yt9MQTEIOM5dOAfXQd03OHfHg";
  static const String geminiKey = "AIzaSyBTt9nXRIkkP093cPSbFMeA-G2Ou5QctVA";
  static const String urlPrefix = "";
  static const String routingBaseUrl = "http://192.168.0.107:8000";
  static const String routingKey = "";

  /// auth phone fields
  static const bool isNumberLengthAlwaysSame = true;
  static const String countryCodeISO = 'UZ';
  static const bool showFlag = true;
  static const bool showArrowIcon = true;

  static const double radius = 12;

  /// social sign-in
  static const socialSignIn = [
    Remix.google_fill,
    // Remix.facebook_fill,  // comment out
    // Remix.apple_fill,     // comment out
  ];

  static const filterLayouts = [
    LayoutType.twoH,
    // LayoutType.three,
    LayoutType.twoV,
    LayoutType.one,
    // LayoutType.newUi,
  ];

  /// location
  static const double demoLatitude = 41.304223;
  static const double demoLongitude = 69.2348277;
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  ///refresh duration
  static const Duration timeRefresh = Duration(seconds: 30);

  ///image
  static const String darkBgChat = "assets/images/darkBg.jpeg";
  static const String lightBgChat = "assets/images/lightBg.jpeg";

  static const String newOrder = 'new_order';
  static const String newUserByReferral = 'new_user_by_referral';
  static const String statusChanged = 'status_changed';
  static const String newsPublish = 'news_publish';
  static const String addCashback = 'add_cashback';
  static const String shopApproved = 'shop_approved';
  static const String walletTopUp = 'wallet_top_up';

  static const List imageTypes = [
    '.png',
    '.jpg',
    '.jpeg',
    '.webp',
    '.svg',
    '.jfif',
    '.gif',
  ];

  static const List videoTypes = [
    '.mp4',
    '.mov',
    '.avi',
    '.mkv',
    '.webm',
  ];
  static const List<String> productTypes = [
    'private',
    'business',
  ];
  static const List<String> conditions = [
    'used',
    'new',
  ];
}

