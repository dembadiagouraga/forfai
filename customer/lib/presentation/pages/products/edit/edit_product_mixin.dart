part of 'edit_product_page.dart';

mixin EditProductMixin on State<EditProductPage> {
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
    title = TextEditingController(
      text: widget.product.translation?.title ?? '',
    );
    desc = TextEditingController(
      text: widget.product.translation?.description ?? '',
    );
    price = TextEditingController(text: "${widget.product.price ?? 0}");
    final user = LocalStorage.getUser();
    phone = TextEditingController(
      text: widget.product.phone ?? user.phone ?? '',
    );
    condition = widget.product.condition ?? user.phone ?? '';
    email =
        TextEditingController(text: widget.product.email ?? user.email ?? '');
    name = TextEditingController(
        text: widget.product.sellerName ?? user.firstname ?? '');
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
}
