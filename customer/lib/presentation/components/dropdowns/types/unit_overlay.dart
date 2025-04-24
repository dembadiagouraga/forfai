part of 'overlay_items.dart';

class UnitOverlay extends StatelessWidget {
  final CustomColorSet colors;
  final ScrollController scrollController;
  final ValueChanged<DropDownItemData> onChanged;
  final ValueChanged? onItemSelect;

  const UnitOverlay({
    super.key,
    required this.colors,
    required this.scrollController,
    required this.onChanged,
    this.onItemSelect,
  });

  @override
  Widget build(BuildContext context) {
    final delayed = Delayed(milliseconds: 700);
    return BlocBuilder<UnitBloc, UnitState>(
      builder: (context, state) {
        final items = List<DropDownItemData>.from(
          state.units.map(
            (e) => DropDownItemData(
              id: e.id ?? 0,
              title: e.translation?.title ?? '',
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
            onItemSelect?.call(
                state.units.firstWhere((element) => element.id == id.id));
          },
          onSearch: (value) {
            delayed.run(() {
              context.read<UnitBloc>().add(
                    UnitEvent.fetchUnits(
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
