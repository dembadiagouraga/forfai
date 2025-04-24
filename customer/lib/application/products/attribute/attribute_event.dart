part of 'attribute_bloc.dart';

@freezed
abstract class AttributeEvent with _$AttributeEvent {
  const factory AttributeEvent.fetchAttributes(
      {required BuildContext context,
      bool? isRefresh,
      required int? categoryId,
      RefreshController? controller}) = FetchAttributes;
}
