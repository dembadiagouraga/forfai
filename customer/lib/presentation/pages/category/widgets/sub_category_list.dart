import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/presentation/components/category_item.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class SubCategoryList extends StatelessWidget {
  final CustomColorSet colors;
  const SubCategoryList({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return (state.selectCategoryTwo?.children?.isNotEmpty ?? false)
            ? GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(16.r),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 116.r,
                ),
                itemCount: state.selectCategoryTwo?.children?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4.r),
                    child: CategoryItem(
                      categoryData: state.selectCategoryTwo?.children?[index],
                      colors: colors,
                    ),
                  );
                })
            : GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(16.r),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 116.r,
                ),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4.r),
                    child: CategoryItem(categoryData: state.selectCategoryTwo, colors: colors,),
                  );
                });
      },
    );
  }
}
