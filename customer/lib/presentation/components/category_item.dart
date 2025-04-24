import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/domain/model/model/category_model.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class CategoryItem extends StatelessWidget {
  final CategoryData? categoryData;
  final CustomColorSet colors;

  const CategoryItem(
      {super.key, required this.categoryData, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: () async {
        final event = context.read<CategoryBloc>();
        if (categoryData?.type == 'main') {
          event.add(CategoryEvent.selectCategory(
            context: context,
            category: categoryData,
          ));
        } else {
          event.add(CategoryEvent.selectCategoryTwo(
            context: context,
            category: categoryData,
          ));
        }
        await ProductRoute.goProductFull(
          context: context,
          categoryId: categoryData?.id,
        );
        if (context.mounted) {
          context.read<ProductBloc>().add(const ProductEvent.updateState());
        }
      },
      child: SizedBox(
        width: 108.r,
        child: Column(
          children: [
            Container(
              padding: REdgeInsets.all(4),
              decoration: BoxDecoration(
                color: CustomStyle.subCategory,
                borderRadius: BorderRadius.circular(AppConstants.radius.r),
              ),
              child: CustomNetworkImage(
                url: categoryData?.img,
                height: 100,
                width: 100,
                radius: AppConstants.radius,
                fit: BoxFit.contain,
              ),
            ),
            8.verticalSpace,
            Flexible(
              child: Text(
                categoryData?.translation?.title ?? "",
                style: CustomStyle.interNormal(color: colors.textBlack, size: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
