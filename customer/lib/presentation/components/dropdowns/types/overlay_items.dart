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
import 'package:quick/presentation/components/loading.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import '../dropdown_item_data.dart';

part 'brand_overlay.dart';

part 'city_overlay.dart';

part 'area_overlay.dart';

part 'unit_overlay.dart';

part 'country_overlay.dart';

part 'category_overlay.dart';

class _ItemsList extends StatelessWidget {
  final ScrollController scrollController;
  final CustomColorSet colors;
  final List<DropDownItemData> items;
  final ValueSetter<DropDownItemData> onItemSelect;

  const _ItemsList({
    required this.scrollController,
    required this.items,
    required this.onItemSelect,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: items.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: REdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: CustomStyle.transparent,
                  child: InkWell(
                    splashColor: CustomStyle.transparent,
                    onTap: () => onItemSelect(items[index]),
                    child: Container(
                      padding: REdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      child: Text(
                        items[index].title,
                        style: CustomStyle.interNormal(
                            size: 14, color: colors.textBlack),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1.r,
                  thickness: 1.r,
                  color: CustomStyle.border,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  final String searchHintText;
  final List<DropDownItemData> items;
  final Function(String?)? onChanged;
  final CustomColorSet colors;

  const _SearchField({
    required this.searchHintText,
    required this.items,
    required this.onChanged,
    required this.colors,
  });

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final searchCtrl = TextEditingController();

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void onClear() {
    if (searchCtrl.text.isNotEmpty) {
      searchCtrl.clear();
      widget.onChanged?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 48.r,
        child: TextField(
          controller: searchCtrl,
          onChanged: (value) {
            widget.onChanged!(value);
            debugPrint('===> search field value: $value');
          },
          cursorWidth: 1.r,
          cursorColor: CustomStyle.textHint,
          style:
              CustomStyle.interNormal(size: 14, color: widget.colors.textBlack),
          decoration: InputDecoration(
            fillColor: widget.colors.transparent,
            filled: true,
            constraints: BoxConstraints.tightFor(height: 40.r),
            hoverColor: CustomStyle.transparent,
            hintText: AppHelpers.getTranslation(widget.searchHintText),
            contentPadding: EdgeInsets.zero,
            hintStyle: CustomStyle.interNormal(
              size: 14,
              color: widget.colors.textHint,
            ),
            prefixIcon: Icon(
              Remix.search_line,
              color: widget.colors.textBlack,
              size: 20.r,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Remix.close_circle_line,
                size: 20.r,
                color: widget.colors.textBlack.withValues(alpha: 0.5),
              ),
              splashColor: CustomStyle.transparent,
              hoverColor: CustomStyle.transparent,
              onPressed: onClear,
            ),
            enabledBorder: _border(widget.colors.border),
            errorBorder: _border(widget.colors.border),
            border: _border(widget.colors.border),
            focusedErrorBorder: _border(widget.colors.border),
            disabledBorder: _border(widget.colors.border),
            focusedBorder: _border(widget.colors.border),
          ),
        ),
      ),
    );
  }

  _border(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide.merge(
          BorderSide(color: color),
          BorderSide(color: color),
        ),
        borderRadius: BorderRadius.circular(AppConstants.radius.r));
  }
}

class _CustomOverlay extends StatelessWidget {
  final List<DropDownItemData> items;
  final CustomColorSet colors;
  final bool isLoading;
  final ScrollController scrollController;
  final ValueChanged<DropDownItemData> onItemSelect;
  final ValueChanged<String?>? onSearch;

  const _CustomOverlay({
    required this.items,
    required this.colors,
    required this.isLoading,
    required this.scrollController,
    required this.onItemSelect,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onSearch != null)
          _SearchField(
            items: items,
            searchHintText: TrKeys.search,
            onChanged: (v) => onSearch?.call(v),
            colors: colors,
          ),
        isLoading
            ? Padding(
                padding: REdgeInsets.symmetric(vertical: 16),
                child: const Center(child: Loading()),
              )
            : items.isNotEmpty
                ? Expanded(
                    child: _ItemsList(
                    colors: colors,
                    scrollController: scrollController,
                    items: items,
                    onItemSelect: onItemSelect,
                  ))
                : Center(
                    child: Padding(
                      padding: REdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        AppHelpers.getTranslation(TrKeys.noSearchResults),
                        style: CustomStyle.interNormal(
                            size: 14, color: colors.textBlack),
                      ),
                    ),
                  ),
      ],
    );
  }
}
