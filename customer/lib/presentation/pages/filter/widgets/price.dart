import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/filter/filter_bloc.dart';
import 'package:quick/infrastructure/service/currency_formatter.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';

import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:provider/provider.dart';

class PriceFilter extends StatefulWidget {
  final CustomColorSet colors;
  final Delayed delayed;
  final TextEditingController from;
  final TextEditingController to;
  final FilterState state;
  final int? categoryId;

  const PriceFilter({
    super.key,
    required this.colors,
    required this.state,
    required this.delayed,
    required this.from,
    required this.to,
    this.categoryId,
  });

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  bool changeColor(int i) {
    return ((((widget.state.rangeValues?.start ?? 0) -
                        (widget.state.filterPrices?.min ?? 0)) /
                    (((widget.state.filterPrices?.max ?? 0) -
                            (widget.state.filterPrices?.min ?? 0)) /
                        30))
                .round() <=
            i) &&
        (((widget.state.rangeValues?.end ?? 100) /
                    ((widget.state.filterPrices?.max ?? 0) / 30))
                .round() >=
            i);
  }

  @override
  Widget build(BuildContext context) {
    final event = context.read<FilterBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 4),
          child: Text(
            AppHelpers.getTranslation(TrKeys.priceRange),
            style: CustomStyle.interNormal(
              size: 16,
              color: widget.colors.textBlack,
            ),
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 6),
          child: Text(
            "${AppHelpers.numberFormat(
              decimalDigits: 0,
              widget.state.filterPrices?.min,
            )} ${AppHelpers.getTranslation(TrKeys.to).toLowerCase()} ${AppHelpers.numberFormat(widget.state.filterPrices?.max, decimalDigits: 0)}",
            style: CustomStyle.interNormal(
              size: 12,
              color: widget.colors.textHint,
            ),
          ),
        ),
        8.verticalSpace,
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                hint: AppHelpers.numberFormat(widget.state.filterPrices?.min),
                controller: widget.from,
                inputType: TextInputType.number,
                onChanged: (s) {
                  widget.delayed.run(() {
                    double? start;
                    double end = widget.state.rangeValues?.end ??
                        widget.state.filterPrices?.max?.toDouble() ??
                        0;
                    double v = s.toDouble ?? 0;
                    double max = (widget.state.rangeValues?.end ?? 0);
                    double min =
                        (widget.state.filterPrices?.min?.toDouble() ?? 0);
                    debugPrint("\nmin: $min \nmax: $max \nv: $v");
                    if (v > max) {
                      start = max;
                      widget.from.text = "${max.toInt()}";
                    }
                    // else if (v < min) {
                    //   start = min;
                    //   from.text = "${min.toInt()}";
                    // }
                    else {
                      start = v;
                    }
                    event
                      ..add(
                        FilterEvent.setRangePrice(
                          price: RangeValues(start, end),
                        ),
                      )
                      ..add(FilterEvent.fetchFilter(
                          context: context,
                          isPrice: false,
                          categoryId: widget.categoryId));
                  });
                },
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.from).toLowerCase(),
                      style: CustomStyle.interNormal(
                          color: widget.colors.textHint, size: 14),
                    ),
                  ],
                ),
                filled: true,
                inputFormatters: [CurrencyTextInputFormatter.simpleCurrency()],
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: CustomTextFormField(
                hint: AppHelpers.numberFormat(widget.state.filterPrices?.max),
                controller: widget.to,
                inputType: TextInputType.number,
                onChanged: (s) {
                  double v = s.toDouble ?? 0;
                  widget.delayed.run(() {
                    double start = widget.state.rangeValues?.start ??
                        widget.state.filterPrices?.min?.toDouble() ??
                        0;
                    double? end;
                    double max =
                        (widget.state.filterPrices?.max?.toDouble() ?? 0);
                    double min = (widget.state.rangeValues?.start ?? 0);
                    debugPrint("\nmin: $min \nmax: $max \nv: $v");
                    if (v > max) {
                      end = max;
                      widget.to.text = "${max.toInt()}";
                    } else if (v < min) {
                      end = min;
                      widget.to.text = "${min.toInt()}";
                    } else {
                      end = v;
                    }
                    event
                      ..add(
                        FilterEvent.setRangePrice(
                          price: RangeValues(start, end),
                        ),
                      )
                      ..add(FilterEvent.fetchFilter(
                        context: context,
                        isPrice: false,
                      ));
                  });
                },
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.to).toLowerCase(),
                      style: CustomStyle.interNormal(
                          color: widget.colors.textHint, size: 14),
                    ),
                  ],
                ),
                filled: true,
                inputFormatters: [CurrencyTextInputFormatter.simpleCurrency()],
              ),
            ),
          ],
        ),
        8.verticalSpace,
        if (!widget.state.isLoading)
          RangeSlider(
              activeColor: widget.colors.textBlack,
              inactiveColor: widget.colors.textWhite,
              min: (widget.state.filterPrices?.min ?? 0).toDouble(),
              max: (widget.state.filterPrices?.max ?? 100).toDouble(),
              values: widget.state.rangeValues ?? const RangeValues(0, 100),
              onChanged: (value) {
                context.read<FilterBloc>().add(
                      FilterEvent.setRangePrice(
                          price: RangeValues(value.start, value.end)),
                    );
                widget.from.text = AppHelpers.format().format(value.start);
                widget.to.text = AppHelpers.format().format(value.end);
                widget.delayed.run(() {
                  context.read<FilterBloc>().add(FilterEvent.fetchFilter(
                      context: context, isPrice: false));
                });
              })
        else
          36.verticalSpace,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       AppHelpers.numberFormat(widget.state.rangeValues?.start),
        //       style: CustomStyle.interNormal(
        //         size: 14,
        //         color: widget.colors.textBlack,
        //       ),
        //     ),
        //     Text(
        //       AppHelpers.numberFormat(widget.state.rangeValues?.end),
        //       style: CustomStyle.interNormal(
        //         size: 12.sp,
        //         color: widget.colors.textBlack,
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
