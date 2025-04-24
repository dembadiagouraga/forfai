import 'dart:convert';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/address_model.dart';
import 'package:quick/domain/model/model/currency_model.dart';
import 'package:quick/domain/model/model/user_model.dart';
import 'package:quick/domain/model/response/global_settings_response.dart';
import 'package:quick/domain/model/response/languages_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_keys.dart';

abstract class LocalStorage {
  LocalStorage._();

  static SharedPreferences? local;

  static Future init() async {
    local = await SharedPreferences.getInstance();
  }

  static Future setToken(String value) async {
    await local?.setString(StorageKeys.keyToken, value);
  }

  static String getToken() {
    return local?.getString(StorageKeys.keyToken) ?? "";
  }

  static deleteToken() {
    local?.remove(StorageKeys.keyToken);
  }

  static Future<void> setAdmin(UserModel? user) async {
    if (local != null) {
      await local?.setString(StorageKeys.keyAdmin, jsonEncode(user?.toJson()));
    }
  }

  static UserModel getAdmin() {
    Map jsonData = {};
    if (local?.getString(StorageKeys.keyAdmin) != null) {
      jsonData = jsonDecode(local?.getString(StorageKeys.keyAdmin) ?? "");
    }

    if (jsonData.isNotEmpty) {
      UserModel user = UserModel.fromJson(jsonData);
      return user;
    }

    return UserModel();
  }

  static deleteAdmin() => local?.remove(StorageKeys.keyAdmin);

  /// Get the current user ID
  static int? getUserId() {
    // Use getUser() instead of getAdmin() to get the correct user ID
    return getUser().id;
  }

  static Future<void> setSettingsList(List<SettingsData> settings) async {
    final List<String> strings =
        settings.map((setting) => jsonEncode(setting.toJson())).toList();
    await local?.setStringList(StorageKeys.keyGlobalSettings, strings);
  }

  static List<SettingsData> getSettingsList() {
    final List<String> settings =
        local?.getStringList(StorageKeys.keyGlobalSettings) ?? [];

    final List<SettingsData> settingsList = settings
        .map(
          (setting) => SettingsData.fromJson(jsonDecode(setting)),
        )
        .toList();
    return settingsList;
  }

  static deleteSettingsList() => local?.remove(StorageKeys.keyGlobalSettings);

  static Future<void> setOtherTranslations(
      {required Map<String, dynamic>? translations,
      required String key}) async {
    SharedPreferences? local = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(translations);
    await local.setString(key, encoded);
  }

  static Future<Map<String, dynamic>> getOtherTranslations(
      {required String key}) async {
    SharedPreferences? local = await SharedPreferences.getInstance();
    final String encoded = local.getString(key) ?? '';
    if (encoded.isEmpty) {
      return {};
    }
    final Map<String, dynamic> decoded = jsonDecode(encoded);
    return decoded;
  }

  static Future<void> setTranslations(
      Map<String, dynamic>? translations) async {
    final String encoded = jsonEncode(translations);
    await local?.setString(StorageKeys.keyTranslations, encoded);
  }

  static Map<String, dynamic> getTranslations() {
    final String encoded = local?.getString(StorageKeys.keyTranslations) ?? '';
    if (encoded.isEmpty) {
      return getDefaultTranslations();
    }
    final Map<String, dynamic> decoded = jsonDecode(encoded);
    return decoded.isEmpty ? getDefaultTranslations() : decoded;
  }

  static Map<String, dynamic> getDefaultTranslations() {
    // Default English translations for the entire app
    return {
      // Navigation & Common
      'home': 'Home',
      'categories': 'Categories',
      'cart': 'Cart',
      'profile': 'Profile',
      'search': 'Search',
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'logout': 'Logout',
      'login': 'Login',
      'register': 'Register',
      'welcome': 'Welcome',
      'loading': 'Loading',
      'retry': 'Retry',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'update': 'Update',
      'yes': 'Yes',
      'no': 'No',
      'ok': 'OK',
      'done': 'Done',
      'next': 'Next',
      'previous': 'Previous',
      'continue': 'Continue',
      'skip': 'Skip',
      'back': 'Back',
      'close': 'Close',

      // Auth
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'forgot_password': 'Forgot Password?',
      'reset_password': 'Reset Password',
      'sign_in': 'Sign In',
      'sign_up': 'Sign Up',
      'sign_in_with': 'Sign In with',
      'sign_up_with': 'Sign Up with',
      'or': 'OR',
      'dont_have_account': 'Don\'t have an account?',
      'already_have_account': 'Already have an account?',
      'create_account': 'Create Account',
      'verification_code': 'Verification Code',
      'verify': 'Verify',
      'resend_code': 'Resend Code',

      // Profile
      'my_profile': 'My Profile',
      'edit_profile': 'Edit Profile',
      'personal_info': 'Personal Information',
      'name': 'Name',
      'phone': 'Phone',
      'address': 'Address',
      'addresses': 'Addresses',
      'add_address': 'Add Address',
      'edit_address': 'Edit Address',
      'orders': 'Orders',
      'my_orders': 'My Orders',
      'order_history': 'Order History',
      'order_details': 'Order Details',
      'order_status': 'Order Status',
      'payment_method': 'Payment Method',
      'payment_status': 'Payment Status',
      'delivery_address': 'Delivery Address',
      'wishlist': 'Wishlist',
      'my_wishlist': 'My Wishlist',
      'wallet': 'Wallet',
      'my_wallet': 'My Wallet',
      'wallet_balance': 'Wallet Balance',
      'add_money': 'Add Money',
      'withdraw': 'Withdraw',
      'transaction_history': 'Transaction History',

      // Products
      'products': 'Products',
      'product_details': 'Product Details',
      'price': 'Price',
      'quantity': 'Quantity',
      'total': 'Total',
      'subtotal': 'Subtotal',
      'discount': 'Discount',
      'tax': 'Tax',
      'shipping': 'Shipping',
      'shipping_fee': 'Shipping Fee',
      'grand_total': 'Grand Total',
      'add_to_cart': 'Add to Cart',
      'buy_now': 'Buy Now',
      'add_to_wishlist': 'Add to Wishlist',
      'remove_from_wishlist': 'Remove from Wishlist',
      'out_of_stock': 'Out of Stock',
      'in_stock': 'In Stock',
      'description': 'Description',
      'reviews': 'Reviews',
      'related_products': 'Related Products',
      'filter': 'Filter',
      'sort': 'Sort',
      'sort_by': 'Sort By',
      'price_low_to_high': 'Price: Low to High',
      'price_high_to_low': 'Price: High to Low',
      'newest_first': 'Newest First',
      'popularity': 'Popularity',
      'rating': 'Rating',
      'apply': 'Apply',
      'clear': 'Clear',
      'clear_all': 'Clear All',

      // Cart & Checkout
      'my_cart': 'My Cart',
      'checkout': 'Checkout',
      'proceed_to_checkout': 'Proceed to Checkout',
      'place_order': 'Place Order',
      'order_summary': 'Order Summary',
      'payment': 'Payment',
      'cash_on_delivery': 'Cash on Delivery',
      'online_payment': 'Online Payment',
      'credit_card': 'Credit Card',
      'debit_card': 'Debit Card',
      'card_number': 'Card Number',
      'card_holder': 'Card Holder',
      'expiry_date': 'Expiry Date',
      'cvv': 'CVV',
      'shipping_address': 'Shipping Address',
      'billing_address': 'Billing Address',
      'same_as_shipping': 'Same as Shipping Address',

      // Notifications
      'notifications': 'Notifications',
      'no_notifications': 'No Notifications',
      'clear_notifications': 'Clear All Notifications',

      // Messages
      'success': 'Success',
      'error': 'Error',
      'warning': 'Warning',
      'info': 'Information',
      'no_internet': 'No Internet Connection',
      'try_again': 'Please Try Again',
      'something_went_wrong': 'Something Went Wrong',
      'loading_text': 'Loading...',
      'no_more_text': 'No More Data',
      'refresh_failed_text': 'Refresh Failed',
      'can_loading_text': 'Release to Load More',
      'refresh_complete_text': 'Refresh Complete',
      'can_refresh_text': 'Pull to Refresh',
      'refreshing_text': 'Refreshing...',
      'can_two_level_text': 'Release to Enter Second Floor',
      'idle_refresh_text': 'Pull Down to Refresh',

      // Settings
      'app_settings': 'App Settings',
      'notifications_settings': 'Notifications Settings',
      'language_settings': 'Language Settings',
      'privacy_policy': 'Privacy Policy',
      'terms_conditions': 'Terms & Conditions',
      'about_us': 'About Us',
      'contact_us': 'Contact Us',
      'help_support': 'Help & Support',
      'faq': 'FAQ',
      'rate_app': 'Rate App',
      'share_app': 'Share App',
      'version': 'Version',

      // Dates & Time
      'today': 'Today',
      'yesterday': 'Yesterday',
      'tomorrow': 'Tomorrow',
      'days_ago': 'days ago',
      'minutes_ago': 'minutes ago',
      'hours_ago': 'hours ago',
      'just_now': 'Just Now',

      // Chat
      'chat': 'Chat',
      'messages': 'Messages',
      'send': 'Send',
      'type_message': 'Type a message',
      'no_messages': 'No Messages',
      'online': 'Online',
      'offline': 'Offline',
      'typing': 'Typing...',

      // Errors
      'error_occurred': 'An error occurred',
      'please_try_again': 'Please try again',
      'invalid_email': 'Invalid email address',
      'invalid_password': 'Invalid password',
      'passwords_not_match': 'Passwords do not match',
      'field_required': 'This field is required',
      'no_items_found': 'No items found',
      'no_results': 'No results found',
      'session_expired': 'Session expired, please login again',

      // App Specific
      'app_name': 'Quick App',
      'welcome_message': 'Welcome to Quick App',
      'slogan': 'Your one-stop shopping solution',
    };
  }

  static deleteTranslations() => local?.remove(StorageKeys.keyTranslations);

  static Future<void> setLanguageData(LanguageData? langData) async {
    final String lang = jsonEncode(langData?.toJson());
    local ??= await SharedPreferences.getInstance();
    await local?.setString(StorageKeys.keyLangSelected, lang);
  }

  static LanguageData? getLanguage() {
    final lang = local?.getString(StorageKeys.keyLangSelected);
    if (lang == null) {
      return null;
    }
    final map = jsonDecode(lang);
    if (map == null) {
      return null;
    }
    return LanguageData.fromJson(map);
  }

  static deleteLanguage() => local?.remove(StorageKeys.keyLangSelected);

  static Future<void> setLangLtr(bool? backward) async {
    if (local != null) {
      await local?.setBool(StorageKeys.keyLangLtr, backward ?? false);
    }
  }

  static bool getLangLtr() =>
      !(local?.getBool(StorageKeys.keyLangLtr) ?? false);

  static deleteLangLtr() => local?.remove(StorageKeys.keyLangLtr);

  static Future<void> setUser(UserModel? user) async {
    if (local != null) {
      await local?.setString(StorageKeys.keyUser, jsonEncode(user?.toJson()));
    }
  }

  static UserModel getUser() {
    Map jsonData = {};
    if (local?.getString(StorageKeys.keyUser) != null) {
      jsonData = jsonDecode(local?.getString(StorageKeys.keyUser) ?? "");
    }

    if (jsonData.isNotEmpty) {
      UserModel user = UserModel.fromJson(jsonData);
      return user;
    }

    return UserModel();
  }

  static deleteUser() => local?.remove(StorageKeys.keyUser);

  static Future<void> setSelectedCurrency(CurrencyData currency) async {
    local ??= await SharedPreferences.getInstance();
    final String currencyString = jsonEncode(currency.toJson());
    await local!.setString(StorageKeys.keySelectedCurrency, currencyString);
  }

  static CurrencyData? getSelectedCurrency() {
    String json = local?.getString(StorageKeys.keySelectedCurrency) ?? '';
    if (json.isEmpty) {
      return null;
    }
    final map = jsonDecode(json);
    return CurrencyData.fromJson(map);
  }

  static void deleteSelectedCurrency() =>
      local?.remove(StorageKeys.keySelectedCurrency);

  static Future<void> setLikedProductsList(int id) async {
    if (id == 0) {
      return;
    }
    List<int> list = getLikedProductsList();
    if (list.contains(id)) {
      list.remove(id);
      if (LocalStorage.getToken().isNotEmpty) {
        userRepository.removeLikeProduct(id: id);
      }
    } else {
      list.add(id);
      if (LocalStorage.getToken().isNotEmpty) {
        userRepository.setLikeProduct(id: id);
      }
    }
    if (local != null) {
      final List<String> stringList = list.map((id) => id.toString()).toList();
      await local!.setStringList(StorageKeys.keyLikedProducts, stringList);
    }
  }

  static List<int> getLikedProductsList() {
    final List<String> idsStrings =
        local?.getStringList(StorageKeys.keyLikedProducts) ?? [];
    final List<int> ids = idsStrings.map((id) => int.parse(id)).toList();
    return ids;
  }

  static void deleteLikedProductsList() =>
      local?.remove(StorageKeys.keyLikedProducts);

  static Future<void> setCompareList(int id) async {
    if (id == 0) {
      return;
    }
    List<int> list = getCompareList();
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    if (local != null) {
      final List<String> stringList = list.map((id) => id.toString()).toList();
      await local!.setStringList(StorageKeys.keyCompareProducts, stringList);
    }
  }

  static List<int> getCompareList() {
    final List<String> idsStrings =
        local?.getStringList(StorageKeys.keyCompareProducts) ?? [];
    final List<int> ids = idsStrings.map((id) => int.parse(id)).toList();
    return ids;
  }

  static void deleteCompareList() =>
      local?.remove(StorageKeys.keyCompareProducts);

  static Future<void> setViewedProductsList(int id) async {
    if (id == 0) {
      return;
    }
    List<int> list = getViewedProductsList();
    if (list.length == 10) {
      list.removeLast();
    }
    if (list.contains(id)) {
      list.remove(id);
      list.add(id);
    } else {
      list.add(id);
    }
    if (local != null) {
      final List<String> stringList = list.map((id) => id.toString()).toList();
      await local!.setStringList(StorageKeys.keyViewedProducts, stringList);
    }
  }

  static List<int> getViewedProductsList() {
    final List<String> idsStrings =
        local?.getStringList(StorageKeys.keyViewedProducts) ?? [];
    final List<int> ids = idsStrings.map((id) => int.parse(id)).toList();
    return ids;
  }

  static void deleteViewedProductsList() =>
      local?.remove(StorageKeys.keyViewedProducts);

  static Future<void> setSearchRecentlyList(String title) async {
    List<String> list = getSearchRecentlyList();
    if (!list.contains(title)) {
      list.add(title);
    }
    if (local != null) {
      await local!.setStringList(StorageKeys.keySearchStores, list);
    }
  }

  static Future<void> removeSearchRecentlyList(String title) async {
    List<String> list = getSearchRecentlyList();
    list.remove(title);
    if (local != null) {
      await local!.setStringList(StorageKeys.keySearchStores, list);
    }
  }

  static List<String> getSearchRecentlyList() {
    final List<String> list =
        local?.getStringList(StorageKeys.keySearchStores) ?? [];
    return list;
  }

  static void deleteSearchRecentlyList() =>
      local?.remove(StorageKeys.keySearchStores);

  static Future<void> setAddress(AddressModel? address) async {
    if (local != null) {
      final String currencyString = jsonEncode(address?.toJson());
      await local!.setString(StorageKeys.keyAddress, currencyString);
    }
  }

  static AddressModel? getAddress() {
    String json = local?.getString(StorageKeys.keyAddress) ?? '';
    if (json.isEmpty) {
      return null;
    }
    final map = jsonDecode(json);
    return AddressModel.fromJson(map);
  }

  static void deleteAddress() => local?.remove(StorageKeys.keyAddress);

  static Future<void> setUiType(int type) async {
    if (local != null) {
      await local!.setInt(StorageKeys.keyUiType, type);
    }
  }

  static int? getUiType() => local?.getInt(StorageKeys.keyUiType) ?? 0;

  static Future changeAiActive() async {
    await local?.setBool(StorageKeys.keyAiActive, !getAiActive());
  }

  static bool getAiActive() {
    return local?.getBool(StorageKeys.keyAiActive) ?? false;
  }

  static clear() {
    deleteUser();
    deleteToken();
    deleteLikedProductsList();
    deleteSearchRecentlyList();
    deleteViewedProductsList();
    deleteAddress();
    deleteAdmin();
  }
}
