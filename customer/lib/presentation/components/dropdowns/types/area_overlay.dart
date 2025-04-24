part of 'overlay_items.dart';

class AreaOverlay extends StatelessWidget {
  final int? cityId;
  final CustomColorSet colors;
  final ScrollController scrollController;
  final ValueChanged<DropDownItemData> onChanged;
  final ValueChanged? onItemSelect;

  const AreaOverlay({
    super.key,
    required this.cityId,
    required this.colors,
    required this.scrollController,
    required this.onChanged, this.onItemSelect,
  });

  @override
  Widget build(BuildContext context) {
    final delayed = Delayed(milliseconds: 700);
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        final items = List<DropDownItemData>.from(
          state.areas.map(
            (e) => DropDownItemData(
              id: e.id ?? 0,
              title: e.translation?.title ?? '',
            ),
          ),
        );
        return _CustomOverlay(
          items: items,
          colors: colors,
          isLoading: state.isAreaLoading,
          scrollController: scrollController,
          onItemSelect: (id) {
            onChanged.call(id);
            onItemSelect?.call(
                state.areas.singleWhere((e) => e.id == id.id));
          },
          onSearch: (value) {
            delayed.run(() {
              context.read<AddressBloc>().add(
                    AddressEvent.searchArea(
                      context: context,
                      search: value, cityId: cityId,
                    ),
                  );
            });
          },
        );
      },
    );
  }
}
