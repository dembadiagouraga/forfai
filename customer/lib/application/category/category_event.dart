part of 'category_bloc.dart';

@freezed
abstract class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent.fetchCategory(
      {required BuildContext context,
      bool? isRefresh,
      String? query,
      RefreshController? controller}) = FetchCategory;

  const factory CategoryEvent.selectCategory({
    required BuildContext context,
    CategoryData? category,
    bool? onlySelect,
  }) = SelectCategory;

  const factory CategoryEvent.selectCategoryTwo(
      {required BuildContext context,
      CategoryData? category}) = SelectCategoryTwo;
}
