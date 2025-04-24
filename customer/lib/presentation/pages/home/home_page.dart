import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/banner/banner_bloc.dart';
import 'package:quick/application/blog/blog_bloc.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/application/story/story_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';

import 'package:quick/presentation/pages/home/widgets/all_product_list.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/ads_product_list.dart';
import 'widgets/category_list.dart';
import 'widgets/search_field.dart';

part 'home_page_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) {
        return SmartRefresher(
          controller: productRefresh,
          enablePullUp: true,
          onRefresh: onRefresh,
          onLoading: onLoading,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 16.r),
            children: [
              // StoriesList(colors: colors, storyRefresh: storyRefresh),
              if (LocalStorage.getUser().firstname != null) _welcome(colors),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: SearchField(colors: colors),
              ),
              // BannerList(
              //   pageController: pageController,
              //   colors: colors,
              //   controller: bannerRefresh,
              //   onLoading: () {
              //     context.read<BannerBloc>().add(BannerEvent.fetchBanner(
              //         context: context, controller: bannerRefresh));
              //   },
              // ),
              CategoryList(categoryRefresh: categoryRefresh, colors: colors),
              if (AppHelpers.getAds()) AdsProductList(colors: colors),
              AllProductList(colors: colors),
              80.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Padding _welcome(CustomColorSet colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppHelpers.getTranslation(TrKeys.welcome)},",
                style: CustomStyle.interSemi(color: colors.textBlack, size: 28),
              ),
              Text(
                "${LocalStorage.getUser().firstname} ${LocalStorage.getUser().lastname ?? ""} 👋 ",
                style:
                    CustomStyle.interNormal(color: colors.textBlack, size: 28),
              ),
              12.verticalSpace,
            ],
          );
        },
      ),
    );
  }
}
