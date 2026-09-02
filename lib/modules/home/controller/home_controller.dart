import 'package:get/get.dart';
import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/data/models/repository_result.dart';
import 'package:news_app/app/data/repositories/news_repositories.dart';

class HomeController extends GetxController {
  final NewsRepositories _newsRepositories = NewsRepositories();

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

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchNews();
  }

  void changeCategoryIndex(int index) {
    categoryIndex.value = index;
  }

  Future<void> fetchNews() async {
    try {
      final RepositoryResult repositoryResult = await _newsRepositories
          .getEverythingRepo(query: null, from: '2026-09-01', to: '2026-09-01');
      if (repositoryResult.isError) {
        // Process the news data
      } else {
        List<Article> articles = repositoryResult.data;
      }
    } catch (e) {
      // Handle error
    }
  }
}
