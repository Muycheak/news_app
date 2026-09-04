import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/themes/app_text_size.dart';
import 'package:news_app/app/core/themes/app_textstyles.dart';
import 'package:news_app/modules/home/controller/home_controller.dart';

class BreakingNewsSectionWidget extends GetView<HomeController> {
  const BreakingNewsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (controller.articles.isEmpty) {
        return const Center(child: Text('No breaking news available'));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
                child: Image.network(
                  controller.articles.first.urlToImage ??
                      'https://images.unsplash.com/photo-1496350785160-b6058a74ec78?q=80&w=600&auto=format&fit=crop', // Skyscraper image
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 220,
                    width: double.infinity,
                    color: AppColor.primaryColor.withValues(alpha: 0.1),
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
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
            'GLOBAL TECH • 2 HOURS AGO',
            style: AppTextstyles.lable.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: AppSizes.verticalSpaceSmall),
          // Headline
          Text(
            'The Architecture of Tomorrow: How AI is Reshaping Urban Landscapes Globally',
            style: AppTextstyles.headline.copyWith(
              fontSize: AppTextSize.header1,
            ),
          ),
        ],
      );
    });
  }
}
