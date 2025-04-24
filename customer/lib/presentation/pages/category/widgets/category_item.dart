import 'package:flutter/material.dart';
import 'package:quick/domain/model/model/category_model.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

class CategoryListItem extends StatelessWidget {
  final CategoryData category;
  final CategoryData? selectCategory;
  final CategoryData? selectCategoryTwo;
  final VoidCallback onTap;
  final ValueChanged onTwoTap;
  final ValueChanged onLastTap;
  final CustomColorSet colors;

  const CategoryListItem({
    super.key,
    required this.category,
    this.selectCategory,
    this.selectCategoryTwo,
    required this.onTap,
    required this.colors,
    required this.onTwoTap,
    required this.onLastTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectCategory?.id == null)
          Padding(
            padding: REdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: () {
                if(category.children?.isEmpty ?? true){
                  onLastTap.call(category);
                  return;
                }
                onTwoTap(null);
                onTap();
              },
              child: Container(
                padding: REdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: colors.newBoxColor,
                  borderRadius: BorderRadius.circular(AppConstants.radius),
                ),
                child: Row(children: [
                  CustomNetworkImage(
                    url: category.img,
                    height: 46,
                    width: 46,
                    fit: BoxFit.contain,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      category.translation?.title ?? '',
                      style: CustomStyle.interNormal(
                        color: colors.textBlack,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Icon(
                    Remix.arrow_right_s_line,
                    size: 21.r,
                    color: colors.textBlack,
                  ),
                  8.horizontalSpace,
                ]),
              ),
            ),
          ),
        if (selectCategory?.id == category.id)
          Column(
            children: [
              Padding(
                padding: REdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: REdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: colors.newBoxColor,
                      borderRadius: BorderRadius.circular(AppConstants.radius),
                    ),
                    child: Row(children: [
                      CustomNetworkImage(
                        url: category.img,
                        height: 48,
                        width: 48,
                        fit: BoxFit.contain,
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          category.translation?.title ?? '',
                          style: CustomStyle.interNormal(
                            color: colors.textBlack,
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: REdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: ()=> onLastTap.call(category),
                  child: Container(
                    padding: REdgeInsets.all(6),
                    child: Row(children: [
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.all),
                          style: CustomStyle.interNormal(
                            color: colors.textBlack,
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Icon(
                        Remix.arrow_right_s_line,
                        size: 21.r,
                        color: colors.textBlack,
                      ),
                      8.horizontalSpace,
                    ]),
                  ),
                ),
              ),
                Divider(color: colors.newBoxColor),
              ...?selectCategory?.children?.map((e) {
                return Column(
                  children: [
                    if (selectCategoryTwo?.id == null)
                      Column(
                        children: [
                          Padding(
                            padding: REdgeInsets.only(bottom: 8),
                            child: GestureDetector(
                              onTap: () {
                                if(e.children?.isEmpty ?? true){
                                  onLastTap.call(e);
                                  return;
                                }
                                onTwoTap(e);
                              },
                              child: Container(
                                padding: REdgeInsets.all(6),
                                child: Row(children: [
                                  8.horizontalSpace,
                                  Expanded(
                                    child: Text(
                                      e.translation?.title ?? '',
                                      style: CustomStyle.interNormal(
                                        color: colors.textBlack,
                                      ),
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  Icon(
                                    Remix.arrow_down_s_line,
                                    size: 21.r,
                                    color: colors.textBlack,
                                  ),
                                  8.horizontalSpace,
                                ]),
                              ),
                            ),
                          ),
                          Divider(color: colors.newBoxColor),
                        ],
                      ),
                    if (selectCategoryTwo?.id == e.id)
                      Column(
                        children: [
                          Padding(
                            padding: REdgeInsets.only(bottom: 8),
                            child: GestureDetector(
                              onTap: () => onTwoTap(e),
                              child: Container(
                                padding: REdgeInsets.all(6),
                                child: Row(children: [
                                  8.horizontalSpace,
                                  Expanded(
                                    child: Text(
                                      e.translation?.title ?? '',
                                      style: CustomStyle.interNormal(
                                        color: colors.textBlack,
                                      ),
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  Icon(
                                    Remix.arrow_right_s_line,
                                    size: 21.r,
                                    color: colors.textBlack,
                                  ),
                                  8.horizontalSpace,
                                ]),
                              ),
                            ),
                          ),
                          Divider(color: colors.newBoxColor),
                          Padding(
                            padding: REdgeInsets.only(bottom: 8),
                            child: GestureDetector(
                              onTap: ()=> onLastTap.call(e),
                              child: Container(
                                padding: REdgeInsets.all(6),
                                child: Row(children: [
                                  8.horizontalSpace,
                                  Expanded(
                                    child: Text(
                                     AppHelpers.getTranslation(TrKeys.all),
                                      style: CustomStyle.interNormal(
                                        color: colors.textHint,
                                      ),
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  Icon(
                                    Remix.arrow_right_s_line,
                                    size: 21.r,
                                    color: colors.textBlack,
                                  ),
                                  8.horizontalSpace,
                                ]),
                              ),
                            ),
                          ),
                          Divider(color: colors.newBoxColor,height: 6),
                          ...?selectCategoryTwo?.children?.map((v) {
                            return Column(
                              children: [
                                Padding(
                                  padding: REdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: ()=> onLastTap.call(v),
                                    child: Container(
                                      padding: REdgeInsets.all(6),
                                      child: Row(children: [
                                        8.horizontalSpace,
                                        Expanded(
                                          child: Text(
                                            v.translation?.title ?? '',
                                            style: CustomStyle.interNormal(
                                              color: colors.textHint,
                                            ),
                                          ),
                                        ),
                                        8.horizontalSpace,
                                        Icon(
                                          Remix.arrow_down_s_line,
                                          size: 21.r,
                                          color: colors.textBlack,
                                        ),
                                        8.horizontalSpace,
                                      ]),
                                    ),
                                  ),
                                ),
                                Divider(color: colors.newBoxColor,height: 6),
                              ],
                            );
                          }),
                        ],
                      ),

                  ],
                );
              }),
            ],
          )
      ],
    );
  }
}
