import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/products/detail/product_detail_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';
import 'widgets/attribute_info.dart';
import 'widgets/product_tags.dart';
import 'widgets/seller_info.dart';
import 'widgets/bottom_widget.dart';
import 'widgets/image_screen.dart';
import 'widgets/product_info.dart';
import 'widgets/product_title.dart';
import 'widgets/related_and_viewed_products.dart';
import 'widgets/voice_note_player.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late PageController pageController;
  late ScrollController scrollController;

  @override
  void initState() {
    pageController = PageController();
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
    return CustomScaffold(
      body: (colors) => BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listenWhen: (p, n) {
          return p.selectImage?.id != n.selectImage?.id ||
              p.galleries.length != n.galleries.length;
        },
        listener: (context, state) {
          if (state.galleries.length == 1) {
            return;
          }
          if (!state.jumpTo) {
            pageController.jumpToPage(
                state.galleries.indexOf(state.selectImage ?? Galleries()));
          }
          if (!state.nextImageTo) {
            scrollController.animateTo(
                state.galleries.indexOf(state.selectImage ?? Galleries()) *
                    44.r,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          }
          if (scrollController.position.maxScrollExtent >
              state.galleries.indexOf(state.selectImage ?? Galleries()) *
                  44.r) {
            scrollController.animateTo(
                state.galleries.indexOf(state.selectImage ?? Galleries()) *
                    44.r,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 120.r),
                  child: Column(
                    children: [
                      ImageScreen(
                        scrollController: scrollController,
                        controller: pageController,
                        colors: colors,
                        product: state.product,
                        selectImage: state.selectImage,
                        galleries: state.galleries,
                      ),
                      12.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitle(
                            product: state.product,
                            colors: colors,
                          ),
                          ProductTags(
                            colors: colors,
                            product: state.product,
                          ),
                          SellerInfo(
                            colors: colors,
                            user: state.product?.user,
                          ),
                          ProductInfo(
                            colors: colors,
                            description:
                                state.product?.translation?.description,
                          ),
                          VoiceNotePlayer(
                            colors: colors,
                            voiceNoteUrl: state.product?.voiceNoteUrl,
                            voiceNoteDuration: state.product?.voiceNoteDuration,
                          ),
                          AttributeInfo(
                            colors: colors,
                            attributes: state.product?.attributes,
                          ),
                          RelatedAndViewedProducts(
                            colors: colors,
                            list: state.relatedProduct,
                            title: AppHelpers.getTranslation(
                                TrKeys.relatedProducts),
                          ),
                          RelatedAndViewedProducts(
                            colors: colors,
                            list: state.viewedProduct,
                            title:
                                AppHelpers.getTranslation(TrKeys.historyView),
                          ),
                          RelatedAndViewedProducts(
                            colors: colors,
                            list: state.buyWithProduct,
                            title: AppHelpers.getTranslation(
                                TrKeys.withThisProductAlsoBuy),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 4.r + MediaQuery.paddingOf(context).top,
                left: 16.r,
                child: BlurWrap(
                  radius: BorderRadius.circular(32.r),
                  child: Container(
                    color: CustomStyle.black.withValues(alpha: 0.5),
                    child: const PopButton(
                      color: CustomStyle.white,
                    ),
                  ),
                ),
              ),
              if (state.isLoading)
                IgnorePointer(
                  child: BlurWrap(
                    blur: 2,
                    radius: BorderRadius.circular(12),
                    child: Loading(),
                  ),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: (colors) =>
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state.isLoading) return SizedBox.shrink();
          return BottomWidget(colors: colors);
        },
      ),
    );
  }
}
