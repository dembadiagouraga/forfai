import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/filter/filter_bloc.dart';
import 'package:quick/application/products/product_bloc.dart';
import 'package:quick/infrastructure/service/currency_formatter.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/route/filter_route.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'widgets/filter_item.dart';
import 'widgets/price.dart';

class FilterPage extends StatefulWidget {
  final int? categoryId;

  const FilterPage({super.key, required this.categoryId});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final delayed = Delayed(milliseconds: 60 * 30);
  late TextEditingController from;
  late TextEditingController to;
  final CurrencyTextInputFormatter formatter =
      CurrencyTextInputFormatter.currency();

  @override
  void initState() {
    final state = context.read<FilterBloc>().state;
    from = TextEditingController(
      text: formatter.formatDouble(state.rangeValues?.start.toDouble() ?? 0.0),
    );
    to = TextEditingController(
      text: formatter.formatDouble(state.rangeValues?.end.toDouble() ?? 0.0),
    );
    super.initState();
  }

  @override
  void dispose() {
    from.dispose();
    to.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: (colors) => CustomAppBar(
        colors: colors,
        context: context,
        title: TrKeys.filter,
        actions: [
          InkWell(
            onTap: () {
              context.read<FilterBloc>()
                ..add(const FilterEvent.clearFilter())
                ..add(FilterEvent.fetchFilter(context: context, isPrice: true));
            },
            child: Row(
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.clearAll),
                  style: CustomStyle.interNormal(
                    color: CustomStyle.red,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
          16.horizontalSpace,
        ],
      ),
      body: (colors) => BlocConsumer<FilterBloc, FilterState>(
        listenWhen: (p, n) {
          return p.filterPrices?.max != n.filterPrices?.max ||
              p.filterPrices?.min != n.filterPrices?.min;
        },
        listener: (context, state) {
          if (state.rangeValues == null) {
            from.clear();
            to.clear();
          } else {
            // from = TextEditingController(
            //   text: formatter.formatString("${state.filterPrices?.min ?? 0}"),
            // );
            // to = TextEditingController(
            //   text: formatter.formatString("${state.filterPrices?.max ?? 0}"),
            // );
          }
        },
        builder: (context, state) {
          return BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.paddingOf(context).bottom + 8.r,
                      left: 16.r,
                      right: 16.r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.verticalSpace,
                        if (widget.categoryId == null)
                          Column(
                            children: [
                              FilterItem(
                                colors: colors,
                                title: AppHelpers.getTranslation(
                                    TrKeys.categories),
                                subTitle: state.category?.translation?.title ==
                                        null
                                    ? null
                                    : [
                                        state.category?.translation?.title ?? ''
                                      ],
                                onTap: () {
                                  FilterRoute.goCategoryPage(context);
                                },
                              ),
                              Divider(thickness: 2.r, color: colors.icon),
                              12.verticalSpace,
                            ],
                          ),
                        PriceFilter(
                          colors: colors,
                          delayed: delayed,
                          from: from,
                          state: state,
                          to: to,
                          categoryId: state.category?.id,
                        ),
                        8.verticalSpace,
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.filter?.attributes?.length ?? 0,
                            itemBuilder: (context, index) {
                              final selectedAttributes = state
                                  .filter?.attributes?[index].values
                                  ?.where((e) {
                                return state.attributes.any((v)=> e.value ==v.value &&  e.valueId ==v.valueId );
                              });
                              return FilterItem(
                                colors: colors,
                                color: state.filter?.attributes?[index].title ==
                                    'color',
                                title: state.filter?.attributes?[index].title,
                                subTitle: selectedAttributes
                                    ?.map((e) => e.title ?? e.value)
                                    .toList(),
                                onTap: () {
                                  FilterRoute.goAttributePage(
                                    colors,
                                    state.filter?.attributes?[index],
                                    state.attributes,
                                    context,
                                  );
                                },
                              );
                            }),
                        16.verticalSpace,
                        CustomButton(
                            title:
                                "${AppHelpers.getTranslation(TrKeys.view)} ${state.filter?.count ?? 0} ${AppHelpers.getTranslation(TrKeys.products)}",
                            bgColor: colors.primary,
                            titleColor: CustomStyle.white,
                            onTap: () {
                              context
                                  .read<ProductBloc>()
                                  .add(ProductEvent.fetchProducts(
                                    isRefresh: true,
                                    context: context,
                                    brandId: state.brands,
                                    categoryId:
                                        widget.categoryId ?? state.category?.id,
                                    attributes: state.attributes,
                                    priceFrom: state.rangeValues?.start,
                                    priceTo: state.rangeValues?.end,
                                    isPopular: state.type == FilterType.popular,
                                    isNew: state.type == FilterType.news,
                                    minPrice: state.type == FilterType.priceMin,
                                    maxPrice: state.type == FilterType.priceMax,
                                  ));
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                  if (state.isLoading) _customLoading(colors),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _customLoading(CustomColorSet colors) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: colors.backgroundColor.withValues(alpha: 0.3),
        ),
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          child: const Loading(),
        ),
      ),
    );
  }
}
