import 'package:get/get.dart';
import 'package:news_app/modules/trending/controller/trending_controller.dart';

class TrendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrendingController>(() => TrendingController(), fenix: true);
  }
}
