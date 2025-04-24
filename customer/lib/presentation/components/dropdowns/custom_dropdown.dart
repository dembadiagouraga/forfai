export 'custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/address/address_bloc.dart';
import 'package:quick/application/brand/brand_bloc.dart';
import 'package:quick/application/category/category_bloc.dart';
import 'package:quick/application/products/unit/unit_bloc.dart';
import 'package:quick/infrastructure/service/services.dart';

import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

import 'types/overlay_items.dart';

part 'dropdown_field.dart';

part 'animated_section.dart';

part 'dropdown_overlay.dart';

part 'overlay_builder.dart';

class CustomDropdown extends StatefulWidget {
  final DropDownType dropDownType;
  final String? hintText;
  final String? label;
  final String? searchHintText;
  final String? initialValue;
  final int? initialId;
  final bool? isClear;
  final ValueChanged<int?>? onChanged;
  final ValueChanged? onSelected;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.dropDownType,
    this.hintText,
    this.searchHintText,
    this.onChanged,
    this.initialValue,
    this.label,
    this.validator,
    this.initialId,
    this.onSelected,
    this.isClear,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final layerLink = LayerLink();
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _OverlayBuilder(
      overlay: (size, hideCallback) {
        return MultiBlocProvider(
          providers: [
            if (widget.dropDownType == DropDownType.category ||
                widget.dropDownType == DropDownType.subcategory ||
                widget.dropDownType == DropDownType.childCategory)
              BlocProvider.value(value: context.read<CategoryBloc>()),
            if (widget.dropDownType == DropDownType.brand)
              BlocProvider.value(value: context.read<BrandBloc>()),
            if (widget.dropDownType == DropDownType.unit)
              BlocProvider(
                create: (_) => UnitBloc()
                  ..add(
                      UnitEvent.fetchUnits(context: context, isRefresh: true)),
              ),
            if (widget.dropDownType == DropDownType.country)
              BlocProvider(
                create: (_) => AddressBloc()
                  ..add(
                    AddressEvent.fetchCountry(
                        context: context, isRefresh: true),
                  ),
              ),
            if (widget.dropDownType == DropDownType.city)
              BlocProvider(
                create: (_) => AddressBloc()
                  ..add(
                    AddressEvent.fetchCity(
                        context: context,
                        countyId: widget.initialId,
                        isRefresh: true),
                  ),
              ),
            if (widget.dropDownType == DropDownType.area)
              BlocProvider(
                create: (_) => AddressBloc()
                  ..add(
                    AddressEvent.fetchArea(
                        context: context,
                        cityId: widget.initialId,
                        isRefresh: true),
                  ),
              )
          ],
          child: _DropdownOverlay(
            controller: controller,
            size: size,
            validator: widget.validator != null,
            layerLink: layerLink,
            hideOverlay: hideCallback,
            hintText: widget.hintText ?? widget.label ?? '',
            onChanged: widget.onChanged,
            dropDownType: widget.dropDownType,
            initialId: widget.initialId,
            onItemSelect: widget.onSelected,
          ),
        );
      },
      child: (showCallback) {
        if (widget.isClear ?? false) {
          controller.text = '';
        }
        return CompositedTransformTarget(
          link: layerLink,
          child: _DropDownField(
            controller: controller,
            onTap: showCallback,
            hintText: TrKeys.select,
            label: widget.label,
            validator: widget.validator,
          ),
        );
      },
    );
  }
}
