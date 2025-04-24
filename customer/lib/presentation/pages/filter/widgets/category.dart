import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/filter/filter_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'category_item.dart';

class FilterCategoryPage extends StatefulWidget {
  const FilterCategoryPage({super.key});

  @override
  State<FilterCategoryPage> createState() => _FilterCategoryPageState();
}

class _FilterCategoryPageState extends State<FilterCategoryPage> {
  late RefreshController categoryRefresh;
  late RefreshController refreshController;
  late TabController tabController;
  final isLtr = LocalStorage.getLangLtr();

  @override
  void initState() {
    categoryRefresh = RefreshController();
    refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    categoryRefresh.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: (colors) => CustomAppBar(
        colors: colors,
        context: context,
        title: TrKeys.categories,
      ),
      body: (colors) => SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: () {
          context.read<CategoryBloc>().add(
                CategoryEvent.fetchCategory(
                    context: context,
                    controller: refreshController,
                    isRefresh: true),
              );
        },
        onLoading: () {
          context.read<CategoryBloc>().add(CategoryEvent.fetchCategory(
              context: context, controller: refreshController));
        },
        child:
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
          return state.categories.isNotEmpty || state.isLoadingCategory
              ? ListView.builder(
                  key: const PageStorageKey<String>("list"),
                  shrinkWrap: true,
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return FilterCategoryItem(
                        colors: colors,
                        category: state.categories[index],
                        selectCategory: state.selectCategory,
                        selectCategoryTwo: state.selectCategoryTwo,
                        onTap: () {
                          context.read<CategoryBloc>().add(
                                CategoryEvent.selectCategory(
                                  context: context,
                                  category: state.categories[index],
                                ),
                              );
                        },
                        onTwoTap: (value) {
                          context.read<CategoryBloc>().add(
                              CategoryEvent.selectCategoryTwo(
                                  context: context, category: value));
                        },
                        onLastTap: (value) async {
                          context.read<FilterBloc>()
                            ..add(FilterEvent.setCategory(category: value))
                            ..add(FilterEvent.fetchFilter(
                                context: context, isPrice: true));
                          Navigator.pop(context);
                        });
                  })
              : const SizedBox.shrink();
        }),
      ),
    );
  }
}
