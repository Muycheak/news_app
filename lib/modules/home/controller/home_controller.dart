import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> categories = RxList([
    'Trending',
    'Sports',
    'Tech',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'World',
    'Politics',
    'Lifestyle',
    'Fashion',
    'Travel',
    'Food',
    'Other',
  ]);

  RxInt categoryIndex = 0.obs;

  void changeCategoryIndex(int index) {
    categoryIndex.value = index;
  }
}
