import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/category_model.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/category_item.dart';
import 'package:quick/presentation/components/title.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class CategoryList extends StatelessWidget {
  final CustomColorSet colors;
  final CategoryData category;

  const CategoryList({
    super.key,
    required this.colors,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return category.children?.isNotEmpty ?? false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: category.translation?.title ??
                    AppHelpers.getTranslation(TrKeys.categories),
                titleColor: colors.textBlack,
                subTitle: AppHelpers.getTranslation(TrKeys.seeAll),
                onTap: () => AppRoute.goAllCategoryPage(context,category: category),
              ),
              12.verticalSpace,
              SizedBox(
                height: 140.r,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    scrollDirection: Axis.horizontal,
                    itemCount: category.children?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.r),
                        child: CategoryItem(
                          colors: colors,
                          categoryData: category.children?[index],
                        ),
                      );
                    }),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
