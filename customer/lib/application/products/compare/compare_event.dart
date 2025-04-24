part of 'compare_bloc.dart';

@freezed
abstract class CompareEvent with _$CompareEvent {
  const factory CompareEvent.fetchProducts({
    required BuildContext context,
    bool? isRefresh,
    RefreshController? controller,
  }) = FetchProducts;

  const factory CompareEvent.setExtraGroup(
      {required List<ProductData> products}) = SetExtraGroup;
}
