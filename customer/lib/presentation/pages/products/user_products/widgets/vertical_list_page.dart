import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/user_products/user_product_bloc.dart';
import 'package:quick/domain/model/model/product_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/no_item.dart';
import 'package:quick/presentation/components/product_items/user_product_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:quick/presentation/style/theme/theme.dart';

class VerticalListPage extends StatelessWidget {
  final List<ProductData> list;
  final CustomColorSet colors;
  final RefreshController refreshController;
  final VoidCallback onLoading;
  final VoidCallback onRefresh;

  const VerticalListPage({
    super.key,
    required this.list,
    required this.refreshController,
    required this.onLoading,
    required this.onRefresh,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      onLoading: onLoading,
      onRefresh: onRefresh,
      child: list.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(right: 16.r, left: 16.r, top: 16.r),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return UserProductItem(
                  product: list[index],
                  refresh: () {
                    context.read<UserProductBloc>().add(
                        UserProductEvent.fetchActiveProduct(
                            context: context,
                            isRefresh: true,
                            controller: refreshController));
                  },
                );
              })
          : NoItem(colors: colors, title: TrKeys.noProduct),
    );
  }
}
