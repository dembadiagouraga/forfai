part of 'filter_bloc.dart';

@freezed
class FilterState with _$FilterState {
  const factory FilterState({
    @Default(LayoutType.twoH) LayoutType selectType,
    @Default(true) bool isLoading,
    @Default(FilterType.news) FilterType type,
    @Default(null) FilterResponse? filter,
    @Default(null) Price? filterPrices,
    @Default([]) List<Value> attributes,
    @Default([]) List<int> categories,
    @Default([]) List<int> brands,
    @Default([]) List<int> prices,
    @Default(null) RangeValues? rangeValues,
    @Default(null) CategoryData? category,
  }) = _FilterState;
}
