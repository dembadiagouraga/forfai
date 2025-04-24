part of 'transactions_bloc.dart';

@freezed
abstract class TransactionsEvent with _$TransactionsEvent {
  const factory TransactionsEvent.fetchTransactions(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) = FetchTransactions;

}
