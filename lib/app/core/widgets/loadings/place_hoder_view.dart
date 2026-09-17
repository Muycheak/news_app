import 'package:flutter/material.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/widgets/loadings/spinkit_three_bounce.dart';

class PlaceHolderView extends StatelessWidget {
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? spinSize;
  final bool? isWhite;

  const PlaceHolderView({
    super.key,
    this.backgroundColor,
    this.width,
    this.height,
    this.spinSize,
    this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    Color spinColor = isWhite != null
        ? isWhite!
              ? Colors.white
              : Colors.transparent
        : Colors.transparent;

    return Container(
      width: width ?? double.maxFinite,
      height: height ?? double.maxFinite,
      color: backgroundColor ?? AppColor.neutralColor,
      child: Center(
        child: SpinKitThreeBounce(
          duration: Duration(milliseconds: 800),
          size: spinSize ?? 20,
          color: spinColor,
        ),
      ),
    );
  }
}
