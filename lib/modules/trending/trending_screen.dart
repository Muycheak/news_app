import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/themes/app_text_size.dart';
import 'package:news_app/app/core/themes/app_textstyles.dart';
import 'package:news_app/app/core/widgets/app_news_list_widget.dart';
import 'package:news_app/modules/trending/controller/trending_controller.dart';

class TrendingScreen extends GetView<TrendingController> {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          onPressed: () => Get.back(),
          color: AppColor.primaryColor,
        ),
        centerTitle: true,
        title: Text(
          'TRENDING NEWS',
          style: AppTextstyles.headline.copyWith(fontSize: AppTextSize.header1),
        ),
        elevation: 0.5,
      ),
      body: Obx(() {
        return ListView.separated(
          controller: controller.scrollController,
          itemCount: controller.articles.length + (controller.isLoading.value ? 1 : 0),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding,
            vertical: AppSizes.verticalSpaceLarge,
          ),
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSizes.verticalSpaceXLarge),
          itemBuilder: (context, index) {
            if (index == controller.articles.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final Article article = controller.articles[index];
            return AppNewsListWidget(article: article);
          },
        );
      }),
    );
  }
}
