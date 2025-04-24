part of 'app_route.dart';

abstract class ProductRoute {
  ProductRoute._();

  static goProductPage(
      {required BuildContext context, required ProductData product}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => ProductDetailBloc()
                ..add(ProductDetailEvent.fetchProductById(
                    context: context, product: product))
                ..add(ProductDetailEvent.fetchRelatedProduct(
                    context: context, slug: product.slug, isRefresh: true))
                ..add(ProductDetailEvent.fetchViewedProducts(
                    context: context, productId: product.id))),
          BlocProvider.value(value: context.read<ProductBloc>()),
          BlocProvider.value(value: context.read<MainBloc>()),
        ], child: const ProductPage()),
      ),
    );
  }

  static goProductPreviewPage({
    required BuildContext context,
    required PreviewModel preview,
    bool isEdit = false,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            if (!isEdit)
              BlocProvider.value(value: context.read<CreateProductBloc>()),
            if (isEdit)
              BlocProvider.value(value: context.read<EditProductBloc>()),
            BlocProvider(create: (context) => ProductDetailBloc()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child:
              ProductPreviewPage(product: preview.addVideo(), isEdit: isEdit),
        ),
      ),
    );
  }

  static goUserProductsPage({required BuildContext context}) async {
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<ProductBloc>()),
              BlocProvider.value(value: context.read<MainBloc>()),
              BlocProvider(
                create: (context) => UserProductBloc()
                  ..add(UserProductEvent.fetchActiveProduct(
                      context: context, isRefresh: true))
                  ..add(UserProductEvent.fetchUnActiveProduct(
                      context: context, isRefresh: true))
                  ..add(UserProductEvent.fetchWaitingProduct(
                      context: context, isRefresh: true)),
              )
            ],
            child: const UserProductsPage(),
          ),
        ),
        (route) => route.isFirst);
  }

  static goOnlyImagePage(
      {required BuildContext context,
      required List<Galleries>? galleries,
      List<String>? images,
      required ProductData? product,
      int? selectIndex}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductBloc()),
            BlocProvider.value(value: context.read<ProductDetailBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child: OnlyImagePage(
            galleries: galleries,
            images: images,
            selectIndex: selectIndex,
            product: product,
          ),
        ),
      ),
    );
  }

  static goCreateProductPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CurrencyBloc()
                ..add(CurrencyEvent.getCurrency(context: context)),
            ),
            BlocProvider(
              create: (context) =>
                  BrandBloc()..add(BrandEvent.fetchBrands(context: context)),
            ),
            BlocProvider(
              create: (context) => CategoryBloc()
                ..add(CategoryEvent.fetchCategory(context: context)),
            ),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
            BlocProvider(create: (context) => CreateProductBloc()),
            BlocProvider(create: (context) => GeminiBloc()),
            BlocProvider(create: (context) => ProfileBloc()),
            BlocProvider(create: (context) => SelectBloc()),
            BlocProvider(create: (context) => AttributeBloc()),
          ],
          child: const CreateProductPage(),
        ),
      ),
    );
  }

  static goEditProductPage(
      {required BuildContext context, required ProductData product}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CurrencyBloc()
                ..add(CurrencyEvent.getCurrency(context: context)),
            ),
            BlocProvider(
              create: (context) =>
                  BrandBloc()..add(BrandEvent.fetchBrands(context: context)),
            ),
            BlocProvider(
              create: (context) => CategoryBloc()
                ..add(CategoryEvent.fetchCategory(context: context)),
            ),
            BlocProvider(
              create: (context) => EditProductBloc()
                ..add(EditProductEvent.fetchProduct(product: product)),
            ),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
            BlocProvider(create: (context) => GeminiBloc()),
            BlocProvider(create: (context) => ProfileBloc()),
            BlocProvider(
              create: (context) =>
                  SelectBloc()..add(SelectEvent.changeIndex(selectIndex: 1)),
            ),
            BlocProvider(
              create: (context) => AttributeBloc()
                ..add(AttributeEvent.fetchAttributes(
                    context: context, categoryId: product.categoryId)),
            ),
          ],
          child: EditProductPage(product: product),
        ),
      ),
    );
  }

  static Future goProductFull({
    required BuildContext context,
    int? categoryId,
    int? userId,
  }) async =>
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<MainBloc>()),
              // BlocProvider.value(value: context.read<CategoryBloc>()),
              BlocProvider(
                create: (context) => ProductBloc()
                  ..add(ProductEvent.fetchFullProducts(
                    context: context,
                    isRefresh: true,
                    categoryId: categoryId,
                    userId: userId,
                  )),
              ),
              // BlocProvider.value(value: context.read<MainBloc>()),
              BlocProvider.value(value: context.read<CategoryBloc>()),
              BlocProvider(create: (context) => FilterBloc()),
            ],
            child: ProductsFullPage(categoryId: categoryId, userId: userId),
          ),
        ),
      );

  static Future goProductList({
    required BuildContext context,
    List<ProductData>? list,
    String? title,
    int? total,
    bool? isNew,
    bool? isPopular,
    int? categoryId,
    int? brandId,
    int? bannerId,
    int? userId,
  }) async =>
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProductBloc()
                  ..add(ProductEvent.fetchProducts(
                    context: context,
                    isRefresh: true,
                    list: list,
                    isNew: isNew,
                    isPopular: isPopular,
                    categoryId: categoryId,
                    bannerId: bannerId,
                    brandId: brandId == null ? null : [brandId],
                    userId: userId,
                  )),
              ),
              BlocProvider.value(value: context.read<MainBloc>()),
              BlocProvider(
                create: (context) => FilterBloc()
                  ..add(FilterEvent.selectSort(
                    type: isPopular ?? false
                        ? FilterType.popular
                        : FilterType.news,
                  ))
                  ..add(FilterEvent.fetchFilter(
                    context: context,
                    categoryId: categoryId,
                    isPrice: true,
                  ))
                  ..add(FilterEvent.setBrands(ids: [brandId ?? -1])),
              ),
            ],
            child: ProductsListPage(
              list: list,
              title: title,
              totalCount: total ?? 0,
              isPopular: isPopular,
              isNewProduct: isNew,
              categoryId: categoryId,
              brandId: brandId,
              bannerId: bannerId,
            ),
          ),
        ),
      );

  static goComparePage({required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
            BlocProvider(
                create: (context) => CompareBloc()
                  ..add(CompareEvent.fetchProducts(
                      context: context, isRefresh: true)))
          ],
          child: const CompareListPage(),
        ),
      ),
    );
  }

  static Future goCompareProductPage(
      {required BuildContext context, required List<ProductData> list}) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<CompareBloc>(),
            ),
            BlocProvider.value(value: context.read<ProductBloc>()),
            BlocProvider.value(value: context.read<MainBloc>()),
          ],
          child: CompareProductPage(list: list),
        ),
      ),
    );
  }
}
