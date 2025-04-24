part of '../edit_product_page.dart';

class AddressesField extends StatelessWidget {
  final CountryModel? country;
  final ValueChanged<int?> onChangeArea;
  final ValueChanged<int?> onChangeCity;
  final ValueChanged<CountryModel?> onChangeCountry;

  const AddressesField({
    super.key,
    required this.country,
    required this.onChangeArea,
    required this.onChangeCity,
    required this.onChangeCountry,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<EditProductBloc>();
    return Column(
      children: [
        12.verticalSpace,
        BlocBuilder<EditProductBloc, EditProductState>(
          buildWhen: (l, n) => l.product != n.product,
          builder: (context, state) {
            return CustomDropdown(
              label: TrKeys.countryRegion,
              validator: AppValidators.emptyCheck,
              dropDownType: DropDownType.country,
              initialValue: state.product?.country?.translation?.title,
              onSelected: (c) {
                onChangeCountry.call(c.id);
                event.add(EditProductEvent.setCountry(countryId: c.id));
              },
            );
          },
        ),
        12.verticalSpace,
        BlocBuilder<EditProductBloc, EditProductState>(
          buildWhen: (l, n) => l.countryId != n.countryId,
          builder: (context, state) {
            return state.countryId != null
                ? Padding(
              padding: REdgeInsets.only(bottom: 12),
              child: CustomDropdown(
                label: TrKeys.city,
                validator: AppValidators.emptyCheck,
                isClear: state.countryId != state.product?.country?.id,
                initialId: state.countryId,
                initialValue: state.product?.city?.translation?.title,
                dropDownType: DropDownType.city,
                onChanged: (id) {
                  onChangeCity.call(id);
                  event.add(EditProductEvent.setCity(cityId: id));
                },
              ),
            )
                : const SizedBox.shrink();
          },
        ),
        BlocBuilder<EditProductBloc, EditProductState>(
          buildWhen: (l, n) => l.cityId != n.cityId,
          builder: (context, state) {
            return state.cityId != null
                ? Padding(
              padding: REdgeInsets.only(bottom: 12),
              child: CustomDropdown(
                label: TrKeys.area,
                isClear: state.cityId != state.product?.city?.id,
                initialValue: state.product?.area?.translation?.title,
                initialId: state.cityId,
                dropDownType: DropDownType.area,
                onChanged: (id) => onChangeArea.call(id),
              ),
            )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
