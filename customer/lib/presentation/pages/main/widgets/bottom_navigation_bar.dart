import 'package:quick/presentation/style/style.dart';
import 'package:quick/presentation/style/theme/theme.dart';

import 'animated_bottom_nav/circular_notched_and_cornered_shape.dart';
import 'animated_bottom_nav/circular_notch_and_corner_clipper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'animated_bottom_nav/around_custom_painter.dart';
import 'animated_bottom_nav/navigation_bar_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedBottomNavigationBar extends StatefulWidget {
  final int? itemCount;
  final List<IconData>? icons;
  final Function(int) onTap;
  final int activeIndex;
  final double? iconSize;
  final double? height;
  final Animation<double>? notchAndCornersAnimation;
  final CustomColorSet colors;
  final double? gapWidth;
  final double? elevation;
  final Curve? hideAnimationCurve;
  final AnimationController? hideAnimationController;

  AnimatedBottomNavigationBar._internal({
    super.key,
    required this.activeIndex,
    required this.onTap,
    this.itemCount,
    this.icons,
    this.height,
    this.notchAndCornersAnimation,
    this.iconSize,
    required this.colors,
    this.gapWidth,
    this.elevation,
    this.hideAnimationCurve,
    this.hideAnimationController,
  })  : assert(icons != null || itemCount != null),
        assert(
          ((itemCount ?? icons!.length) >= 2) &&
              ((itemCount ?? icons!.length) <= 5),
        );

  AnimatedBottomNavigationBar({
    Key? key,
    required List<IconData> icons,
    required int activeIndex,
    required Function(int) onTap,
    double? height,
    int? splashSpeedInMilliseconds,
    required CustomColorSet colors,
    double? iconSize,
    double? borderWidth,
    Curve? hideAnimationCurve,
    AnimationController? hideAnimationController,
    Gradient? backgroundGradient,
  }) : this._internal(
          key: key,
          icons: icons,
          activeIndex: activeIndex,
          onTap: onTap,
          height: height,
          colors: colors,
          hideAnimationCurve: hideAnimationCurve,
          hideAnimationController: hideAnimationController,
        );

  AnimatedBottomNavigationBar.builder({
    Key? key,
    required int itemCount,
    required IndexedWidgetBuilder tabBuilder,
    required int activeIndex,
    required List<String> titles,
    required Function(int) onTap,
    double? height,
    double? splashRadius,
    int? splashSpeedInMilliseconds,
    required CustomColorSet colors,
    Color? splashColor,
    NotchSmoothness? notchSmoothness,
    double? gapWidth,
    Shadow? shadow,
    Color? borderColor,
    double? borderWidth,
    Curve? hideAnimationCurve,
    AnimationController? hideAnimationController,
    Gradient? backgroundGradient,
    bool blurEffect = false,
  }) : this._internal(
          key: key,
          itemCount: itemCount,
          activeIndex: activeIndex,
          onTap: onTap,
          height: height,
          colors: colors,
          gapWidth: gapWidth,
          hideAnimationCurve: hideAnimationCurve,
          hideAnimationController: hideAnimationController,
        );

  @override
  State<AnimatedBottomNavigationBar> createState() =>
      _AnimatedBottomNavigationBarState();
}

class _AnimatedBottomNavigationBarState
    extends State<AnimatedBottomNavigationBar> with TickerProviderStateMixin {
  late ValueListenable<ScaffoldGeometry> geometryListenable;

  late AnimationController _bubbleController;

  double _bubbleRadius = 0;
  double _iconScale = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);

    widget.notchAndCornersAnimation?.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(AnimatedBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeIndex != oldWidget.activeIndex) {
      _startBubbleAnimation();
    }
  }

  _startBubbleAnimation() {
    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    final bubbleCurve = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.linear,
    );

    Tween<double>(begin: 0, end: 1).animate(bubbleCurve).addListener(() {
      setState(() {
        _bubbleRadius = 16 * bubbleCurve.value;
        if (_bubbleRadius == 16) {
          _bubbleRadius = 0;
        }

        if (bubbleCurve.value < 0.5) {
          _iconScale = 1 + bubbleCurve.value;
        } else {
          _iconScale = 2 - bubbleCurve.value;
        }
      });
    });

    if (_bubbleController.isAnimating) {
      _bubbleController.reset();
    }
    _bubbleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final clipper = CircularNotchedAndCorneredRectangleClipper(
      shape: CircularNotchedAndCorneredRectangle(
        animation: widget.notchAndCornersAnimation,
        notchSmoothness: NotchSmoothness.defaultEdge,
      ),
      geometry: geometryListenable,
      notchMargin: 8,
    );

    return PhysicalShape(
      elevation: 8,
      color: widget.colors.textBlack,
      shadowColor: widget.colors.textBlack,
      clipper: clipper,
      child: AroundCustomPainter(
        clipper: clipper,
        borderColor: CustomStyle.transparent,
        borderWidth: 1,
        shadow: Shadow(
          color: widget.colors.textBlack.withValues(alpha: 0.1),
          offset: const Offset(0,-1),
          blurRadius: 8
        ),
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: widget.colors.backgroundColor,
          child: SafeArea(
            child: Container(
              height: widget.height ?? kBottomNavigationBarHeight,
              decoration: BoxDecoration(
                color: widget.colors.backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: _buildItems(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    final gapWidth = widget.gapWidth ?? 72;
    final gapItemWidth = widget.notchAndCornersAnimation != null
        ? gapWidth * widget.notchAndCornersAnimation!.value
        : gapWidth;
    final itemCount = widget.itemCount ?? widget.icons!.length;

    final items = <Widget>[];
    for (var i = 0; i < itemCount; i++) {
      final isActive = i == widget.activeIndex;

      if (i == itemCount / 2) {
        items.add(gapItemWidth.horizontalSpace);
      }
      items.add(
        NavigationBarItem(
          colors: widget.colors,
          isActive: isActive,
          bubbleRadius: _bubbleRadius,
          iconData: widget.icons?.elementAt(i),
          iconScale: _iconScale,
          onTap: () => widget.onTap(i),
        ),
      );
    }
    return items;
  }
}

enum NotchSmoothness {
  sharpEdge,
  defaultEdge,
  softEdge,
  smoothEdge,
  verySmoothEdge
}
