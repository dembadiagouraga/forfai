import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/theme/theme.dart';

const Duration _kExpand = Duration(milliseconds: 200);



class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    this.leading,
    required this.colors,
    required this.title,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.tilePadding,
    this.childrenPadding, this.radius,
  });

  final Widget? leading;
  final Widget title;
  final CustomColorSet colors;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Widget? trailing;
  final BorderRadius? radius;
  final EdgeInsetsGeometry? tilePadding;
  final EdgeInsetsGeometry? childrenPadding;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ShapeBorderTween _borderTween = ShapeBorderTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();
  final CurveTween _heightFactorTween = CurveTween(curve: Curves.easeIn);

  late AnimationController _animationController;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<ShapeBorder?> _border;
  late Animation<Color?> _headerColor;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _animationController.drive(_heightFactorTween);
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    _border = _animationController.drive(_borderTween.chain(_easeOutTween));
    _headerColor =
        _animationController.drive(_headerColorTween.chain(_easeInTween));
    _iconColor =
        _animationController.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _animationController.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded =
        PageStorage.maybeOf(context)?.readState(context) as bool? ?? false;
    if (_isExpanded) {
      _animationController.value = 1.0;
    }

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    final TextDirection textDirection =
        WidgetsLocalizations.of(context).textDirection;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String stateHint =
        _isExpanded ? localizations.expandedHint : localizations.collapsedHint;
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
    SemanticsService.announce(stateHint, textDirection);
  }

  void _handleTap() {
    _toggleExpansion();
  }

  Widget? _buildIcon(BuildContext context) {
    return RotationTransition(
      turns: _iconTurns,
      child: Icon(_iconTurns.value == 0.5 ? Icons.remove : Icons.add,color: widget.colors.textBlack,),
    );
  }

  Widget? _buildTrailingIcon(BuildContext context) {
    return _buildIcon(context);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final ThemeData theme = Theme.of(context);
    final ExpansionTileThemeData expansionTileTheme =
        ExpansionTileTheme.of(context);
    final ShapeBorder expansionTileBorder = _border.value ??
        const Border(
          top: BorderSide(color: Colors.transparent),
          bottom: BorderSide(color: Colors.transparent),
        );
    final Clip clipBehavior = expansionTileTheme.clipBehavior ?? Clip.none;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String onTapHint = _isExpanded
        ? localizations.expansionTileExpandedTapHint
        : localizations.expansionTileCollapsedTapHint;
    String? semanticsHint;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        semanticsHint = _isExpanded
            ? '${localizations.collapsedHint}\n ${localizations.expansionTileExpandedHint}'
            : '${localizations.expandedHint}\n ${localizations.expansionTileCollapsedHint}';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        break;
    }

    return Container(
      clipBehavior: clipBehavior,
      decoration: ShapeDecoration(
        color: _backgroundColor.value ??
            expansionTileTheme.backgroundColor ??
            Colors.transparent,
        shape: expansionTileBorder,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Semantics(
            hint: semanticsHint,
            onTapHint: onTapHint,
            child: ListTileTheme.merge(
              iconColor: _iconColor.value ?? expansionTileTheme.iconColor,
              textColor: _headerColor.value,
              child: ClipRRect(
                child: InkWell(
                  borderRadius: widget.radius,
                  onTap: _handleTap,
                  child: Padding(
                    padding: REdgeInsets.symmetric(horizontal: 1),
                    child: ListTile(
                      contentPadding:
                          widget.tilePadding ?? expansionTileTheme.tilePadding,
                      leading: widget.leading,
                      title: widget.title,
                      trailing: widget.trailing ?? _buildTrailingIcon(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              alignment:
                  expansionTileTheme.expandedAlignment ?? Alignment.centerLeft,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    final ExpansionTileThemeData expansionTileTheme =
        ExpansionTileTheme.of(context);
    final ExpansionTileThemeData defaults = theme.useMaterial3
        ? _ExpansionTileDefaultsM3(context)
        : _ExpansionTileDefaultsM2(context);
    _updateAnimationDuration(expansionTileTheme);
    _updateShapeBorder(expansionTileTheme, theme);
    _updateHeaderColor(expansionTileTheme, defaults);
    _updateIconColor(expansionTileTheme, defaults);
    _updateBackgroundColor(expansionTileTheme);
    _updateHeightFactorCurve(expansionTileTheme);
    super.didChangeDependencies();
  }

  void _updateAnimationDuration(ExpansionTileThemeData expansionTileTheme) {
    _animationController.duration =
        expansionTileTheme.expansionAnimationStyle?.duration ?? _kExpand;
  }

  void _updateShapeBorder(
      ExpansionTileThemeData expansionTileTheme, ThemeData theme) {
    _borderTween
      ..begin = expansionTileTheme.collapsedShape ??
          const Border(
            top: BorderSide(color: Colors.transparent),
            bottom: BorderSide(color: Colors.transparent),
          )
      ..end = expansionTileTheme.shape ??
          Border(
            bottom: BorderSide(color: theme.dividerColor),
          );
  }

  void _updateHeaderColor(ExpansionTileThemeData expansionTileTheme,
      ExpansionTileThemeData defaults) {
    _headerColorTween
      ..begin =
          expansionTileTheme.collapsedTextColor ?? defaults.collapsedTextColor
      ..end = expansionTileTheme.textColor ?? defaults.textColor;
  }

  void _updateIconColor(ExpansionTileThemeData expansionTileTheme,
      ExpansionTileThemeData defaults) {
    _iconColorTween
      ..begin =
          expansionTileTheme.collapsedIconColor ?? defaults.collapsedIconColor
      ..end = expansionTileTheme.iconColor ?? defaults.iconColor;
  }

  void _updateBackgroundColor(ExpansionTileThemeData expansionTileTheme) {
    _backgroundColorTween
      ..begin = expansionTileTheme.collapsedBackgroundColor
      ..end = expansionTileTheme.backgroundColor;
  }

  void _updateHeightFactorCurve(ExpansionTileThemeData expansionTileTheme) {
    _heightFactorTween.curve =
        expansionTileTheme.expansionAnimationStyle?.curve ?? Curves.easeIn;
  }

  @override
  Widget build(BuildContext context) {
    final ExpansionTileThemeData expansionTileTheme =
        ExpansionTileTheme.of(context);
    final bool closed = !_isExpanded && _animationController.isDismissed;
    final bool shouldRemoveChildren = closed;
    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: widget.childrenPadding ??
              expansionTileTheme.childrenPadding ??
              EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}

class _ExpansionTileDefaultsM2 extends ExpansionTileThemeData {
  _ExpansionTileDefaultsM2(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  Color? get textColor => _colorScheme.primary;

  @override
  Color? get iconColor => _colorScheme.primary;

  @override
  Color? get collapsedTextColor => _theme.textTheme.titleMedium!.color;

  @override
  Color? get collapsedIconColor => _theme.unselectedWidgetColor;
}

class _ExpansionTileDefaultsM3 extends ExpansionTileThemeData {
  _ExpansionTileDefaultsM3(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colors = _theme.colorScheme;

  @override
  Color? get textColor => _colors.onSurface;

  @override
  Color? get iconColor => _colors.primary;

  @override
  Color? get collapsedTextColor => _colors.onSurface;

  @override
  Color? get collapsedIconColor => _colors.onSurfaceVariant;
}
