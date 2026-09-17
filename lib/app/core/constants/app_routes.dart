import 'package:news_app/modules/article-details/article_details_screen.dart';
import 'package:news_app/modules/article-details/binding/article_details_binding.dart';
import 'package:news_app/modules/main/main_screen.dart';
import 'package:news_app/app/core/constants/app_enums.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news_app/modules/main/binding/main_binding.dart';
import 'package:news_app/modules/trending/binding/trending_binding.dart';
import 'package:news_app/modules/trending/trending_screen.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: AppScreens.main.route,
    binding: MainBinding(),
    page: () => const MainScreen(),
  ),
  GetPage(
    name: AppScreens.trending.route,
    page: () => const TrendingScreen(),
    binding: TrendingBinding(),
  ),
  GetPage(
    name: AppScreens.articleDetails.route,
    page: () => const ArticleDetailsScreen(),
    binding: ArticleDetailsBinding(),
  ),
];
