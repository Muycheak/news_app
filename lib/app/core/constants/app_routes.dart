import 'package:news_app/modules/main/main_screen.dart';
import 'package:news_app/app/core/constants/app_enums.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news_app/modules/main/binding/main_binding.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: AppScreens.main.route,
    binding: MainBinding(),
    page: () => const MainScreen(),
  ),
];
