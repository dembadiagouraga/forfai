import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/detail/product_detail_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/blur_wrap.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'images_list.dart';

class ImageScreen extends StatelessWidget {
  final CustomColorSet colors;
  final ProductData? product;
  final List<Galleries>? galleries;
  final Galleries? selectImage;
  final PageController controller;
  final ScrollController scrollController;

  const ImageScreen({
    super.key,
    required this.colors,
    required this.galleries,
    required this.product,
    required this.selectImage,
    required this.controller,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<ProductDetailBloc>();
    return Stack(
      children: [
        SizedBox(
          height: 368.r,
          width: MediaQuery.sizeOf(context).width,
          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              return CustomNetworkImage(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                url: state.selectImage?.path,
                preview: state.selectImage?.preview,
                radius: 0,
              );
            },
          ),
        ),
        SizedBox(
          height: 368.r,
          child: BlurWrap(
            radius: BorderRadius.circular(0),
            child: Container(
              decoration: BoxDecoration(color: colors.black.withValues(alpha: 0.2)),
              child: PageView.builder(
                  itemCount: galleries?.length ?? 1,
                  controller: controller,
                  onPageChanged: (index) {
                    event.add(ProductDetailEvent.selectImage(
                        image: galleries![index],
                        jumpTo: true,
                        nextImageTo: true));
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ProductRoute.goOnlyImagePage(
                            context: context,
                            product: product,
                            galleries: galleries ?? [],
                            selectIndex: galleries
                                    ?.indexOf(selectImage ?? Galleries()) ??
                                0);
                      },
                      child: CustomNetworkImage(
                          url: galleries?[index].path,
                          preview: galleries?[index].preview,
                          height: 380,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          radius: 0),
                    );
                  }),
            ),
          ),
        ),
        SizedBox(
          height: 356.r,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top, left: 4.r, right: 8.r),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.r),
                  child: Row(
                    children: [
                      // PopButton(
                      //   color: CustomStyle.black,
                      // ),
                      const Spacer(),
                      if(LocalStorage.getToken().isNotEmpty)
                      IconButton(
                          splashColor: CustomStyle.transparent,
                          highlightColor: CustomStyle.transparent,
                          onPressed: () {
                            LocalStorage.setCompareList(product?.id ?? 0);
                            event.add(const ProductDetailEvent.updateState());
                          },
                          icon: LocalStorage.getCompareList()
                                  .contains(product?.id)
                              ? Icon(
                                  Remix.stack_fill,
                                  color: CustomStyle.primary,
                                  size: 24.r,
                                )
                              : Icon(
                                  Remix.stack_line,
                                  size: 24.r,
                                )),
                      IconButton(
                          splashColor: CustomStyle.transparent,
                          highlightColor: CustomStyle.transparent,
                          onPressed: () {
                            LocalStorage.setLikedProductsList(product?.id ?? 0);
                            context
                                .read<ProductBloc>()
                                .add(const ProductEvent.updateState());
                            event.add(const ProductDetailEvent.updateState());
                          },
                          icon: LocalStorage.getLikedProductsList()
                                  .contains(product?.id)
                              ? Icon(
                                  Remix.heart_3_fill,
                                  color: CustomStyle.red,
                                  size: 24.r,
                                )
                              : Icon(
                                  Remix.heart_3_line,
                                  size: 24.r,
                                )),
                    ],
                  ),
                ),
                const Spacer(),
                if (galleries?.isNotEmpty ?? false)
                  ImagesList(
                    list: galleries ?? [],
                    selectImageId: selectImage?.id ?? 0,
                    controller: scrollController,
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
