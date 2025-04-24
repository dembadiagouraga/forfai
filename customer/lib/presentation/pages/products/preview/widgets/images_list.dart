import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/style.dart';

class ImagesList extends StatelessWidget {
  final List<Galleries> urls;
  final List<String> images;
  final String selectImage;
  final ScrollController controller;

  const ImagesList({
    super.key,
    required this.urls,
    required this.selectImage,
    required this.controller,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: BlurWrap(
        radius: BorderRadius.circular(AppConstants.radius.r),
        child: Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
              color: CustomStyle.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppConstants.radius.r)),
          child: SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              ...urls.map((e) => ButtonEffectAnimation(
                    onTap: () {},
                    child: Container(
                      margin: REdgeInsets.symmetric(horizontal: 2),
                      padding: REdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: selectImage == e.path
                            ? CustomStyle.white
                            : CustomStyle.transparent,
                        borderRadius: BorderRadius.circular(
                            (AppConstants.radius / 1.2).r),
                      ),
                      child: CustomNetworkImage(
                        enableButton: false,
                        url: e.path ?? '',
                        preview: e.preview,
                        height: 44,
                        width: 44,
                        radius: AppConstants.radius / 1.3,
                      ),
                    ),
                  )),
              ...images.map((e) => ButtonEffectAnimation(
                    onTap: () {
                      // context.read<ProductDetailBloc>().add(
                      //     ProductDetailEvent.selectImage(
                      //         image: e, nextImageTo: true));
                    },
                    child: Container(
                      margin: REdgeInsets.symmetric(horizontal: 2),
                      padding: REdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: selectImage == e
                            ? CustomStyle.white
                            : CustomStyle.transparent,
                        borderRadius: BorderRadius.circular(
                            (AppConstants.radius / 1.2).r),
                      ),
                      child: CustomNetworkImage(
                        enableButton: false,
                        fileImage: File(e),
                        height: 44,
                        width: 44,
                        radius: AppConstants.radius / 1.3,
                        url: '',
                      ),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
