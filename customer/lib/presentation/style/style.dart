import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyle {
  CustomStyle._();

  /// colors.
  static const Color primary = Color(0xff226CC6);

  static const Color black = Colors.black;

  static const Color starColor = Color(0xffFFA826);

  static const Color greenColor = Color(0xff16AA16);

  static const Color unselectColor = Color(0xffF4F8F4);

  static const Color white = Colors.white;

  static const Color whiteWithOpacity = Color(0x30ffffff);

  static const Color red = Color(0xffE0122B);

  static const Color success = Color(0xff31D0AA);

  static const Color icon = Color(0x30B1B1B1);

  static const Color border = Color(0x10000000);

  static const Color textHint = Color(0xff939393);

  static const Color transparent = Colors.transparent;

  static const Color bgDark = Color(0xff18191D);

  static const Color socialButtonDark = Color(0xff33393F);

  static const Color socialButtonLight = Color(0xffF4F4F4);

  static const Color bottomBarColorDark = Color(0xff444444);

  static const Color bottomBarColorLight = Color(0xff000000);

  static const Color categoryDark = Color(0xff33393F);

  static const Color dividerColor = Color(0xffF3F3F3);

  static const Color subCategory = Color(0xffF6F6F6);

  static const Color unselectLayout = Color(0xffAEAEAE);

  static const Color unselectTabBar = Color(0xffA0A09C);

  static Color shimmerBase = Colors.grey.shade300;

  static List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.4),
      blurRadius: 12,
      offset: const Offset(0, 1),
      spreadRadius: 0,
    )
  ];

  static List<BoxShadow> blackShadow = [
    BoxShadow(
        color: const Color(0xff000000).withValues(alpha: .15),
        blurRadius: 40,
        offset: const Offset(0, -2))
  ];
  static Gradient primaryGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primary.withValues(alpha: 0.9),
        Color(0xff7333FF).withValues(alpha: 0.9),
      ]);

  ///fonsts.
  static interBold(
          {double size = 18,
          required Color color,
          FontStyle fontStyle = FontStyle.normal,
          TextDecoration decoration = TextDecoration.none,
          double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.bold,
          color: color,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing.sp,
          decoration: decoration);

  static interSemi(
          {double size = 18,
          required Color color,
          FontStyle fontStyle = FontStyle.normal,
          TextDecoration decoration = TextDecoration.none,
          double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w600,
          color: color,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing.sp,
          decoration: decoration);

  static interNormal(
          {double size = 16,
          required Color color,
          FontStyle fontStyle = FontStyle.normal,
          TextDecoration textDecoration = TextDecoration.none,
          double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing.sp,
          decoration: textDecoration);

  static interRegular(
          {double size = 16,
          FontStyle fontStyle = FontStyle.normal,
          required Color color,
          TextDecoration textDecoration = TextDecoration.none,
          double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w400,
          color: color,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing.sp,
          decoration: textDecoration);
}
