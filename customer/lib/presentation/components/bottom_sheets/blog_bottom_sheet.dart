import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/blog/blog_bloc.dart';
import 'package:quick/domain/model/model/blog_model.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/blur_wrap.dart';
import 'package:quick/presentation/components/button/custom_button.dart';
import 'package:quick/presentation/components/media/custom_network_image.dart';
import 'package:quick/presentation/components/loading.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

class BlogBottomSheet extends StatelessWidget {
  const BlogBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return BlurWrap(
        radius: BorderRadius.only(
          topRight: Radius.circular(AppConstants.radius.r),
          topLeft: Radius.circular(AppConstants.radius.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colors.newBoxColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppConstants.radius.r),
              topLeft: Radius.circular(AppConstants.radius.r),
            ),
          ),
          padding: EdgeInsets.all(16.r),
          child: BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              return state.isLoading && state.blog?.uuid == null
                  ? const Loading()
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if(state.blog?.img != null)
                          CustomNetworkImage(
                              url: state.blog?.img ,
                              height: 180,
                              width: double.infinity,
                              radius: 24),
                          16.verticalSpace,
                          state.isLoading
                              ? const Loading()
                              : Html(
                                  data: state.blog?.translation?.description ??
                                      "",
                                  style: {
                                    "body": Style(
                                      color: colors.textBlack,
                                    ),
                                  },
                                ),
                          16.verticalSpace,
                          CustomButton(
                              title: TrKeys.view,
                              bgColor: CustomStyle.primary,
                              titleColor: CustomStyle.white,
                              onTap: () {
                                AppRoute.goBlogPage(
                                    context, state.blog ?? BlogData());
                              }),
                          16.verticalSpace,
                        ],
                      ),
                    );
            },
          ),
        ),
      );
    });
  }
}
