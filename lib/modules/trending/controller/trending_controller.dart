import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/data/models/repository_result.dart';
import 'package:news_app/app/data/repositories/news_repositories.dart';

class TrendingController extends GetxController {
  final NewsRepositories _newsRepositories = NewsRepositories();
  final RxList<Article> articles = <Article>[].obs;
  String selectCategories = "";
  final ScrollController scrollController = ScrollController();
  bool _hasMore = true;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = "".obs;

  int page = 2;
  int perPage = 10;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    if (arguments != null) {
      articles.assignAll(arguments['articles'] ?? []);
      selectCategories = arguments['category'] ?? "";
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading.value &&
          _hasMore) {
        loadMore();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadMore() async {
    if (isLoading.value || !_hasMore) return;
    try {
      isLoading.value = true;
      errorMessage.value = "";
      DateTime dateTime = DateTime.now();

      String today = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

      final RepositoryResult repositoryResult = await _newsRepositories
          .getTopHeadlinesRepo(
            category: selectCategories.toLowerCase(),
            from: today,
            to: today,
            page: page,
            perPage: perPage,
          );
      if (repositoryResult.isError) {
        errorMessage.value = repositoryResult.message;
      } else {
        if (repositoryResult.data.isEmpty) {
          _hasMore = false;
        } else {
          articles.addAll(repositoryResult.data);
          page++;
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
