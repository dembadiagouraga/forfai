import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/domain/model/request/selected_request.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ftoast/ftoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/model/location_model.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';
import 'package:intl/intl.dart';

abstract class AppHelpers {
  AppHelpers._();

  static List<SelectedAttribute> attributeHelper(
      List<AttributesData>? attributes) {
    List<SelectedAttribute> values = [];
    for (int i = 0; i < (attributes?.length ?? 0); i++) {
      final value = attributes?[i].toSelectedAttribute();
      if (value != null) values.add(attributes![i].toSelectedAttribute());
    }
    return values;
  }

  static String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-.';
    final random = Random.secure();
    return List.generate(length, (i) => charset[random.nextInt(charset.length)])
        .join();
  }

  static String getNameColor(String? value) {
    if (checkIfHex(value)) {
      // final color = Color(int.parse('0xFF${value?.substring(1, 7)}'));
      // return color.colorName;
    }
    return value ?? TrKeys.unKnow;
  }

  static LatLng getLocation(LocationModel? location) {
    return location == null
        ? LatLng(getInitialLatitude(), getInitialLongitude())
        : LatLng(
            double.tryParse(location.latitude ?? "0") ?? getInitialLatitude(),
            double.tryParse(location.longitude ?? "0") ?? getInitialLongitude(),
          );
  }

  static String errorHandler(e, {String? statusCode}) {
    if (e.runtimeType == DioException) {
      final dioError = e as DioException;
      if (dioError.response?.data != null && dioError.response?.data["message"] != null) {
        if (dioError.response?.data["message"] == "Bad request.") {
          if (dioError.response?.data["params"] != null) {
            return (dioError.response?.data["params"] as Map).values.first[0];
          } else {
            return dioError.response?.data["message"] ?? "Unknown error";
          }
        } else {
          return dioError.response?.data["message"] ?? "Unknown error";
        }
      } else {
        return dioError.message ?? "Network error";
      }
    } else {
      return e.toString();
    }
  }

  static bool getHourFormat24() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'hour_format') {
        return (setting.value ?? "HH:mm") == "HH:mm";
      }
    }
    return true;
  }

  static String numberFormat(
    num? number, {
    String? symbol,
    int? decimalDigits,
  }) {
    number = number ?? 0;
    if (LocalStorage.getSelectedCurrency()?.position == "before") {
      return NumberFormat.currency(
        customPattern: '\u00a4 #,###.#',
        symbol: symbol ?? LocalStorage.getSelectedCurrency()?.symbol,
        decimalDigits: decimalDigits ?? (number > 999 ? 0 : 2),
      ).format(number);
    } else {
      return NumberFormat.currency(
        customPattern: '#,###.# \u00a4',
        symbol: symbol ?? LocalStorage.getSelectedCurrency()?.symbol,
        decimalDigits: decimalDigits ?? (number > 999 ? 0 : 2),
      ).format(number);
    }
  }

  static NumberFormat format() {
    if (LocalStorage.getSelectedCurrency()?.position == "before") {
      return NumberFormat.currency(
        customPattern: '#,###.#',
        symbol: LocalStorage.getSelectedCurrency()?.symbol,
        decimalDigits: 0,
      );
    } else {
      return NumberFormat.currency(
        customPattern: '#,###.##',
        symbol: LocalStorage.getSelectedCurrency()?.symbol,
        decimalDigits: 0,
      );
    }
  }

  static String getFilterType(FilterType value) {
    switch (value) {
      case FilterType.news:
        return "new";
      case FilterType.priceMin:
        return "price_min";
      case FilterType.priceMax:
        return "price_max";
      default:
        return value.name;
    }
  }

  static openDialog({
    required BuildContext context,
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
        return ThemeWrapper(
          builder: (colors, controller) {
            return Dialog(
              backgroundColor: colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                margin: EdgeInsets.all(24.w),
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: colors.backgroundColor,
                  borderRadius: BorderRadius.circular(AppConstants.radius.r),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: CustomStyle.interNormal(
                            color: colors.textBlack, size: 18),
                      ),
                      24.verticalSpace,
                      CustomButton(
                        onTap: () => Navigator.pop(context),
                        title: TrKeys.close,
                        bgColor: CustomStyle.primary,
                        titleColor: CustomStyle.white,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static showCustomDialog({
    required BuildContext context,
    required Widget content,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
        return ThemeWrapper(
          builder: (colors, controller) {
            return Dialog(
              backgroundColor: colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
              child: content,
            );
          },
        );
      },
    );
  }

  static openDialogImagePicker({
    required BuildContext context,
    required VoidCallback openCamera,
    required VoidCallback openGallery,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
        return ThemeWrapper(
          builder: (colors, controller) {
            return Dialog(
              backgroundColor: colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                margin: EdgeInsets.all(24.w),
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: colors.backgroundColor,
                  borderRadius: BorderRadius.circular(AppConstants.radius.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.selectPhoto),
                      textAlign: TextAlign.center,
                      style: CustomStyle.interNormal(
                          color: colors.textBlack, size: 18),
                    ),
                    const Divider(),
                    8.verticalSpace,
                    ButtonEffectAnimation(
                      onTap: openCamera,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.r, vertical: 8.r),
                        child: Row(
                          children: [
                            Icon(
                              Remix.camera_lens_line,
                              color: colors.textBlack,
                            ),
                            4.horizontalSpace,
                            Text(
                              AppHelpers.getTranslation(TrKeys.takePhoto),
                              textAlign: TextAlign.center,
                              style: CustomStyle.interNormal(
                                  color: colors.textBlack, size: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    ButtonEffectAnimation(
                      onTap: openGallery,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.r, vertical: 8.r),
                        child: Row(
                          children: [
                            Icon(
                              Remix.gallery_line,
                              color: colors.textBlack,
                            ),
                            4.horizontalSpace,
                            Text(
                              AppHelpers.getTranslation(
                                  TrKeys.chooseFromLibrary),
                              textAlign: TextAlign.center,
                              style: CustomStyle.interNormal(
                                  color: colors.textBlack, size: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static errorSnackBar(
      {required BuildContext context, required String message}) {
    FToast.toast(context,
        toast: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              76.verticalSpace,
              Container(
                  padding: EdgeInsets.all(16.r),
                  margin: REdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                      color: CustomStyle.primary,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Text(
                    message,
                    style: CustomStyle.interNormal(
                        color: CustomStyle.white, size: 14),
                    maxLines: 24,
                  ))
            ],
          ),
        ));
  }

  static void showCustomModalBottomSheet({
    required BuildContext context,
    required Widget modal,
    double radius = 24,
    bool isDrag = true,
    bool isDismissible = true,
    double paddingTop = 200,
  }) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - paddingTop.r,
      ),
      backgroundColor: CustomStyle.transparent,
      context: context,
      builder: (context) => modal,
    );
  }

  static void showCustomModalBottomSheetDrag({
    required BuildContext context,
    required Function(ScrollController controller) modal,
    double radius = 24,
    bool isDrag = true,
    bool isDismissible = true,
    double paddingTop = 200,
    double maxChildSize = 0.9,
    double initialChildSize = 0.8,
  }) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - paddingTop.r,
      ),
      backgroundColor: CustomStyle.transparent,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        maxChildSize: maxChildSize,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return modal(scrollController);
        },
      ),
    );
  }

  static String getAppName() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'title') {
        return setting.value ?? "";
      }
    }
    return '';
  }

  static bool getAds() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'show_ads') {
        return setting.value == "true" || setting.value == "1";
      }
    }
    return false;
  }

  static int getType() {
    if (AppConstants.isDemo) {
      return LocalStorage.getUiType() ?? 0;
    }
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'ui_type') {
        return (int.tryParse(setting.value ?? "1") ?? 1) - 1;
      }
    }
    return 0;
  }

  static String getTranslation(String trKey) {
    // Get translations from LocalStorage (which now returns default English translations if empty)
    final Map<String, dynamic> translations = LocalStorage.getTranslations();

    // If auto translation is enabled, try to format the key as a readable string if translation is missing
    if (AppConstants.autoTrn) {
      return (translations[trKey] ??
          (trKey.isNotEmpty
              ? trKey.replaceAll(".", " ").replaceAll("_", " ").replaceFirst(
                  trKey.substring(0, 1), trKey.substring(0, 1).toUpperCase())
              : ''));
    } else {
      // Return the translation or the key itself as fallback
      return translations[trKey] ?? trKey;
    }
  }

  static RichText getSearchResultText(
      String mainText, String subtext, CustomColorSet colors) {
    if (!mainText.toUpperCase().contains(subtext.toUpperCase())) {
      return RichText(
        text: TextSpan(
          text: mainText,
          style: CustomStyle.interNormal(
              color: colors.textBlack.withValues(alpha: 0.3), size: 14),
        ),
      );
    }
    final int startIndex =
        mainText.toUpperCase().indexOf(subtext.toUpperCase());
    final String prefixText = mainText.substring(0, startIndex);
    final String centerText =
        mainText.substring(startIndex, startIndex + subtext.length);
    final hasPostText = subtext.length + startIndex < mainText.length - 1;
    final String postText = hasPostText
        ? mainText.substring(subtext.length + startIndex, mainText.length - 1)
        : '';
    return RichText(
      text: TextSpan(
        text: prefixText,
        style: CustomStyle.interNormal(
            color: colors.textBlack.withValues(alpha: 0.3), size: 14),
        children: <TextSpan>[
          TextSpan(
            text: centerText,
            style: CustomStyle.interNormal(color: colors.textBlack, size: 14),
          ),
          TextSpan(
            text: postText,
            style: CustomStyle.interNormal(
                color: colors.textBlack.withValues(alpha: 0.3), size: 14),
          ),
        ],
      ),
    );
  }

  static bool checkPhone(String value) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value.replaceAll("+", ""));
  }

  static bool checkIfHex(String? type) {
    if (type == null || type.isEmpty) {
      return false;
    }
    if (type.length == 7 && type[0] == '#') {
      return true;
    } else {
      return false;
    }
  }

  static double getInitialLatitude() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'location') {
        final String? latString =
            setting.value?.substring(0, setting.value?.indexOf(','));
        if (latString == null) {
          return AppConstants.demoLatitude;
        }
        final double? lat = double.tryParse(latString);
        return lat ?? AppConstants.demoLatitude;
      }
    }
    return AppConstants.demoLatitude;
  }

  static double getInitialLongitude() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'location') {
        final String? latString =
            setting.value?.substring(0, setting.value?.indexOf(','));
        if (latString == null) {
          return AppConstants.demoLongitude;
        }
        final String? lonString = setting.value
            ?.substring((latString.length) + 2, setting.value?.length);
        if (lonString == null) {
          return AppConstants.demoLatitude;
        }
        final double lon = double.parse(lonString);
        return lon;
      }
    }
    return AppConstants.demoLatitude;
  }

  static bool getReferralActive() {
    final List<SettingsData> settings = LocalStorage.getSettingsList();
    for (final setting in settings) {
      if (setting.key == 'referral_active') {
        return setting.value == "1";
      }
    }
    return false;
  }

  static void showAlertDialog({
    required BuildContext context,
    required Widget child,
    required CustomColorSet colors,
    double radius = 16,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ThemeWrapper(builder: (colors, controller) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius.r),
            ),
            backgroundColor: colors.backgroundColor,
            contentPadding: EdgeInsets.all(16.r),
            iconPadding: EdgeInsets.zero,
            content: child,
          );
        });
      },
    );
  }
}
