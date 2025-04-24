import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/domain/model/model/attributes_data.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/blur_wrap.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';


class AdditionInformation extends StatelessWidget {
  final CustomColorSet colors;
  final List<AttributesData>? list;

  const AdditionInformation({
    super.key,
    required this.colors,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return BlurWrap(
      radius: BorderRadius.only(
        topRight: Radius.circular(AppConstants.radius.r),
        topLeft: Radius.circular(AppConstants.radius.r),
      ),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.backgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppConstants.radius.r),
              topLeft: Radius.circular(AppConstants.radius.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.additionInformation),
                style: CustomStyle.interBold(color: colors.textBlack, size: 22),
              ),
              16.verticalSpace,
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 16.r),
                      child: Row(
                        children: [
                          Container(
                            height: 8.r,
                            width: 8.r,
                            decoration: BoxDecoration(
                                color: colors.textBlack,
                                shape: BoxShape.circle),
                          ),
                          6.horizontalSpace,
                          Text(
                            "${list?[index].translation?.title ?? ""}: ",
                            style: CustomStyle.interSemi(
                                color: colors.textBlack),
                          ),
                          Text(
                            list?[index].values?.first.value ?? "",
                            style: CustomStyle.interNormal(
                                color: colors.textBlack),
                          )
                        ],
                      ),
                    );
                  }),
              32.verticalSpace,
            ],
          )),
    );
  }
}
