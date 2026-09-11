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

  RxBool isLoadingGeneral = false.obs;
  RxBool isLoadingTechnology = false.obs;
  RxBool isLoadingSports = false.obs;
  RxBool isLoadingBusiness = false.obs;
  RxBool isLoadingEntertainment = false.obs;
  RxBool isLoadingHealth = false.obs;
  RxBool isLoadingScience = false.obs;

  RxString errorMessageGeneral = ''.obs;
  RxString errorMessageTechnology = ''.obs;
  RxString errorMessageSports = ''.obs;
  RxString errorMessageBusiness = ''.obs;
  RxString errorMessageEntertainment = ''.obs;
  RxString errorMessageHealth = ''.obs;
  RxString errorMessageScience = ''.obs;

  RxList<Article> articlesGeneral = RxList<Article>();
  RxList<Article> articlesTechnology = RxList<Article>();
  RxList<Article> articlesSports = RxList<Article>();
  RxList<Article> articlesBusiness = RxList<Article>();
  RxList<Article> articlesEntertainment = RxList<Article>();
  RxList<Article> articlesHealth = RxList<Article>();
  RxList<Article> articlesScience = RxList<Article>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchNews(
      isLoading: isLoadingGeneral,
      errorMessage: errorMessageGeneral,
      articles: articlesGeneral,
    );
  }

  void changeCategoryIndex(int index) {
    categoryIndex.value = index;
    getArticlesByCategories();
  }

  Future<void> getArticlesByCategories() async {
    switch (categoryIndex.value) {
      case 0:
        if (articlesGeneral.isEmpty) {
          await fetchNews(
            isLoading: isLoadingGeneral,
            errorMessage: errorMessageGeneral,
            articles: articlesGeneral,
          );
        }
        break;
      case 1:
        if (articlesTechnology.isEmpty) {
          await fetchNews(
            isLoading: isLoadingTechnology,
            errorMessage: errorMessageTechnology,
            articles: articlesTechnology,
          );
        }
        break;
      case 2:
        if (articlesSports.isEmpty) {
          await fetchNews(
            isLoading: isLoadingSports,
            errorMessage: errorMessageSports,
            articles: articlesSports,
          );
        }
        break;
      case 3:
        if (articlesBusiness.isEmpty) {
          await fetchNews(
            isLoading: isLoadingBusiness,
            errorMessage: errorMessageBusiness,
            articles: articlesBusiness,
          );
        }
        break;
      case 4:
        if (articlesEntertainment.isEmpty) {
          await fetchNews(
            isLoading: isLoadingEntertainment,
            errorMessage: errorMessageEntertainment,
            articles: articlesEntertainment,
          );
        }
        break;
      case 5:
        if (articlesHealth.isEmpty) {
          await fetchNews(
            isLoading: isLoadingHealth,
            errorMessage: errorMessageHealth,
            articles: articlesHealth,
          );
        }
        break;
      case 6:
        if (articlesScience.isEmpty) {
          await fetchNews(
            isLoading: isLoadingScience,
            errorMessage: errorMessageScience,
            articles: articlesScience,
          );
        }
        break;
    }
  }

  Future<void> fetchNews({
    required RxBool isLoading,
    required RxString errorMessage,
    required RxList<Article> articles,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      DateTime dateTime = DateTime.now();

      String today = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

      final RepositoryResult repositoryResult = await _newsRepositories
          .getTopHeadlinesRepo(
            category: categories[categoryIndex.value].toLowerCase(),
            from: today,
            to: today,
          );
      if (repositoryResult.isError) {
        errorMessage.value = repositoryResult.message;
      } else {
        articles.assignAll(repositoryResult.data);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
