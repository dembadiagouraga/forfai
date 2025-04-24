import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/domain/model/model/preview_model.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/pages/products/product_detail/widgets/seller_info.dart';
import 'package:quick/presentation/style/style.dart';
import 'widgets/attribute_info.dart';
import 'widgets/image_screen.dart';
import '../product_detail/widgets/product_info.dart';

class ProductPreviewPage extends StatefulWidget {
  final PreviewModel product;
  final bool isEdit;

  const ProductPreviewPage({
    super.key,
    required this.product,
    required this.isEdit,
  });

  @override
  State<ProductPreviewPage> createState() => _ProductPreviewPageState();
}

class _ProductPreviewPageState extends State<ProductPreviewPage> {
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
      body: (colors) => Stack(
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
                    galleries: widget.product.urls,
                    images: widget.product.images,
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Remix.time_line,
                              size: 21.r,
                              color: colors.textBlack,
                            ),
                            6.horizontalSpace,
                            Expanded(
                              child: Text(
                                TimeService.dateFormatProduct(DateTime.now()),
                                style: CustomStyle.interNormal(
                                    color: colors.textBlack, size: 14),
                                maxLines: 1,
                              ),
                            ),
                            12.verticalSpace,
                          ],
                        ),
                        6.verticalSpace,
                        Text(
                          widget.product.title ?? "",
                          style: CustomStyle.interSemi(
                              color: colors.textBlack, size: 20),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        8.verticalSpace,
                        AutoSizeText(
                          AppHelpers.numberFormat(widget.product.price ?? 0),
                          style: CustomStyle.interBold(
                              color: colors.textBlack, size: 24),
                          maxLines: 1,
                          minFontSize: 16,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  12.verticalSpace,
                  SellerInfo(
                    colors: colors,
                    user: LocalStorage.getUser(),
                  ),
                  ProductInfo(
                    colors: colors,
                    description: widget.product.desc,
                  ),
                  AttributeInfo(
                    colors: colors,
                    attributes: widget.product.attributes,
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
        ],
      ),
    );
  }
}
