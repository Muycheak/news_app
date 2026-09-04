import 'package:get/get.dart';
import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/data/models/repository_result.dart';
import 'package:news_app/app/data/repositories/news_repositories.dart';

class HomeController extends GetxController {
  final NewsRepositories _newsRepositories = NewsRepositories();

  RxList<String> categories = RxList([
    'General',
    'Technology',
    'Sports',
    'Business',
    'Entertainment',
    'Health',
    'Science',
  ]);

  RxInt categoryIndex = 0.obs;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxList<Article> articles = RxList<Article>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchNews();
  }

  void changeCategoryIndex(int index) {
    categoryIndex.value = index;
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      DateTime dateTime = DateTime.now();

      String today = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

      final RepositoryResult repositoryResult = await _newsRepositories
          .getTopHeadlinesRepo(
            category: categories[categoryIndex.value],
            from: today,
            to: today,
          );
      if (repositoryResult.isError) {
        errorMessage.value = repositoryResult.message;
      } else {
        articles.addAll(repositoryResult.data);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
