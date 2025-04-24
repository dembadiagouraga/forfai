import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/domain/model/models.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/address/address_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/app_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final RefreshController controller = RefreshController();
  final Delayed delayed = Delayed(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: (colors) => KeyboardDismisser(
              isLtr: LocalStorage.getLangLtr(),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        PopButton(color: colors.textBlack),
                        8.horizontalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.selectCountry),
                          style: CustomStyle.interSemi(
                              color: colors.textBlack, size: 18),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      child: CustomTextFormField(
                        hint: AppHelpers.getTranslation(TrKeys.search),
                        onChanged: (s) {
                          if (s.trim().isNotEmpty) {
                            delayed.run(() {
                              context.read<AddressBloc>().add(
                                  AddressEvent.searchCountry(
                                      context: context, search: s));
                            });
                          }
                        },
                      ),
                    ),
                    BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        return state.isLoading
                            ? Padding(
                                padding: EdgeInsets.only(top: 32.r),
                                child: const Loading(),
                              )
                            : Expanded(
                                child: SmartRefresher(
                                  controller: controller,
                                  enablePullDown: false,
                                  enablePullUp: true,
                                  onLoading: () {
                                    context.read<AddressBloc>().add(
                                        AddressEvent.fetchCountry(
                                            context: context,
                                            controller: controller));
                                  },
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(16.r),
                                    itemCount: state.countries.length,
                                    itemBuilder: (context, index) {
                                      return _countryItem(colors,
                                          state.countries[index]);
                                    },
                                  ),
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
            ));
  }

  Widget _countryItem(CustomColorSet colors, CountryModel country) {
    return ButtonEffectAnimation(
      onTap: () {
        LocalStorage.setAddress(AddressModel(
          countryId: country.id,
          regionId: country.regionId,
          countryCode: country.code,
          country: country.translation?.title,
        ));

        if ((country.citiesCount ?? 0) > 0) {
          SettingRoute.goSelectCity(
              context: context, countryId: country.id ?? 0);
          return;
        }
        if (AppConstants.isDemo && LocalStorage.getUiType() == null) {
          SettingRoute.goSelectUIType(context: context);
          return;
        }
        AppRoute.goMain(context);
      },
      child: Column(
        children: [
          Row(
            children: [
              // CustomNetworkImage(
              //     url: country.img, height: 20, width: 30, radius: 0),
              // 16.horizontalSpace,
              AutoSizeText(
                country.translation?.title ?? "",
                style: CustomStyle.interNormal(
                    color: LocalStorage.getAddress()?.countryId == country.id
                        ? colors.primary
                        : colors.textBlack,
                    size: 12),
                minFontSize: 6,
                maxFontSize: 14,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              if (LocalStorage.getAddress()?.countryId == country.id)
                Icon(
                  Remix.check_line,
                  color: colors.primary,
                )
            ],
          ),
          8.verticalSpace,
          const Divider(),
          8.verticalSpace,
        ],
      ),
    );
  }
}
