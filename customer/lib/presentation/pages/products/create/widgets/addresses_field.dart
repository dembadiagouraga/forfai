part of '../create_product_page.dart';

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
    final event = context.read<CreateProductBloc>();
    return Column(
      children: [
        12.verticalSpace,
        CustomDropdown(
          label: TrKeys.countryRegion,
          validator: AppValidators.emptyCheck,
          dropDownType: DropDownType.country,
          initialValue: country?.translation?.title,
          onSelected: (c) {
            onChangeCountry.call(c);
            event.add(CreateProductEvent.setCountry(countryId: c.id));
          },
        ),
        12.verticalSpace,
        BlocBuilder<CreateProductBloc, CreateProductState>(
          buildWhen: (l, n) => l.countryId != n.countryId,
          builder: (context, state) {
            return state.countryId != null
                ? Padding(
                    padding: REdgeInsets.only(bottom: 12),
                    child: CustomDropdown(
                      label: TrKeys.city,
                      isClear: true,
                      validator: AppValidators.emptyCheck,
                      initialId: state.countryId,
                      dropDownType: DropDownType.city,
                      onChanged: (id) {
                        onChangeCity.call(id);
                        event.add(CreateProductEvent.setCity(cityId: id));
                      },
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
        BlocBuilder<CreateProductBloc, CreateProductState>(
          buildWhen: (l, n) => l.cityId != n.cityId,
          builder: (context, state) {
            return state.cityId != null
                ? Padding(
                    padding: REdgeInsets.only(bottom: 12),
                    child: CustomDropdown(
                      label: TrKeys.area,
                      isClear: true,
                      initialId: state.cityId,
                      dropDownType: DropDownType.area,
                      onChanged: onChangeArea,
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
