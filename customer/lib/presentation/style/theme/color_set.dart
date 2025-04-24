part of 'theme.dart';

class CustomColorSet {
  final Color primary;

  final Color white;

  final Color black;

  final Color textHint;

  final Color divider;

  final Color textBlack;

  final Color textWhite;

  final Color icon;

  final Color success;

  final Color error;

  final Color transparent;

  final Color backgroundColor;

  final Color border;

  final Color socialButtonColor;

  final Color newBoxColor;

  final Color bottomBarColor;

  final Color categoryColor;

  final Color categoryTitleColor;

  final Gradient whiteGradient;

  CustomColorSet._({
    required this.black,
    required this.border,
    required this.textHint,
    required this.textBlack,
    required this.textWhite,
    required this.primary,
    required this.white,
    required this.icon,
    required this.divider,
    required this.success,
    required this.error,
    required this.transparent,
    required this.backgroundColor,
    required this.socialButtonColor,
    required this.bottomBarColor,
    required this.categoryColor,
    required this.categoryTitleColor,
    required this.newBoxColor,
    required this.whiteGradient,
  });

  factory CustomColorSet._create(CustomThemeMode mode) {
    final isLight = mode.isLight;

    final textHint = isLight
        ? CustomStyle.textHint
        : CustomStyle.white.withValues(alpha: 0.7);
    final divider = isLight
        ? CustomStyle.textHint.withValues(alpha: 0.6)
        : CustomStyle.white.withValues(alpha: 0.5);

    final textBlack = isLight ? CustomStyle.black : CustomStyle.white;

    final textWhite = isLight ? CustomStyle.white : CustomStyle.black;

    final categoryColor =
        isLight ? CustomStyle.black : CustomStyle.categoryDark;

    final categoryTitleColor =
        isLight ? CustomStyle.black : CustomStyle.whiteWithOpacity;

    const primary = CustomStyle.primary;

    const white = CustomStyle.white;

    const black = CustomStyle.black;

    const icon = CustomStyle.icon;

    final backgroundColor = isLight ? CustomStyle.white : CustomStyle.bgDark;

    final border = isLight ? CustomStyle.border : CustomStyle.icon;

    final newBoxColor =
        isLight ? CustomStyle.subCategory : CustomStyle.categoryDark;

    const success = CustomStyle.success;

    const error = CustomStyle.red;

    const transparent = CustomStyle.transparent;

    final whiteGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          backgroundColor.withValues(alpha: 0.01),
          backgroundColor,
        ]);

    final socialButtonColor =
        isLight ? CustomStyle.socialButtonLight : CustomStyle.socialButtonDark;

    final bottomBarColor = isLight
        ? CustomStyle.bottomBarColorLight.withValues(alpha: 0.8)
        : CustomStyle.bottomBarColorDark;

    return CustomColorSet._(
      black: black,
      border: border,
      whiteGradient: whiteGradient,
      categoryColor: categoryColor,
      textHint: textHint,
      textBlack: textBlack,
      textWhite: textWhite,
      primary: primary,
      white: white,
      icon: icon,
      backgroundColor: backgroundColor,
      success: success,
      error: error,
      transparent: transparent,
      socialButtonColor: socialButtonColor,
      bottomBarColor: bottomBarColor,
      categoryTitleColor: categoryTitleColor,
      newBoxColor: newBoxColor,
      divider: divider,
    );
  }

  static CustomColorSet createOrUpdate(CustomThemeMode mode) {
    return CustomColorSet._create(mode);
  }
}
