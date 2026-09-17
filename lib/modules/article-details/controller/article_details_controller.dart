import 'package:get/get.dart';
import 'package:news_app/app/data/models/article.dart';

class ArticleDetailsController extends GetxController {
  late Article article;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null) {
      article = arguments['article'];
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
