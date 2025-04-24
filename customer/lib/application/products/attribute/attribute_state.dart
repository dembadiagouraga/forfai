part of 'attribute_bloc.dart';


@freezed
class AttributeState with _$AttributeState {
  const factory AttributeState({
    @Default([]) List<AttributesData> attribute,
    @Default(true) bool isLoading,
  }) = _AttributeState;
}
