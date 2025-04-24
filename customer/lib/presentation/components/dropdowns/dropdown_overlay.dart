part of 'custom_dropdown.dart';

class _DropdownOverlay extends StatefulWidget {
  final DropDownType dropDownType;
  final int? initialId;
  final bool validator;
  final TextEditingController controller;
  final Size size;
  final LayerLink layerLink;
  final VoidCallback hideOverlay;
  final String hintText;
  final ValueChanged<int?>? onChanged;
  final ValueChanged? onItemSelect;

  const _DropdownOverlay({
    required this.dropDownType,
    required this.controller,
    required this.size,
    required this.layerLink,
    required this.hideOverlay,
    required this.hintText,
    required this.onChanged,
    required this.initialId,
    required this.onItemSelect,
    required this.validator,
  });

  @override
  State<_DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<_DropdownOverlay> {
  bool displayOverly = true;
  bool displayOverlayBottom = true;
  final key1 = GlobalKey(), key2 = GlobalKey();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final render1 = key1.currentContext?.findRenderObject() as RenderBox;
      final render2 = key2.currentContext?.findRenderObject() as RenderBox;
      final screenHeight = MediaQuery.sizeOf(context).height;
      double y = render1.localToGlobal(Offset.zero).dy;
      if (screenHeight - y < render2.size.height) {
        displayOverlayBottom = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlayOffset = Offset(-12, displayOverlayBottom ? 0 : 60);

    final child = ThemeWrapper(builder: (colors, controller) {
      return Stack(
        children: [
          Positioned(
            width: 244.r,
            child: CompositedTransformFollower(
              link: widget.layerLink,
              followerAnchor: displayOverlayBottom
                  ? Alignment.topLeft
                  : Alignment.bottomLeft,
              showWhenUnlinked: false,
              offset: overlayOffset,
              child: Container(
                key: key1,
                padding: REdgeInsets.only(bottom: 12, left: 12, right: 12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.backgroundColor,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 24.0,
                        color: colors.textBlack.withValues(alpha: .08),
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: CustomStyle.transparent,
                    child: AnimatedSection(
                      animationDismissed: widget.hideOverlay,
                      expand: displayOverly,
                      axisAlignment: displayOverlayBottom ? 1.0 : -1.0,
                      child: SizedBox(
                        key: key2,
                        height: 300.r,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (notification) {
                              notification.disallowIndicator();
                              return true;
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: REdgeInsets.all(14),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          AppHelpers.getTranslation(widget.hintText),
                                          style: CustomStyle.interNormal(
                                              size: 14,
                                              color: colors.textBlack),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if(!widget.validator)
                                      GestureDetector(
                                        onTap: () {
                                          widget.controller.clear();
                                          widget.onItemSelect?.call(null);
                                          setState(() => displayOverly = false);
                                        },
                                        child: Text(
                                          AppHelpers.getTranslation(TrKeys.clear),
                                          style: CustomStyle.interNormal(
                                              size: 14, color: colors.textHint),
                                        ),
                                      ),
                                      12.horizontalSpace,
                                      Icon(
                                        displayOverlayBottom
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons.keyboard_arrow_down_rounded,
                                        color: colors.textBlack,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: _overlayBody(colors)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
    return GestureDetector(
      onTap: () => setState(() => displayOverly = false),
      child: Container(color: Colors.transparent, child: child),
    );
  }

  _overlayBody(CustomColorSet colors) {
    switch (widget.dropDownType) {
      case DropDownType.category:
      case DropDownType.subcategory:
      case DropDownType.childCategory:
        return CategoryOverlay(
          colors: colors,
          type: widget.dropDownType,
          scrollController: scrollController,
          onChanged: onChanged,
          onItemSelect: widget.onItemSelect,
        );
      case DropDownType.brand:
        return BrandOverlay(
          colors: colors,
          scrollController: scrollController,
          onChanged: onChanged,
          onItemSelect: widget.onItemSelect,
        );
      case DropDownType.unit:
        return UnitOverlay(
          colors: colors,
          scrollController: scrollController,
          onChanged: onChanged,
          onItemSelect: widget.onItemSelect,
        );
      case DropDownType.country:
        return CountryOverlay(
          colors: colors,
          scrollController: scrollController,
          onChanged: onChanged,
          onItemSelect: widget.onItemSelect,
        );
      case DropDownType.city:
        return CityOverlay(
          colors: colors,
          scrollController: scrollController,
          onChanged: onChanged,
          countyId: widget.initialId,
          onItemSelect: widget.onItemSelect,
        );
      case DropDownType.area:
        return AreaOverlay(
          colors: colors,
          scrollController: scrollController,
          onChanged: onChanged,
          cityId: widget.initialId,
          onItemSelect: widget.onItemSelect,
        );
    }
  }

  onChanged(value) {
    widget.controller.text = value.title;
    widget.onChanged?.call(value.id);
    setState(() => displayOverly = false);
  }
}
