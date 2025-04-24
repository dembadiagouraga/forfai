import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/filter/filter_bloc.dart';
import 'package:quick/application/select/select_bloc.dart';
import 'package:quick/domain/model/response/filter_response.dart';
import 'package:quick/presentation/pages/filter/widgets/category.dart';
import 'package:quick/presentation/pages/filter/widgets/attributes.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../pages/filter/widgets/sorting.dart';

abstract class FilterRoute {
  FilterRoute._();

  static goSortingPage(
    final CustomColorSet colors,
    final BuildContext context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<FilterBloc>()),
          ],
          child: SortingScreen(colors: colors),
        ),
      ),
    );
  }

  static goAttributePage(
    final CustomColorSet colors,
    final Attribute? attribute,
    final List<Value> list,
    final BuildContext context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<FilterBloc>()),
            BlocProvider(
              create: (context) =>
                  SelectBloc()..add(SelectEvent.selectIds(ids: list)),
            )
          ],
          child: AttributesScreen(colors: colors, attribute: attribute),
        ),
      ),
    );
  }

  static goCategoryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<FilterBloc>()),
            BlocProvider.value(value: context.read<CategoryBloc>()),
          ],
          child: const FilterCategoryPage(),
        ),
      ),
    );
  }
}
