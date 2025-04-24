import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quick/presentation/pages/auth/splash_screen.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/infrastructure/repository/settings_repository.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'style/style.dart';
import 'style/theme/theme.dart';

@pragma('vm:entry-point')
Future<int> getOtherTranslation(int arg) async {
  final settingsRepository = SettingsRepository();
  final res = await settingsRepository.getLanguages(arg: true);
  res.fold((l) {
    l.data?.forEach((e) async {
      final translations =
      await settingsRepository.getMobileTranslations(lang: e.locale);
      translations.fold((d) {
        LocalStorage.setOtherTranslations(
            translations: d.data, key: e.id.toString());
      }, (r) => null);
    });
  }, (r) => null);
  return 0;
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  // Added the missing isolate method
  Future isolate() async {
    try {
      debugPrint("Starting isolate");
      return await FlutterIsolate.spawn(getOtherTranslation, 0);
    } catch (e) {
      debugPrint("Error spawning isolate: $e");
      return Future.value();
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint("AppWidget initState called");

    try {
      if (LocalStorage.getTranslations().isNotEmpty) {
        debugPrint("Translations found, fetching settings without await");
        fetchSettingNoAwait();
      } else {
        debugPrint("No translations found");
      }

      isolate();

      try {
        debugPrint("Setting high refresh rate");
        FlutterDisplayMode.setHighRefreshRate();
      } catch (e) {
        debugPrint('Error setting high refresh rate: $e');
      }
    } catch (e) {
      debugPrint("Error in initState: $e");
    }
  }

  Future fetchSetting() async {
    try {
      debugPrint("Starting fetchSetting");
      final connect = await Connectivity().checkConnectivity();
      debugPrint("Connectivity result: $connect");

      if (connect.contains(ConnectivityResult.wifi) ||
          connect.contains(ConnectivityResult.ethernet) ||
          connect.contains(ConnectivityResult.mobile)) {
        debugPrint("Network available, fetching settings");
        await settingsRepository.getGlobalSettings();
        await settingsRepository.getLanguages();
        await settingsRepository.getMobileTranslations();
        await settingsRepository.getCurrencies();
        debugPrint("Settings fetched successfully");
        return true;
      } else {
        debugPrint("No network connection available");
        return false;
      }
    } catch (e) {
      debugPrint("Error in fetchSetting: $e");
      return false;
    }
  }

  Future fetchSettingNoAwait() async {
    settingsRepository.getGlobalSettings();
    settingsRepository.getLanguages();
    settingsRepository.getMobileTranslations();
    settingsRepository.getCurrencies();
  }

  Widget _refreshFooter() {
    return ClassicFooter(
      idleIcon: const SizedBox.shrink(),
      idleText: '',
      loadingText: 'Loading...',
      noDataText: 'No more data',
      failedText: 'Refresh failed',
      canLoadingText: 'Release to load more',
    );
  }

  Widget _refreshHeader() {
    return WaterDropHeader(
      waterDropColor: CustomStyle.primary,
      complete: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.done, color: Colors.grey),
          15.horizontalSpace,
          Text(
            'Refresh complete',
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
      idleIcon: const Icon(
        Remix.plane_fill,
        size: 15,
        color: CustomStyle.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait({
          AppTheme.create,
          if (LocalStorage.getTranslations().isEmpty) fetchSetting()
        }),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            FlutterNativeSplash.remove();
            final AppTheme theme = snapshot.data?[0];
            return ScreenUtilInit(
              useInheritedMediaQuery: true,
              designSize: const Size(375, 812),
              builder: (context, child) {
                return RefreshConfiguration(
                  footerBuilder: _refreshFooter,
                  headerBuilder: _refreshHeader,
                  child: ChangeNotifierProvider(
                    create: (BuildContext context) => theme,
                    child: MaterialApp(
                      theme: ThemeData(useMaterial3: false),
                      title: AppHelpers.getAppName(),
                      builder: (context, child) => ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: child!,
                      ),
                      debugShowCheckedModeBanner: false,
                      home: SplashPage(),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;
}
