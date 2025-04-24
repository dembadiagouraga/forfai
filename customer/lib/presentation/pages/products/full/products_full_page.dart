import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/filter/filter_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/components/no_item.dart';
import 'package:quick/presentation/components/shimmer/full_products_shimmer.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:remixicon/remixicon.dart';

import 'widgets/category_list.dart';
import 'widgets/products_grid.dart';

class ProductsFullPage extends StatefulWidget {
  final int? categoryId;
  final int? userId;

  const ProductsFullPage({super.key, this.categoryId, this.userId});

  @override
  State<ProductsFullPage> createState() => _ProductsFullPageState();
}

class _ProductsFullPageState extends State<ProductsFullPage> {
  final isLtr = LocalStorage.getLangLtr();
  late RefreshController simpleController;
  bool isFilter = false;

  @override
  void initState() {
    simpleController = RefreshController();

    super.initState();
  }

  void onLoading(RefreshController refreshController, FilterState stateFilter) {
    context.read<ProductBloc>().add(ProductEvent.fetchFullProducts(
          context: context,
          controller: refreshController,
          categoryId: widget.categoryId,
          userId: widget.userId,
        ));
  }

  void onRefresh(RefreshController refreshController, FilterState stateFilter) {
    context.read<ProductBloc>().add(ProductEvent.fetchFullProducts(
          context: context,
          controller: refreshController,
          isRefresh: true,
          categoryId: widget.categoryId,
          userId: widget.userId,
        ));
  }

  @override
  void dispose() {
    simpleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return CustomScaffold(
          body: (colors) => SafeArea(
            bottom: false,
            child: state.fullProducts.isNotEmpty || state.isLoading
                ? BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, stateFilter) {
                      return Column(
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
                                      onTap: () => AppRoute.goSearchPage(
                                        context: context,
                                        categoryId: widget.categoryId,
                                        userId: widget.userId,
                                      ),
                                      readOnly: true,
                                      filled: true,
                                      prefixIcon: Icon(
                                        Remix.search_2_line,
                                        color: colors.textBlack,
                                        size: 21.r,
                                      ),
                                      hint: AppHelpers.getTranslation(
                                          TrKeys.search),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: state.isLoading
                                ? const FullProductsShimmer()
                                : SingleChildScrollView(
                                    padding:
                                        REdgeInsets.symmetric(vertical: 24),
                                    child: Column(
                                      children: [
                                        CategoryList(
                                          colors: colors,
                                          category: state.fullProducts.first,
                                        ),
                                        ProductsGrid(
                                          category: state.fullProducts.first,
                                          colors: colors,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      );
                    },
                  )
                : NoItem(colors: colors, title: TrKeys.noProduct),
          ),
        );
      },
    );
  }
}
