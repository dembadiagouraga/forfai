import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/products/attribute/attribute_bloc.dart';
import 'package:quick/application/profile/currency/currency_bloc.dart';
import 'package:quick/application/gemini/gemini_bloc.dart';
import 'package:quick/application/products/edit/edit_product_bloc.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/domain/model/request/selected_request.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../widgets/attribute_item.dart';
import '../widgets/privacy_widget.dart';

part 'widgets/describe_field.dart';

part 'widgets/media_screen.dart';

part 'widgets/price_field.dart';

part 'widgets/categories_field.dart';

part 'widgets/addresses_field.dart';

part 'widgets/attribute_field.dart';

part 'edit_product_mixin.dart';

class EditProductPage extends StatefulWidget {
  final ProductData product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage>
    with EditProductMixin {
  @override
  Widget build(BuildContext context) {
    final event = context.read<EditProductBloc>();
    return CustomScaffold(
        appBar: _appBar,
        body: (colors) {
          return Form(
            key: formKey,
            child: BlocBuilder<EditProductBloc, EditProductState>(
              builder: (context, state) {
                return state.isLoading
                    ? const Loading()
                    : SingleChildScrollView(
                        padding: REdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              label: TrKeys.title,
                              controller: title,
                              textInputAction: TextInputAction.next,
                              validation: AppValidators.emptyCheck,
                            ),
                            8.verticalSpace,
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
                            12.verticalSpace,
                            CategoriesField(
                              onChange: (value) => category = value,
                              initialValue:
                                  state.product?.category?.translation?.title,
                            ),
                            12.verticalSpace,
                            PriceField(
                              colors: colors,
                              price: price,
                              onChange: (v) => currency = v,
                            ),
                            MediaScreen(colors: colors),
                            12.verticalSpace,
                            // CustomDropdown(
                            //   label: TrKeys.brand,
                            //   initialValue: state.product?.brand?.title,
                            //   dropDownType: DropDownType.brand,
                            //   onSelected: (v) => brand = v,
                            // ),
                            // 12.verticalSpace,
                            // CustomDropdown(
                            //   label: TrKeys.unit,
                            //   initialValue:
                            //       state.product?.unit?.translation?.title,
                            //   dropDownType: DropDownType.unit,
                            //   onSelected: (v) => unit = v,
                            // ),
                            ClassicDropDown(
                              label: TrKeys.type,
                              validator: AppValidators.emptyCheck,
                              list: AppConstants.productTypes,
                              value: state.product?.type ??
                                  AppConstants.productTypes.first,
                              onChanged: (value) => type = value,
                              colors: colors,
                            ),
                            12.verticalSpace,
                            AttributeField(colors: colors, desc: desc),
                            12.verticalSpace,
                            DescribeField(colors: colors, desc: desc),
                            12.verticalSpace,
                            Divider(color: colors.divider),
                            12.verticalSpace,
                            Text(
                              AppHelpers.getTranslation(
                                  TrKeys.contactInformation),
                              style: CustomStyle.interSemi(
                                  color: colors.textBlack),
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
                              initialValue: LocalStorage.getUser().phone,
                              controller: phone,
                              colors: colors,
                              isLabel: true,
                              validator: AppValidators.emptyCheck,
                            ),
                            12.verticalSpace,
                            PrivacyWidget(colors: colors),
                            12.verticalSpace,
                            CustomButton(
                              title: TrKeys.preview,
                              bgColor: colors.transparent,
                              titleColor: colors.textBlack,
                              borderColor: colors.textBlack,
                              onTap: () {
                                if (state.images.isEmpty &&
                                    state.listOfUrls.isEmpty) {
                                  AppHelpers.errorSnackBar(
                                      context: context,
                                      message: AppHelpers.getTranslation(
                                          TrKeys.pleaseSelectImage));
                                  return;
                                }
                                if (formKey.currentState?.validate() ?? false) {
                                  List<AttributesData> list = context
                                      .read<AttributeBloc>()
                                      .state
                                      .attribute;
                                  ProductRoute.goProductPreviewPage(
                                    context: context,
                                    isEdit: true,
                                    preview: PreviewModel(
                                      category: category,
                                      currency: currency,
                                      unit: unit,
                                      brand: brand,
                                      price: num.tryParse(price.text),
                                      phone: phone.text,
                                      title: title.text,
                                      desc: desc.text,
                                      images: state.images,
                                      urls: state.listOfUrls,
                                      video: state.video,
                                      attributes: list.map((attribute)=> state.attributes.firstWhere(
                                          ((e) => e.attributeId == attribute.id),
                                          orElse: () => SelectedAttribute())).toList()
                                    ),
                                  );
                                }
                              },
                            ),
                            8.verticalSpace,
                            CustomButton(
                                title: TrKeys.toPublish,
                                bgColor: colors.textBlack,
                                titleColor: colors.textWhite,
                                isLoading: state.isLoading,
                                changeColor: true,
                                onTap: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    if (state.images.isEmpty &&
                                        state.listOfUrls.isEmpty) {
                                      AppHelpers.errorSnackBar(
                                          context: context,
                                          message: AppHelpers.getTranslation(
                                              TrKeys.pleaseSelectImage));
                                      return;
                                    }
                                    event.add(EditProductEvent.editProduct(
                                      context: context,
                                      productRequest: ProductRequest(
                                        categoryId: category?.id ??
                                            state.product?.category?.id,
                                        unitId:
                                            unit?.id ?? state.product?.unit?.id,
                                        brandId: brand?.id ??
                                            state.product?.brand?.id,
                                        price: num.tryParse(price.text),
                                        title: title.text,
                                        desc: desc.text,
                                        phone: phone.text,
                                        ageLimit: 12,
                                        regionId: country?.regionId,
                                        type: type ??
                                            AppConstants.productTypes.first,
                                        condition: condition,
                                        name: name.text,
                                        email: email.text,
                                      ),
                                      updated: () {
                                        ProductRoute.goUserProductsPage(
                                            context: context);
                                      },
                                    ));
                                  }
                                }),
                            24.verticalSpace,
                          ],
                        ),
                      );
              },
            ),
          );
        });
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
      AppHelpers.getTranslation(TrKeys.editProduct),
      style: CustomStyle.interSemi(color: colors.textBlack, size: 18),
    ),
  );
}
