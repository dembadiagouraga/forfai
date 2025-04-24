part of 'create_product_page.dart';

mixin CreateProductMixin on State<CreateProductPage> {
  late GlobalKey<FormState> formKey;
  late TextEditingController title;
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController desc;
  late TextEditingController price;
  late TextEditingController phone;

  CategoryData? category;
  BrandData? brand;
  UnitsData? unit;
  CurrencyData? currency;
  String? type;
  String? condition;
  CountryModel? country;
  int? cityId;
  int? areaId;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    title = TextEditingController();
    desc = TextEditingController();
    price = TextEditingController();
    final user = LocalStorage.getUser();
    phone = TextEditingController(text: user.phone ?? '');
    email = TextEditingController(text: user.email ?? '');
    name = TextEditingController(text: user.firstname ?? '');
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    price.dispose();
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  _onSave() {
    if (formKey.currentState?.validate() ?? false) {
      final event = context.read<CreateProductBloc>();
      event.add(CreateProductEvent.createProduct(
          context: context,
          productRequest: ProductRequest(
            categoryId: category?.id,
            unitId: unit?.id,
            condition: condition,
            brandId: brand?.id,
            price: num.tryParse(price.text),
            title: title.text,
            desc: desc.text,
            cityId: cityId,
            countryId: country?.id,
            phone: phone.text,
            ageLimit: 12,
            regionId: country?.regionId,
            areaId: areaId,
            type: type ?? AppConstants.productTypes.first,
            name: name.text,
            email: email.text,
          ),
          created: (product) {
            AppRoute.goSelectAdsPage(
              context: context,
              product: ProductData(
                img: product?.img,
                translation: Translation(title: title.text),
                categoryId: category?.id,
                area: AreaModel(
                  regionId: country?.regionId,
                  countryId: country?.id,
                  cityId: cityId,
                  id: areaId,
                ),
              ),
            );
          }));
    }
  }

  _onPreview(CreateProductState state) {
    if (state.images.isEmpty) {
      AppHelpers.errorSnackBar(
          context: context,
          message: AppHelpers.getTranslation(TrKeys.pleaseSelectImage));
      return;
    }
    if (formKey.currentState?.validate() ?? false) {
      List<AttributesData> list = context.read<AttributeBloc>().state.attribute;
      ProductRoute.goProductPreviewPage(
        context: context,
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
            video: state.video,
            attributes: list
                .map((attribute) => state.attributes.firstWhere(
                    ((e) => e.attributeId == attribute.id),
                    orElse: () => SelectedAttribute()))
                .toList()),
      );
    }
  }
}
