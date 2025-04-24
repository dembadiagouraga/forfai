import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quick/presentation/app_assets.dart';
import 'package:quick/presentation/route/app_route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    debugPrint('SplashPage initState called');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('SplashPage post frame callback');

      // Default translations are now handled in LocalStorage.getTranslations()
      // This ensures the app always has translations available

      try {
        // Navigate to main screen
        debugPrint('Navigating to main screen');
        AppRoute.goMain(context);
        FlutterNativeSplash.remove();
      } catch (e) {
        debugPrint('Error navigating to main screen: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesBackground,
      fit: BoxFit.cover,
    );
  }
}
