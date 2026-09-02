import 'package:flutter/material.dart';
import 'package:news_app/app/core/themes/app_themes.dart';
import 'package:news_app/app/core/constants/app_enums.dart';
import 'package:news_app/app/core/constants/app_routes.dart';
import 'package:news_app/app/core/configs/locator_config.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocatorConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: AppThemeService().theme,
      color: Colors.transparent,
      scrollBehavior: NoGlowScrollBehavior(),
      initialRoute: AppScreens.main.route,
      getPages: routes,
    );
  }
}

// A ScrollBehavior that disables the default overscroll glow/indicator.
/// Applied globally to the app to remove the blue glow seen at scroll edges.
class NoGlowScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // no glow or indicator
  }
}
