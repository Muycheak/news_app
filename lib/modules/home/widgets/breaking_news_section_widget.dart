import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/themes/app_text_size.dart';
import 'package:news_app/app/core/themes/app_textstyles.dart';
import 'package:news_app/app/core/widgets/smart_network_image.dart';
import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/modules/home/controller/home_controller.dart';

class BreakingNewsSectionWidget extends GetWidget<HomeController> {
  const BreakingNewsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLoading = false.obs;
    RxString errorMessage = ''.obs;
    RxList<Article> articles = RxList<Article>();

    return Obx(() {
      switch (controller.categoryIndex.value) {
        case 0:
          isLoading = controller.isLoadingGeneral;
          errorMessage = controller.errorMessageGeneral;
          articles = controller.articlesGeneral;
          break;
        case 1:
          isLoading = controller.isLoadingTechnology;
          errorMessage = controller.errorMessageTechnology;
          articles = controller.articlesTechnology;
          break;
        case 2:
          isLoading = controller.isLoadingSports;
          errorMessage = controller.errorMessageSports;
          articles = controller.articlesSports;
          break;
        case 3:
          isLoading = controller.isLoadingBusiness;
          errorMessage = controller.errorMessageBusiness;
          articles = controller.articlesBusiness;
          break;
        case 4:
          isLoading = controller.isLoadingEntertainment;
          errorMessage = controller.errorMessageEntertainment;
          articles = controller.articlesEntertainment;
          break;
        case 5:
          isLoading = controller.isLoadingHealth;
          errorMessage = controller.errorMessageHealth;
          articles = controller.articlesHealth;
          break;
        case 6:
          isLoading = controller.isLoadingScience;
          errorMessage = controller.errorMessageScience;
          articles = controller.articlesScience;
          break;
      }

      if (isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (errorMessage.value.isNotEmpty) {
        return Center(child: Text(errorMessage.value));
      }
      if (articles.isEmpty) {
        return const Center(child: Text('No breaking news available'));
      }

      final article = articles.first;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
                child: AppSmartNetworkImage(
                  imageUrl:
                      article.urlToImage ??
                      'https://images.unsplash.com/photo-1496350785160-b6058a74ec78?q=80&w=600&auto=format&fit=crop',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // BREAKING Badge
              Positioned(
                top: AppSizes.verticalSpaceLarge,
                left: AppSizes.horizontalSpaceLarge,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalSpaceMedium,
                    vertical: AppSizes.verticalSpaceSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusSmall,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSizes.horizontalSpaceSmall),
                      const Text(
                        'BREAKING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppTextSize.caption,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.verticalSpaceMedium),
          // Category and Time
          Text(
            '${article.source?.name ?? "GLOBAL TECH"} • ${article.getTimeAgo()}',
            style: AppTextstyles.lable.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: AppSizes.verticalSpaceSmall),
          // Headline
          Text(
            article.title ?? "",
            style: AppTextstyles.headline.copyWith(
              fontSize: AppTextSize.header1,
            ),
          ),
        ],
      );
    });
  }
}
