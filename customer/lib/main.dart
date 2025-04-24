import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'infrastructure/local_storage/local_storage.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:quick/presentation/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'domain/di/dependency_manager.dart';
import 'package:quick/app_constants.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }

  await LocalStorage.init();
  try {
    Gemini.init(apiKey: AppConstants.geminiKey);
  } catch (e) {
    debugPrint("Gemini initialization error: $e");
  }

  setUpDependencies();
  runApp(const AppWidget());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
