part of '../create_product_page.dart';

class CategoriesField extends StatelessWidget {
  final ValueChanged<CategoryData?> onChange;

  const CategoriesField({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final categoryEvent = context.read<CategoryBloc>();
    return Column(
      children: [
        12.verticalSpace,
        CustomDropdown(
          dropDownType: DropDownType.category,
          label: TrKeys.category,
          validator: AppValidators.emptyCheck,
          onSelected: (v) {
            categoryEvent.add(
                CategoryEvent.selectCategory(context: context, category: v));
            onChange.call(v);
          },
        ),
        BlocBuilder<CategoryBloc, CategoryState>(
          buildWhen: (p, n) {
            return p.selectCategory != n.selectCategory;
          },
          builder: (context, state) {
            return state.selectCategory?.children?.isNotEmpty ?? false
                ? Column(
                    children: [
                      12.verticalSpace,
                      CustomDropdown(
                        dropDownType: DropDownType.subcategory,
                        label: TrKeys.subcategory,
                        validator: AppValidators.emptyCheck,
                        onSelected: (v) {
                          categoryEvent.add(CategoryEvent.selectCategoryTwo(
                              context: context, category: v));
                          onChange.call(v);
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          },
        ),
        BlocBuilder<CategoryBloc, CategoryState>(
          buildWhen: (p, n) {
            return p.selectCategoryTwo != n.selectCategoryTwo;
          },
          builder: (context, state) {
            return state.selectCategoryTwo?.children?.isNotEmpty ?? false
                ? Column(
                    children: [
                      12.verticalSpace,
                      CustomDropdown(
                        dropDownType: DropDownType.childCategory,
                        label: TrKeys.childCategory,
                        validator: AppValidators.emptyCheck,
                        onSelected: (v) => onChange.call(v),
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          },
        ),
        12.verticalSpace,
      ],
    );
  }
}
