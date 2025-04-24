import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/products/attribute/attribute_bloc.dart';
import 'package:quick/application/profile/currency/currency_bloc.dart';
import 'package:quick/application/gemini/gemini_bloc.dart';
import 'package:quick/application/products/create/create_product_bloc.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/domain/model/request/selected_request.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/pages/products/widgets/attribute_item.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import '../widgets/privacy_widget.dart';

part 'widgets/media_screen.dart';

part 'widgets/price_field.dart';

part 'widgets/describe_field.dart';

part 'widgets/addresses_field.dart';

part 'widgets/categories_field.dart';

part 'widgets/attribute_field.dart';

part 'create_product_mixin.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage>
    with CreateProductMixin {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: _appBar,
        body: (colors) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: REdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    label: TrKeys.title,
                    controller: title,
                    textInputAction: TextInputAction.next,
                    validation: AppValidators.isMin12Symbol,
                    maxLength: 80,
                  ),
                  CategoriesField(onChange: (v) {
                    category = v;
                    if (v?.children?.isEmpty ?? true) {
                      context.read<AttributeBloc>().add(
                        AttributeEvent.fetchAttributes(
                          context: context,
                          categoryId: v?.id,
                          isRefresh: true,
                        ),
                      );
                    }
                  }),
                  ClassicDropDown(
                    label: TrKeys.condition,
                    list: AppConstants.conditions,
                    value: AppConstants.conditions.first,
                    onChanged: (value) {
                      condition = value;
                    },
                    colors: colors,
                    validator: AppValidators.emptyCheck,
                  ),
                  8.verticalSpace,
                  PriceField(
                    colors: colors,
                    price: price,
                    onChange: (v) => currency = v,
                  ),
                  MediaScreen(colors: colors),
                  // CustomDropdown(
                  //   label: TrKeys.brand,
                  //   dropDownType: DropDownType.brand,
                  //   onSelected: (v) => brand = v,
                  // ),
                  // 12.verticalSpace,
                  // CustomDropdown(
                  //   label: TrKeys.unit,
                  //   dropDownType: DropDownType.unit,
                  //   onSelected: (v) => unit = v,
                  // ),
                  ClassicDropDown(
                    label: TrKeys.type,
                    validator: AppValidators.emptyCheck,
                    list: AppConstants.productTypes,
                    value: AppConstants.productTypes.first,
                    onChanged: (value) => type = value,
                    colors: colors,
                  ),
                  12.verticalSpace,
                  AttributeField(colors: colors, desc: desc), 12.verticalSpace,
                  DescribeField(colors: colors, desc: desc),
                  12.verticalSpace,
                  Divider(color: colors.divider),
                  12.verticalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.contactInformation),
                    style: CustomStyle.interSemi(color: colors.textBlack),
                  ),
                  12.verticalSpace,
                  CustomTextFormField(
                    label: TrKeys.fullName,
                    controller: name,
                    textInputAction: TextInputAction.next,
                    validation: AppValidators.emptyCheck,
                  ),
                  12.verticalSpace,
                  CustomTextFormField(
                    label: TrKeys.email,
                    controller: email,
                    textInputAction: TextInputAction.next,
                    // validation: AppValidators.isValidEmail,
                  ),
                  AddressesField(
                    country: country,
                    onChangeArea: (id) {
                      areaId = id;
                    },
                    onChangeCity: (id) {
                      cityId = id;
                      areaId = null;
                    },
                    onChangeCountry: (value) {
                      country = value;
                      cityId = null;
                    },
                  ),
                  CustomPhoneField(
                    colors: colors,
                    isLabel: true,
                    validator: AppValidators.emptyCheck,
                    controller: phone,
                  ),
                  12.verticalSpace,
                  PrivacyWidget(colors: colors),
                  _buttons(colors),
                ],
              ),
            ),
          );
        });
  }

  _buttons(CustomColorSet colors) {
    return BlocBuilder<CreateProductBloc, CreateProductState>(
      builder: (context, state) {
        return Column(
          children: [
            24.verticalSpace,
            CustomButton(
              title: TrKeys.preview,
              bgColor: colors.transparent,
              titleColor: colors.textBlack,
              borderColor: colors.textBlack,
              onTap: () => _onPreview(state),
            ),
            8.verticalSpace,
            CustomButton(
              title: TrKeys.toPublish,
              bgColor: colors.textBlack,
              titleColor: colors.textWhite,
              isLoading: state.isLoading,
              changeColor: true,
              onTap: _onSave,
            ),
            24.verticalSpace,
          ],
        );
      },
    );
  }
}

AppBar _appBar(CustomColorSet colors) {
  return AppBar(
    toolbarHeight: 46.r,
    backgroundColor: colors.backgroundColor,
    automaticallyImplyLeading: false,
    elevation: 0.2,
    leading: PopButton(color: colors.textBlack),
    title: Text(
      AppHelpers.getTranslation(TrKeys.createProduct),
      style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
    ),
  );
}
