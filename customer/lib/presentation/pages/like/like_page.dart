import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';

import 'package:quick/presentation/components/shimmer/products_shimmer.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../products/list/widgets/simple_list_page.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  late RefreshController likeRefresh;
  final isLtr = LocalStorage.getLangLtr();

  @override
  void initState() {
    likeRefresh = RefreshController();
    context.read<ProductBloc>()
      .add(ProductEvent.fetchLikeProduct(context: context));
    super.initState();
  }

  @override
  void dispose() {
    likeRefresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return _like(state, colors, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _like(
      ProductState state, CustomColorSet colors, BuildContext context) {
    return state.isLoadingLike
        ? const ProductsShimmer()
        : state.isLoadingLike || state.likeProducts.isNotEmpty
            ? SimpleListPage(
                list: state.likeProducts,
                refreshController: likeRefresh,
                onRefresh: () {
                  context.read<ProductBloc>().add(ProductEvent.fetchLikeProduct(
                      context: context,
                      controller: likeRefresh,
                      isRefresh: true));
                },
              )
            : _noItem(colors);
  }

  _noItem(CustomColorSet colors){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/no_like.png'),
          24.verticalSpace,
          Text(
            AppHelpers.getTranslation(TrKeys.stillEmpty),
            style: CustomStyle.interSemi(color: colors.textBlack, size: 16),
          ),
          4.verticalSpace,
          Text(
            AppHelpers.getTranslation(TrKeys.toAddProducts),
            style: CustomStyle.interRegular(color: colors.textBlack, size: 14),
          ),
          124.verticalSpace,
        ],
      ),
    );
  }

}
