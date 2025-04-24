part of 'transactions_bloc.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    @Default(false) bool isLoading,
    @Default([]) List<TransactionModel> transactions,
  }) = _TransactionsState;
}
