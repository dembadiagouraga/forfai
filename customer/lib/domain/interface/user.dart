import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quick/domain/model/models.dart';

abstract class UserInterface {
  Future<Either<ProfileResponse, dynamic>> getProfileDetails(
      BuildContext context);

  Future deleteAccount();

  Future setLikeProduct({required int id});

  Future setLikeProductList({required List<int> ids});

  Future removeLikeProduct({required int id});

  Future<Either<ProfileResponse, dynamic>> updateProfile(
      {required UpdateProfileModel updateProfile});

  Future<Either<ProfileResponse, dynamic>> updatePassword({
    required String password,
    required String passwordConfirmation,
  });

  Future updateFirebaseToken(String? token);

  Future<Either<NotificationResponse, dynamic>> getNotifications({
    int? page,
  });

  Future<Either<bool, dynamic>> readOne({int? id});

  Future<Either<bool, dynamic>> deleteNotification({int? id});

  Future<Either<bool, dynamic>> updateNotification(
      {List<NotificationsModel>? notifications});

  Future<Either<NotificationResponse, dynamic>> readAll();

  Future<Either<CountNotificationModel, dynamic>> getCount(
      BuildContext context);

  Future<Either<TransactionPaginationResponse, dynamic>> getWalletHistory(
      int page);

  Future<Either<TransactionPaginationResponse, dynamic>> getTransactions(
      int page);

  Future<Either<List<UserModel>, dynamic>> searchUser(
      {required String name, required int page});

  Future<Either<ReferralModel, dynamic>> getReferralDetails();
}
