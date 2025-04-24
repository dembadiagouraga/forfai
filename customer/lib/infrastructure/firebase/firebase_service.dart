// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirebaseService {
  FirebaseService._();

  static final FirebaseFirestore store = FirebaseFirestore.instance;

  static Future<String> getFcmToken() async {
    final firebaseM = FirebaseMessaging.instance;
    firebaseM.requestPermission(
      sound: true,
      alert: true,
      badge: false,
    );
    return await firebaseM.getToken() ?? "";
  }

  /// Save a file locally and return the path
  /// This is a temporary solution until Firebase Storage is properly configured
  static Future<String?> uploadFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        debugPrint('File does not exist: $filePath');
        return null;
      }

      // Just return the original file path since we're not actually uploading
      // This will allow the voice message to be saved locally
      debugPrint('Using local file path instead of uploading: $filePath');
      return filePath;
    } catch (e) {
      debugPrint('Error handling file: $e');
      return null;
    }
  }

  static Future<Either<UserCredential, dynamic>> socialGoogle() async {
    try {
      // Create a new instance each time to avoid cached issues
      // Explicitly set the web client ID and package name to fix the DEVELOPER_ERROR
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: '586412579852-gokjtau5cc8681gnhesumhir8tjram43.apps.googleusercontent.com',
        scopes: ['email', 'profile'],
        hostedDomain: '',
      );

      // First sign out to ensure a clean sign-in process
      try {
        await googleSignIn.signOut();
        debugPrint('Successfully signed out from previous Google session');
      } catch (e) {
        debugPrint('Sign out error (safe to ignore): $e');
      }

      debugPrint('Starting Google Sign-In flow');
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Check if user canceled the sign-in
      if (googleSignInAccount == null) {
        debugPrint('Google Sign-In was canceled by user');
        return right('Sign in canceled');
      }

      debugPrint('Google account selected: ${googleSignInAccount.email}');
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      if (googleSignInAuthentication.idToken == null) {
        debugPrint('Failed to get ID token from Google');
        return right('Authentication failed: No ID token');
      }

      debugPrint('Got Google authentication tokens');
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      debugPrint('Signing in to Firebase with Google credential');
      try {
        // Sign out first to ensure we're not using cached credentials
        await FirebaseAuth.instance.signOut();

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user == null) {
          debugPrint('Firebase returned null user');
          return right('Authentication failed: Firebase returned null user');
        }

        debugPrint('Google Sign-In successful: ${userCredential.user?.email}');
        return left(userCredential);
      } catch (firebaseError) {
        debugPrint('Firebase authentication error: $firebaseError');
        return right(firebaseError.toString());
      }
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
      return right(e.toString());
    }
  }

  static Future<Either<String, User>> socialFacebook() async {
    // Modified to return a message without using Facebook Auth
    return left('Facebook login is temporarily disabled');
  }

  static Future<Either<UserCredential, dynamic>> socialApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      OAuthProvider oAuthProvider = OAuthProvider("apple.com");
      final AuthCredential credentialApple = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credentialApple);
      return left(userObj);
    } catch (e) {
      return right(e.toString());
    }
  }

  static sendCode(
      {required String phone,
      required ValueChanged<String> onSuccess,
      required ValueChanged<String> onError}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? '');
      },
      codeSent: (String verificationId, int? resendToken) {
        onSuccess(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future<Either<UserCredential, dynamic>> checkCode(
      {required String verificationId, required String code}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );

      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      return left(user);
    } catch (e) {
      return right(e.toString());
    }
  }

  // Replace dynamic links functionality with a placeholder
  static Future<void> initDynamicLinks(BuildContext context) async {
    // Temporary solution until migration to new deep linking solution
    debugPrint('Dynamic Links functionality is currently unavailable');
  }
}
