import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/blog/blog_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/pages/blog/widgets/blog_title.dart';
import 'package:quick/presentation/style/style.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => SafeArea(
        bottom: false,
        child: KeyboardDismisser(
          isLtr: LocalStorage.getLangLtr(),
          child: Column(
            children: [
              Row(
                children: [
                  PopButton(color: colors.textBlack),
                  Text(
                    AppHelpers.getTranslation(TrKeys.blog),
                    style: CustomStyle.interSemi(
                        color: colors.textBlack, size: 18),
                  )
                ],
              ),
              Expanded(
                child: BlocBuilder<BlogBloc, BlogState>(
                  builder: (context, state) {
                    return state.isLoading
                        ? const Loading()
                        : ListView(
                            padding: EdgeInsets.all(16.r),
                            shrinkWrap: true,
                            children: [
                              BlogTitle(blog: state.blog, colors: colors),
                              24.verticalSpace,
                              if(state.blog?.img != null)
                              CustomNetworkImage(
                                  url: state.blog?.img,
                                  height: 180,
                                  width: double.infinity,
                                  radius: 24),
                              16.verticalSpace,
                              state.isLoading
                                  ? const Loading()
                                  : Html(
                                      data: state
                                              .blog?.translation?.description ??
                                          "",
                                      style: {
                                        "body": Style(
                                          color: colors.textBlack,
                                        ),
                                      },
                                    ),
                              16.verticalSpace,
                            ],
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
