part of '../create_product_page.dart';

class AttributeField extends StatelessWidget {
  final CustomColorSet colors;
  final TextEditingController desc;

  const AttributeField({
    super.key,
    required this.colors,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttributeBloc, AttributeState>(
      builder: (context, state) {
        return BlocBuilder<CreateProductBloc, CreateProductState>(
          builder: (context, productState) {
            return ListView.builder(
                itemCount: state.attribute.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AttributeItem(
                    attribute: state.attribute[index],
                    colors: colors,
                    selectedAttribute: productState.attributes.firstWhere(
                        ((e) => e.attributeId == state.attribute[index].id),
                        orElse: () => SelectedAttribute()),
                    onChanged: (attribute) {
                      context.read<CreateProductBloc>().add(
                            CreateProductEvent.selectAttribute(
                                attribute: attribute),
                          );
                    },
                  );
                });
          },
        );
      },
    );
  }
}
