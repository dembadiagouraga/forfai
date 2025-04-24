import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/application/filter/filter_bloc.dart';
import 'package:quick/application/select/select_bloc.dart';
import 'package:quick/domain/model/response/filter_response.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'attribute_item.dart';

class AttributesScreen extends StatelessWidget {
  final CustomColorSet colors;
  final Attribute? attribute;

  const AttributesScreen({
    super.key,
    required this.colors,
    required this.attribute,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: (colors) => CustomAppBar(
        colors: colors,
        context: context,
        title: attribute?.title,
      ),
      body: (colors) {
        return BlocBuilder<SelectBloc, SelectState>(
          builder: (context, state) {
            return Padding(
              padding: REdgeInsets.only(bottom: 78),
              child: ListView(
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: attribute?.values?.map(
                      (e) => InkWell(
                          onTap: () {
                            context
                                .read<SelectBloc>()
                                .add(SelectEvent.selectValue(value: e));
                          },
                          child: AttributeItem(
                            active: state.selectIds.any((v) =>
                                e.value == v.value && e.valueId == v.valueId),
                            type: attribute?.title ?? "",
                            extra: e,
                            colors: colors,
                          ),
                        ),
                    ).toList() ??
                    [],
              ),
            );
          },
        );
      },
      floatingButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingButton: (colors) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<SelectBloc, SelectState>(
              builder: (context, state) {
                return CustomButton(
                    title: AppHelpers.getTranslation(TrKeys.show),
                    bgColor: colors.primary,
                    titleColor: colors.textWhite,
                    onTap: () {
                      context.read<FilterBloc>()
                        ..add(FilterEvent.setExtras(ids: state.selectIds))
                        ..add(FilterEvent.fetchFilter(
                          context: context,
                          isPrice: true,
                        ));
                      Navigator.pop(context);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
