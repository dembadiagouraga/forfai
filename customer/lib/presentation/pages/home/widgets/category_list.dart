import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/category_item.dart';
import 'package:quick/presentation/components/title.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class CategoryList extends StatelessWidget {
  final CustomColorSet colors;
  final RefreshController categoryRefresh;

  const CategoryList(
      {super.key, required this.colors, required this.categoryRefresh});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state.categories.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.verticalSpace,
                      TitleWidget(
                        title: AppHelpers.getTranslation(TrKeys.categories),
                        titleColor: colors.textBlack,
                        subTitle: AppHelpers.getTranslation(TrKeys.seeAll),
                        onTap: () => AppRoute.goAllCategoryPage(context),
                      ),
                      12.verticalSpace,
                      SizedBox(
                        height: 136.r,
                        child: SmartRefresher(
                          enablePullDown: false,
                          enablePullUp: true,
                          onLoading: () {
                            context.read<CategoryBloc>().add(
                                CategoryEvent.fetchCategory(
                                    context: context,
                                    controller: categoryRefresh));
                          },
                          controller: categoryRefresh,
                          scrollDirection: Axis.horizontal,
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16.r),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categories.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.r),
                                  child: CategoryItem(
                                    colors: colors,
                                    categoryData: state.categories[index],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink();
      },
    );
  }
}
