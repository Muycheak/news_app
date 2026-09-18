import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/widgets/app_news_list_widget.dart';
import 'package:news_app/modules/home/widgets/home_shimmer_widget.dart';
import 'package:news_app/modules/search/widgets/category_card_widget.dart';
import 'package:news_app/modules/search/controller/search_controller.dart'
    as search_controller;

class SearchScreen extends GetView<search_controller.SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          top: AppSizes.verticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: controller.textEditingController,
              decoration: InputDecoration(
                hintText: 'Search for news, topics, or sources',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                suffixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  controller.searchNews(value.trim());
                } else {
                  controller.isFetching.value = false;
                }
              },
              onChanged: (value) {
                if (value.trim().isEmpty) controller.isFetching.value = false;
              },
            ),
            const SizedBox(height: 32),
            Obx(() {
              if (!controller.isFetching.value) {
                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    //physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Browse Categories Title
                      const Text(
                        'Browse Categories',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia', // using a generic serif font
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Business & Finance
                      const CategoryCardWidget(
                        title: 'Business & Finance',
                        height: 180,
                        width: double.infinity,
                        titleStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                        ),
                        alignment: Alignment.bottomLeft,
                        // Using a placeholder image for now
                        imageUrl:
                            'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=600&auto=format&fit=crop',
                      ),
                      const SizedBox(height: 16),
                      // Grid Row 1
                      Row(
                        children: const [
                          Expanded(
                            child: CategoryCardWidget(
                              title: 'TECHNOLOGY',
                              height: 180,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=400&auto=format&fit=crop',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CategoryCardWidget(
                              title: 'SCIENCE',
                              height: 180,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=400&auto=format&fit=crop',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Grid Row 2
                      Row(
                        children: const [
                          Expanded(
                            child: CategoryCardWidget(
                              title: 'LIFESTYLE',
                              height: 180,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1445205170230-053b83016050?q=80&w=400&auto=format&fit=crop',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CategoryCardWidget(
                              title: 'POLITICS',
                              height: 180,
                              width: double.infinity,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1523292562811-8fa7962a78c8?q=80&w=400&auto=format&fit=crop',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                if (controller.isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: AppSizes.horizontalSpaceXLarge,
                      ),
                      itemBuilder: (context, index) => const NewsCardShimmer(),
                    ),
                  );
                }

                if (controller.articles.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final Article article = controller.articles[index];
                    return AppNewsListWidget(article: article);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: AppSizes.horizontalSpaceXLarge,
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
