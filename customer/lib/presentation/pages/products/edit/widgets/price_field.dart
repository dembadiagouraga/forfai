part of '../edit_product_page.dart';

class PriceField extends StatelessWidget {
  final CustomColorSet colors;
  final TextEditingController price;
  final ValueChanged? onChange;
  const PriceField({super.key, required this.colors, required this.price, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 10,
          child: CustomTextFormField(
            label: TrKeys.price,
            controller: price,
            maxLength: 14,
            textInputAction: TextInputAction.next,
            inputFormatters: [InputFormatter.currency],
            validation: AppValidators.emptyCheck,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          flex: 7,
          child: BlocBuilder<CurrencyBloc, CurrencyState>(
            buildWhen: (p, n) {
              return p.isLoading != n.isLoading;
            },
            builder: (context, state) {
              return ClassicDropDown(
                label: '',
                list: state.currency.map((e) => e.title ?? '').toSet().toList(),
                value: state.currency.isNotEmpty
                    ? state.currency.first.title ?? ''
                    : null,
                onChanged: (value) {
                  onChange?.call(state.currency.firstWhere((e) => e.title == value));
                },
                colors: colors,
              );
            },
          ),
        ),
      ],
    );
  }
}
