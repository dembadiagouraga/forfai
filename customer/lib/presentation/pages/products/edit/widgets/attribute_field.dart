part of '../edit_product_page.dart';

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
    return BlocBuilder<EditProductBloc, EditProductState>(
      builder: (context, productState) {
        return BlocBuilder<AttributeBloc, AttributeState>(
          builder: (context, state) {
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
                      context.read<EditProductBloc>().add(
                            EditProductEvent.selectAttribute(
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
