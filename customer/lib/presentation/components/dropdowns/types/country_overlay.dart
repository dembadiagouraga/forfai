part of 'overlay_items.dart';

class CountryOverlay extends StatelessWidget {
  final CustomColorSet colors;
  final ScrollController scrollController;
  final ValueChanged<DropDownItemData> onChanged;
  final ValueChanged? onItemSelect;

  const CountryOverlay({
    super.key,
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
          state.countries.map(
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
                state.countries.singleWhere((e) => e.id == id.id));
          },
          onSearch: (value) {
            delayed.run(() {
              context.read<AddressBloc>().add(
                    AddressEvent.searchCountry(
                      context: context,
                      search: value,
                    ),
                  );
            });
          },
        );
      },
    );
  }
}
