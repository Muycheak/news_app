import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/core/constants/app_enums.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/widgets/app_news_list_widget.dart';
import 'package:news_app/modules/home/controller/home_controller.dart';
import 'package:news_app/app/data/models/article.dart';

class TrendingNewsSectionWidget extends GetWidget<HomeController> {
  const TrendingNewsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RxList<Article> articles = RxList<Article>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Trending Stories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => {
                Get.toNamed(
                  AppScreens.trending.route,
                  arguments: {
                    "articles": articles,
                    "category":
                        controller.categories[controller.categoryIndex.value],
                  },
                ),
              },
              child: const Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.black87),
                ],
              ),
            ),
          ],
        ),
        // List
        Obx(() {
          switch (controller.categoryIndex.value) {
            case 0:
              articles = controller.articlesGeneral;
              break;
            case 1:
              articles = controller.articlesTechnology;
              break;
            case 2:
              articles = controller.articlesSports;
              break;
            case 3:
              articles = controller.articlesBusiness;
              break;
            case 4:
              articles = controller.articlesEntertainment;
              break;
            case 5:
              articles = controller.articlesHealth;
              break;
            case 6:
              articles = controller.articlesScience;
              break;
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: articles.length,
            separatorBuilder: (context, index) => index == 0
                ? SizedBox.shrink()
                : const SizedBox(height: AppSizes.verticalSpaceXLarge),
            itemBuilder: (context, index) {
              final Article article = articles[index];
              if (index == 0) return const SizedBox.shrink();
              return AppNewsListWidget(article: article);
            },
          );
        }),
      ],
    );
  }
}
