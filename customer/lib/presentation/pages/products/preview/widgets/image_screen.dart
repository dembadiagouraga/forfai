import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/detail/product_detail_bloc.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/blur_wrap.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'images_list.dart';

class ImageScreen extends StatelessWidget {
  final CustomColorSet colors;
  final List<Galleries>? galleries;
  final List<String>? images;
  final PageController controller;
  final ScrollController scrollController;

  const ImageScreen({
    super.key,
    required this.colors,
    required this.galleries,
    required this.controller,
    required this.scrollController,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    int itemCount = (images?.length ?? 0) + (galleries?.length ?? 0);
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
              child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  return PageView.builder(
                      itemCount: itemCount,
                      controller: controller,
                      onPageChanged: (index) {
                        context.read<ProductDetailBloc>().add(
                            ProductDetailEvent.selectImage(
                                image: galleries![index],
                                jumpTo: true,
                                nextImageTo: true));
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ProductRoute.goOnlyImagePage(
                              context: context,
                              galleries: galleries,
                              images: images,
                              selectIndex: galleries?.indexOf(state.selectImage ?? Galleries()) ?? 0,
                              product:
                                  ProductData(user: LocalStorage.getUser()),
                            );
                          },
                          child: CustomNetworkImage(
                            fileImage: (galleries?.length ?? 0) > index
                                ? null
                                : File(
                                    images?[index - (galleries?.length ?? 0)] ??
                                        ""),
                            url: (galleries?.length ?? 0) > index
                                ? galleries![index].path
                                : null,
                            preview: (galleries?.length ?? 0) > index
                                ? galleries![index].preview
                                : null,
                            height: 380,
                            width: double.infinity,
                            fit: BoxFit.contain,
                            radius: 0,
                          ),
                        );
                      });
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 360.r,
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
                      const Spacer(),
                      IconButton(
                          splashColor: CustomStyle.transparent,
                          highlightColor: CustomStyle.transparent,
                          onPressed: () {},
                          icon: Icon(
                            Remix.stack_line,
                            size: 24.r,
                            color: colors.textWhite,
                          )),
                      IconButton(
                          splashColor: CustomStyle.transparent,
                          highlightColor: CustomStyle.transparent,
                          onPressed: () {},
                          icon: Icon(
                            Remix.heart_3_line,
                            size: 24.r,
                            color: colors.textWhite,
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                if ((galleries?.isNotEmpty ?? false) ||
                    (images?.isNotEmpty ?? false))
                  BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, state) {
                      return ImagesList(
                        urls: galleries ?? [],
                        images: images ?? [],
                        selectImage: state.selectImage?.path ?? '',
                        controller: scrollController,
                      );
                    },
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
