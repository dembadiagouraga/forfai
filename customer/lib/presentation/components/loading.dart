import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/theme/theme_wrapper.dart';

class Loading extends StatelessWidget {
  final bool changeColor;
  final int size;

  const Loading({
    super.key,
    this.changeColor = false,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, c) {
      return Center(
        child: Platform.isAndroid
            ? SizedBox(
                height: size.r,
                width: size.r,
                child: CircularProgressIndicator(
                  color: changeColor ? colors.textWhite : colors.textBlack,
                  strokeWidth: size > 30 ? 4.r : 3.r,
                ),
              )
            : CupertinoActivityIndicator(
                radius: size > 24 ? 12 : 10,
                color: changeColor ? colors.textWhite : colors.textBlack,
              ),
      );
    });
  }
}
