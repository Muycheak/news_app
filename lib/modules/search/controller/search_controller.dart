import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/data/models/repository_result.dart';
import 'package:news_app/app/data/repositories/news_repositories.dart';

class SearchController extends GetxController {
  final NewsRepositories _newsRepositories = NewsRepositories();

  RxBool isLoading = false.obs;
  RxBool isFetching = false.obs;
  RxString errorMessage = ''.obs;
  RxList<Article> articles = RxList<Article>();
  RxString searchQuery = ''.obs;
  late TextEditingController textEditingController;

  @override
  Future<void> onInit() async {
    super.onInit();
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      searchQuery.value = textEditingController.text;
    });
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  Future<void> searchNews(String query) async {
    try {
      isFetching.value = true;
      isLoading.value = true;
      errorMessage.value = "";
      DateTime dateTime = DateTime.now();

      String yesterday =
          '${dateTime.year}-${dateTime.month}-${dateTime.day - 1}';
      String today = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

      final RepositoryResult repositoryResult = await _newsRepositories
          .getEverythingRepo(
            query: query,
            from: yesterday,
            to: today,
            page: 1,
            perPage: 10,
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
