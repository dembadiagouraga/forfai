part of 'overlay_items.dart';

class BrandOverlay extends StatelessWidget {
  final CustomColorSet colors;
  final ScrollController scrollController;
  final ValueChanged<DropDownItemData> onChanged;
  final ValueChanged? onItemSelect;

  const BrandOverlay({
    super.key,
    required this.colors,
    required this.scrollController,
    required this.onChanged,
    required this.onItemSelect,
  });

  @override
  Widget build(BuildContext context) {
    final delayed = Delayed(milliseconds: 700);
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        final items = List<DropDownItemData>.from(
          state.brands.map(
            (e) => DropDownItemData(
              id: e.id ?? 0,
              title: e.title ?? '',
            ),
          ),
        );
        return _CustomOverlay(
          items: items,
          colors: colors,
          isLoading: state.isLoading,
          scrollController: scrollController,
          onItemSelect: (id) {
            onChanged.call(id);
            onItemSelect
                ?.call(state.brands.firstWhere((element) => element.id == id.id));
          },
          onSearch: (value) {
            delayed.run(() {
              context.read<BrandBloc>().add(
                    BrandEvent.fetchBrands(
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
