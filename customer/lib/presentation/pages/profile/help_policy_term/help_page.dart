import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/domain/model/response/help_response.dart';
import 'package:quick/presentation/app_assets.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/profile/profile_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';

import 'widgets/custom_expansion_tile.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

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
                  AppHelpers.getTranslation(TrKeys.helpInfo),
                  style:
                      CustomStyle.interSemi(color: colors.textBlack, size: 18),
                ),
              ],
            ),
            16.verticalSpace,
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return state.isHelpLoading
                    ? const Center(child: Loading())
                    : Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // _helpSearch(colors),
                              // 16.verticalSpace,
                              Text(
                                AppHelpers.getTranslation(TrKeys.popularQuestions),
                                style: CustomStyle.interSemi(
                                  color: colors.textBlack,
                                  size: 20,
                                ),
                                maxLines: 1,
                              ),
                              12.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.radius.r,
                                    ),
                                    border: Border.all(color: colors.border)),
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.helps.length,
                                    itemBuilder: (context, index) {
                                      return _helpItem(
                                        colors: colors,
                                        help: state.helps[index],
                                        index: index,
                                        lastIndex: state.helps.length - 1,
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            )
          ],
        ),
      ),
      floatingButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingButton: (colors) => ButtonEffectAnimation(
        onTap: () {
          if (LocalStorage.getToken().isEmpty) {
            AuthRoute.goLogin(context);
            return;
          }
          AppRoute.goChat(
            context: context,
            sender: LocalStorage.getAdmin(),
          );
        },
        child: Container(
          padding: REdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Remix.message_3_fill,
                color: colors.white,
              ),
              10.horizontalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.onlineChat),
                style:
                    CustomStyle.interSemi(color: CustomStyle.white, size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  _helpSearch(CustomColorSet colors) {
    return Container(
      height: 224.r,
      width: double.infinity,
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomStyle.primary,
        borderRadius: BorderRadius.circular(AppConstants.radius.r),
        image: const DecorationImage(
          image: AssetImage(Assets.imagesHelpBack),
          alignment: Alignment.bottomLeft,
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${AppHelpers.getTranslation(TrKeys.howCanWeHelp)}?",
            style: CustomStyle.interBold(
              color: colors.textBlack,
              size: 26,
            ),
          ),
          24.verticalSpace,
          CustomTextFormField(
            readOnly: true,
            filled: true,
            prefixIcon: Icon(
              Remix.search_2_line,
              color: colors.textBlack,
              size: 21.r,
            ),
            hint: AppHelpers.getTranslation(TrKeys.askAQuestion),
          )
        ],
      ),
    );
  }

  _helpItem({
    required CustomColorSet colors,
    required int index,
    required int lastIndex,
    required HelpModel help,
  }) {
    return Column(
      children: [
        CustomExpansionTile(
          colors: colors,
          radius: BorderRadius.vertical(
            top:
                Radius.circular(index == 0 ? (AppConstants.radius / 1.2).r : 0),
            bottom: Radius.circular(
                index == lastIndex ? (AppConstants.radius / 1.2).r : 0),
          ),
          tilePadding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
          childrenPadding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
          title: Text(
            help.translation?.question ?? "",
            style: CustomStyle.interNormal(color: colors.textBlack, size: 14),
          ),
          children: [
            Text(
              help.translation?.answer ?? "",
              style: CustomStyle.interNormal(color: colors.textBlack, size: 14),
            )
          ],
        ),
        if (index != lastIndex) Divider(color: colors.divider, height: 1.r),
      ],
    );
  }
}
