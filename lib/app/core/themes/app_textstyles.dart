import 'package:flutter/material.dart';
import 'package:news_app/app/core/themes/app_colors.dart';

mixin AppTextstyles {
  static const TextStyle headline = TextStyle(
    fontFamily: 'PlayfairDisplay',
    color: AppColor.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle body = TextStyle(
    fontFamily: 'Inter_18pt',
    color: AppColor.primaryColor.withValues(alpha: 0.5),
    fontWeight: FontWeight.w300,
  );

  static TextStyle lable = TextStyle(
    fontFamily: 'Inter_18pt',
    color: AppColor.primaryColor.withValues(alpha: 0.7),
    fontWeight: FontWeight.w300,
  );
}
