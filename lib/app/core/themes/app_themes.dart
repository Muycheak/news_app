import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/core/themes/app_colors.dart';

class AppThemeService extends GetxService {
  ThemeData get theme => ThemeData(
    useMaterial3: false,
    primaryColor: AppColor.primaryColor,
    appBarTheme: const AppBarTheme(backgroundColor: AppColor.neutralColor),
  );

  void switchTheme(String locale) {
    ThemeData themeData;
    switch (locale) {
      case 'km':
        themeData = ThemeData(
          useMaterial3: false,
          primaryColor: AppColor.primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.neutralColor,
          ),
        );
        break;
      case 'en':
        themeData = ThemeData(
          useMaterial3: false,
          primaryColor: AppColor.primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.neutralColor,
          ),
        );
        break;
      case 'zh':
        themeData = ThemeData(
          useMaterial3: false,
          primaryColor: AppColor.primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.neutralColor,
          ),
        );
        break;
      default:
        themeData = ThemeData(
          useMaterial3: false,
          primaryColor: AppColor.primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.neutralColor,
          ),
        );
    }
    Get.changeTheme(themeData);
  }
}
