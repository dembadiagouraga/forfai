import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/components/components.dart';

import 'package:quick/presentation/style/style.dart';

class TermPage extends StatelessWidget {
  const TermPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                PopButton(color: colors.textBlack),
                8.horizontalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.terms),
                  style: CustomStyle.interSemi(
                      color: colors.textBlack, size: 18),
                ),
              ],
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return state.isHelpLoading
                    ? const Center(child: Loading())
                    : Expanded(
                      child: SingleChildScrollView(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.term?.title ?? "",
                                style: CustomStyle.interSemi(
                                    color: colors.textBlack),
                              ),
                              8.verticalSpace,
                              Html(
                                data: state.term?.description ?? "",
                                style: {
                                  "body": Style(
                                    color: colors.textBlack,
                                  ),
                                },
                              )
                            ],
                          ),
                        ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
