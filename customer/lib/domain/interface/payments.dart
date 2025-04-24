import 'package:dartz/dartz.dart';
import 'package:quick/domain/model/models.dart';

abstract class PaymentsInterface {
  Future<Either<PaymentsResponse, dynamic>> getPayments();

  Future<Either<TransactionsResponse, dynamic>> createTransaction({
    required int orderId,
    required int paymentId,
  });

  Future<Either<String, dynamic>> paymentWebView({required String name});

  Future<Either<String, dynamic>> paymentWalletWebView(
      {required String name, required int walletId, required num price});

  Future<Either<bool, dynamic>> sendWallet(
      {required String uuid, required num price});

  Future<Either<MaksekeskusResponse, dynamic>> paymentMaksekeskusView(
      {bool wallet = false});
}
