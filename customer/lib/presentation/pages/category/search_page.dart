import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/application/search/search_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'widgets/search_list_item.dart';

class SearchPage extends StatefulWidget {
  final int? userId;
  final int? categoryId;

  const SearchPage({super.key, this.userId, this.categoryId});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  final isLtr = LocalStorage.getLangLtr();
  final _delayed = Delayed(milliseconds: 700);

  @override
  void initState() {
    searchController = SearchController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Row(
                children: [
                  PopButton(colors: colors),
                  8.horizontalSpace,
                  Expanded(
                    child: SizedBox(
                      height: 52.r,
                      child: CustomTextFormField(
                        controller: searchController,
                        autoFocus: true,
                        filled: true,
                        prefixIcon: Icon(
                          Remix.search_2_line,
                          color: colors.textBlack,
                          size: 21.r,
                        ),
                        hint: AppHelpers.getTranslation(TrKeys.search),
                        onChanged: (s) {
                          _delayed.run(() {
                            if (s.isNotEmpty) {
                              LocalStorage.setSearchRecentlyList(s);
                              if (widget.userId != null) {
                                context.read<SearchBloc>()
                                  ..add(SearchEvent.setQuery(
                                      query: s, userId: widget.userId))
                                  ..add(SearchEvent.searchProduct(
                                      context: context));
                                return;
                              }
                              context.read<SearchBloc>()
                                ..add(SearchEvent.setQuery(query: s))
                                ..add(SearchEvent.searchBrand(context: context))
                                ..add(SearchEvent.searchCategory(
                                    context: context))
                                ..add(SearchEvent.searchProduct(
                                    context: context));
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return state.query.isEmpty
                    ? _recently(colors)
                    : Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          children: [
                            SearchItem(
                                title: AppHelpers.getTranslation(TrKeys.products),
                                colors: colors,
                                list: state.products,
                                onTap: (index) async {
                                  await ProductRoute.goProductPage(
                                      context: context,
                                      product: state.products[index]);
                                  if (context.mounted) {
                                    context
                                        .read<ProductBloc>()
                                        .add(const ProductEvent.updateState());
                                  }
                                },
                                isLoading: state.isProductLoading,
                                query: state.query),
                            SearchItem(
                                title: AppHelpers.getTranslation(TrKeys.categories),
                                colors: colors,
                                list: state.categories,
                                onTap: (index) async {
                                  await ProductRoute.goProductList(
                                      context: context,
                                      title: state.categories[index].translation
                                              ?.title ??
                                          "",
                                      categoryId: state.categories[index].id);
                                  if (context.mounted) {
                                    context
                                        .read<ProductBloc>()
                                        .add(const ProductEvent.updateState());
                                  }
                                },
                                isLoading: state.isCategoryLoading,
                                query: state.query),
                            SearchItem(
                                title: AppHelpers.getTranslation(TrKeys.brand),
                                colors: colors,
                                list: state.brands,
                                onTap: (index) async {
                                  await ProductRoute.goProductList(
                                      context: context,
                                      title: state.brands[index].title ?? "",
                                      categoryId: state.brands[index].id);
                                  if (context.mounted) {
                                    context
                                        .read<ProductBloc>()
                                        .add(const ProductEvent.updateState());
                                  }
                                },
                                isBrand: true,
                                isLoading: state.isBrandLoading,
                                query: state.query),
                          ],
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _recently(CustomColorSet colors) {
    final List list = LocalStorage.getSearchRecentlyList();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.recently),
                    style: CustomStyle.interSemi(
                        color: colors.textBlack, size: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    LocalStorage.deleteSearchRecentlyList();
                    context
                        .read<SearchBloc>()
                        .add(const SearchEvent.updateRecently());
                  },
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.clearAll),
                    style:
                        CustomStyle.interSemi(color: CustomStyle.red, size: 16),
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ButtonEffectAnimation(
                      onTap: () {
                        searchController.text = list[index];
                        if (widget.userId != null) {
                          context.read<SearchBloc>()
                            ..add(SearchEvent.setQuery(
                                query: list[index], userId: widget.userId))
                            ..add(SearchEvent.searchProduct(context: context));
                          return;
                        }
                        context.read<SearchBloc>()
                          ..add(SearchEvent.setQuery(query: list[index]))
                          ..add(SearchEvent.searchBrand(context: context))
                          ..add(SearchEvent.searchCategory(context: context))
                          ..add(SearchEvent.searchProduct(context: context));
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Remix.time_line,
                                color: colors.textHint,
                              ),
                              8.horizontalSpace,
                              Text(
                                list[index],
                                style: CustomStyle.interNormal(
                                    color: colors.textBlack, size: 14),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    LocalStorage.removeSearchRecentlyList(
                                        list[index]);
                                    context.read<SearchBloc>().add(
                                        const SearchEvent.updateRecently());
                                  },
                                  icon: Icon(
                                    Remix.close_line,
                                    color: colors.textHint,
                                  ))
                            ],
                          ),
                          8.verticalSpace,
                          Divider(color: colors.textHint)
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
