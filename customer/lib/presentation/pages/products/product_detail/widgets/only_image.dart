import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/products/detail/product_detail_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/components/media/video_page.dart';
import 'package:quick/presentation/pages/products/product_detail/widgets/bottom_widget.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:photo_view/photo_view.dart';

class OnlyImagePage extends StatefulWidget {
  final List<Galleries>? galleries;
  final List<String>? images;
  final ProductData? product;
  final int? selectIndex;

  const OnlyImagePage({
    super.key,
    required this.galleries,
    required this.selectIndex,
    required this.product,
    this.images,
  });

  @override
  State<OnlyImagePage> createState() => _OnlyImagePageState();
}

class _OnlyImagePageState extends State<OnlyImagePage> {
  // Helper method to fix double storage path issue
  String? _fixImagePath(String? inputUrl) {
    if (inputUrl == null || inputUrl.isEmpty) {
      return "";
    }

    if (inputUrl.startsWith('http')) {
      // Fix double storage in URLs
      if (inputUrl.contains('/storage/storage/')) {
        return inputUrl.replaceAll('/storage/storage/', '/storage/');
      }
      return inputUrl;
    }

    // Fix double storage path issue
    String pathToUse = inputUrl;

    // Remove leading slash if present
    if (pathToUse.startsWith('/')) {
      pathToUse = pathToUse.substring(1);
    }

    // Fix double storage path issue
    if (pathToUse.startsWith('storage/')) {
      pathToUse = pathToUse.replaceFirst('storage/', '');
    }

    return "${AppConstants.imageUrl}$pathToUse";
  }
  late ScrollController scrollController;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.selectIndex ?? 0);
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int itemCount =
        (widget.images?.length ?? 0) + (widget.galleries?.length ?? 0);
    return CustomScaffold(
      body: (colors) => Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height,
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
              BlurWrap(
                radius: BorderRadius.circular(0),
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  decoration:
                      BoxDecoration(color: colors.black.withValues(alpha: 0.6)),
                  child: Column(
                    children: [
                      MediaQuery.paddingOf(context).top.verticalSpace,
                      100.verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        height: (MediaQuery.sizeOf(context).height / 1.8),
                        child: PageView.builder(
                          controller: pageController,
                          onPageChanged: (index) {
                            if ((widget.galleries?.length ?? 0) > index) {
                              context.read<ProductDetailBloc>().add(
                                  ProductDetailEvent.selectImage(
                                      image: widget.galleries?[index] ??
                                          Galleries()));
                            } else {
                              context.read<ProductDetailBloc>().add(
                                  ProductDetailEvent.selectImage(
                                      image: Galleries()));
                            }
                            scrollController.animateTo(4.r * index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            ImageProvider? image;
                            if ((widget.galleries?.length ?? 0) > index) {
                              // Fix double storage issue
                              String? imagePath;
                              if (widget.galleries![index].preview == null) {
                                imagePath = _fixImagePath(widget.galleries?[index].path);
                              } else {
                                imagePath = _fixImagePath(widget.galleries?[index].preview);
                              }
                              image = CachedNetworkImageProvider(imagePath ?? "");
                            } else {
                              image = null;
                            }
                            return Stack(
                              children: [
                                PhotoView(
                                  minScale: 0.2,
                                  initialScale:
                                      PhotoViewComputedScale.contained,
                                  backgroundDecoration: const BoxDecoration(),
                                  imageProvider: ((widget.galleries?.length ??
                                              0) >
                                          index)
                                      ? image
                                      : FileImage(File(widget.images?[index -
                                              (widget.galleries?.length ??
                                                  0)] ??
                                          "")),
                                ),
                                if ((widget.galleries?.length ?? 0) > index)
                                  if (widget.galleries?[index].preview != null)
                                    Positioned.fill(
                                      child: Center(
                                        child: ButtonEffectAnimation(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoPage(
                                                            url: widget
                                                                .galleries?[
                                                                    index]
                                                                .path)));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8.r),
                                            decoration: BoxDecoration(
                                                color: colors.textWhite
                                                    .withValues(alpha: 0.8),
                                                shape: BoxShape.circle),
                                            child: const Icon(
                                              Remix.play_fill,
                                              color: CustomStyle.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                              ],
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child:
                            BlocBuilder<ProductDetailBloc, ProductDetailState>(
                          buildWhen: (p, n) {
                            return p.selectImage?.id != n.selectImage?.id;
                          },
                          builder: (context, state) {
                            return ListView.builder(
                                controller: scrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.galleries?.length ?? 0,
                                itemBuilder: (context, i) {
                                  return Container(
                                    margin: EdgeInsets.all(6.r),
                                    padding: EdgeInsets.all(1.r),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.radius.r),
                                        border: Border.all(
                                            color: state.selectImage?.id ==
                                                    widget.galleries?[i].id
                                                ? colors.primary
                                                : colors.icon,
                                            width: 1.5)),
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<ProductDetailBloc>().add(
                                            ProductDetailEvent.selectImage(
                                                image: widget.galleries?[i] ??
                                                    Galleries()));
                                        pageController.animateToPage(i,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      child: CustomNetworkImage(
                                        enableButton: false,
                                        width: 80,
                                        height: 80,
                                        url: widget.galleries?[i].path,
                                        preview: widget.galleries?[i].preview,
                                        radius: AppConstants.radius,
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                      16.verticalSpace,
                      BottomWidget(colors: colors)
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Remix.arrow_left_s_line,
                              color: colors.white,
                              size: 26.r,
                            )),
                        4.horizontalSpace,
                        Container(
                          padding: REdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: colors.white,
                              borderRadius:
                                  BorderRadius.circular(AppConstants.radius)),
                          child: CustomNetworkImage(
                            url: widget.product?.user?.img,
                            name: widget.product?.user?.firstname,
                            height: 32,
                            width: 32,
                            radius: 16,
                          ),
                        ),
                        6.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product?.user?.firstname ??
                                    AppHelpers.getTranslation(TrKeys.unKnow),
                                style: CustomStyle.interNormal(
                                    color: colors.white, size: 14),
                                maxLines: 1,
                              ),
                              Text(
                                "${AppHelpers.getTranslation(TrKeys.id).toUpperCase()} ${widget.product?.user?.id ?? 0}",
                                style: CustomStyle.interRegular(
                                    color: colors.textHint, size: 14),
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<ProductDetailBloc, ProductDetailState>(
                          builder: (context, state) {
                            return LikeButton(
                                colors: colors,
                                isActive: LocalStorage.getLikedProductsList()
                                    .contains(widget.product?.id),
                                onTap: () {
                                  LocalStorage.setLikedProductsList(
                                      widget.product?.id ?? 0);
                                  context.read<ProductDetailBloc>().add(
                                      const ProductDetailEvent.updateState());
                                });
                          },
                        ),
                        16.horizontalSpace,
                      ],
                    ),
                    24.verticalSpace,
                    BlocBuilder<ProductDetailBloc, ProductDetailState>(
                      builder: (context, state) {
                        if (widget.galleries?.any(
                                (e) => state.selectImage?.path == e.path) ??
                            false) {
                          return Text(
                            "${((widget.galleries?.indexOf(state.selectImage ?? Galleries()) ?? 0) + 1)}/$itemCount",
                            style: CustomStyle.interNormal(
                                color: colors.white, size: 18),
                          );
                        } else if (widget.images?.any(
                                (e) => state.selectImage?.path == e) ??
                            false) {
                          return Text(
                            "${((widget.images?.indexOf(state.selectImage?.path ?? '') ?? 0) + 1)}/$itemCount",
                            style: CustomStyle.interNormal(
                                color: colors.white, size: 18),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
