part of 'user_product_bloc.dart';

@freezed
abstract class UserProductEvent with _$UserProductEvent {
  const factory UserProductEvent.fetchActiveProduct(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) = FetchActiveProduct;

  const factory UserProductEvent.fetchUnActiveProduct(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) = FetchUnActiveProduct;

  const factory UserProductEvent.fetchWaitingProduct(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) = FetchWaitingProduct;

  const factory UserProductEvent.changeActivate({
    required BuildContext context,
    ProductData? product,
    bool? help,
  }) = ChangeActivate;

  const factory UserProductEvent.deleteProduct({
    required BuildContext context,
    ProductData? product,
  }) = DeleteProduct;

  const factory UserProductEvent.updateState() = UpdateState;

  const factory UserProductEvent.setIndex({required int index}) = SetIndex;
}
