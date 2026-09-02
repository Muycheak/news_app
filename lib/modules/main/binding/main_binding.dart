import 'package:get/instance_manager.dart';
import 'package:news_app/modules/home/controller/home_controller.dart';
import 'package:news_app/modules/main/controller/main_controller.dart';
import 'package:news_app/modules/search/controller/search_controller.dart'
    as search_controller;

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<search_controller.SearchController>(
      () => search_controller.SearchController(),
      fenix: true,
    );
  }
}
