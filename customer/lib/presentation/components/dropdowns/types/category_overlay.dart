part of 'overlay_items.dart';

class CategoryOverlay extends StatelessWidget {
  final CustomColorSet colors;
  final ScrollController scrollController;
  final ValueChanged<DropDownItemData> onChanged;
  final ValueChanged? onItemSelect;
  final DropDownType type;

  const CategoryOverlay({
    super.key,
    required this.colors,
    required this.scrollController,
    required this.onItemSelect,
    required this.onChanged,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final delayed = Delayed(milliseconds: 700);
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        final categories = type == DropDownType.category
            ? state.categories
            : type == DropDownType.subcategory
                ? state.selectCategory?.children ?? []
                : state.selectCategoryTwo?.children ?? [];
        final items = List<DropDownItemData>.from(
          categories.map(
            (e) => DropDownItemData(
              id: e.id ?? 0,
              title: e.translation?.title ?? '',
            ),
          ),
        );
        return _CustomOverlay(
          items: items,
          colors: colors,
          isLoading: state.isLoadingCategory,
          scrollController: scrollController,
          onItemSelect: (id) {
            onChanged.call(id);
            onItemSelect
                ?.call(categories.firstWhere((element) => element.id == id.id));
          },
          onSearch: type != DropDownType.category
              ? null
              : (value) {
                  delayed.run(() {
                    context.read<CategoryBloc>().add(
                          CategoryEvent.fetchCategory(
                            context: context,
                            isRefresh: true,
                            query: value,
                          ),
                        );
                  });
                },
        );
      },
    );
  }
}
