import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../home/widgets/search_field.dart';
import 'widgets/category_item.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late RefreshController categoryRefresh;
  late RefreshController refreshController;
  late RefreshController shopsRefresh;
  late RefreshController storyRefresh;
  final isLtr = LocalStorage.getLangLtr();

  @override
  void initState() {
    categoryRefresh = RefreshController();
    refreshController = RefreshController();
    shopsRefresh = RefreshController();
    storyRefresh = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    categoryRefresh.dispose();
    refreshController.dispose();
    shopsRefresh.dispose();
    storyRefresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(top: 8.r),
          child: Column(
            children: [
              20.verticalSpace,
              _search(colors),
              Expanded(child: _categories(colors))
            ],
          ),
        ),
      ),
    );
  }

  Widget _search(CustomColorSet colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PopButton(colors: colors),
          8.horizontalSpace,
          Expanded(
            child: SearchField(colors: colors),
          ),
        ],
      ),
    );
  }

  Widget _categories(CustomColorSet colors) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: () {
        context.read<CategoryBloc>()
          ..add(CategoryEvent.selectCategory(context: context))
          ..add(
            CategoryEvent.fetchCategory(
              context: context,
              controller: refreshController,
              isRefresh: true,
            ),
          );
      },
      onLoading: () {
        context.read<CategoryBloc>().add(CategoryEvent.fetchCategory(
            context: context, controller: refreshController));
      },
      child:
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        return state.isLoadingCategory
            ? Loading()
            : state.categories.isNotEmpty
                ? ListView.builder(
                    key: const PageStorageKey<String>("list"),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding:
                        REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return CategoryListItem(
                          colors: colors,
                          category: state.categories[index],
                          selectCategory: state.selectCategory,
                          selectCategoryTwo: state.selectCategoryTwo,
                          onTap: () {
                            context.read<CategoryBloc>().add(
                                  CategoryEvent.selectCategory(
                                      context: context,
                                      category: state.categories[index]),
                                );
                          },
                          onTwoTap: (value) {
                            context.read<CategoryBloc>().add(
                                CategoryEvent.selectCategoryTwo(
                                    context: context, category: value));
                          },
                          onLastTap: (value) async {
                            await ProductRoute.goProductList(
                                context: context,
                                title: value?.translation?.title ?? "",
                                categoryId: value?.id);
                            if (context.mounted) {
                              context
                                  .read<ProductBloc>()
                                  .add(const ProductEvent.updateState());
                            }
                          });
                    })
                : const SizedBox.shrink();
      }),
    );
  }
}
