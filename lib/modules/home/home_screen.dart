import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/modules/home/controller/home_controller.dart';
import 'package:news_app/modules/home/widgets/breaking_news_section_widget.dart';
import 'package:news_app/modules/home/widgets/category_list_horizontal_widget.dart';
import 'package:news_app/modules/home/widgets/home_shimmer_widget.dart';
import 'package:news_app/modules/home/widgets/trending_news_section_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.verticalPadding,
        horizontal: AppSizes.horizontalPadding,
      ),
      child: Column(
        spacing: AppSizes.verticalSpaceXXLarge,
        children: [
          const CategoryListHorizontalWidget(),
          Obx(() {
            bool isLoading =
                controller.isLoadingGeneral.value ||
                controller.isLoadingTechnology.value ||
                controller.isLoadingSports.value ||
                controller.isLoadingBusiness.value ||
                controller.isLoadingEntertainment.value ||
                controller.isLoadingHealth.value ||
                controller.isLoadingScience.value;
            if (isLoading) {
              return Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: const HomeShimmerWidget(),
                ),
              );
            }
            return const Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  spacing: AppSizes.verticalSpaceXXLarge,
                  children: [
                    BreakingNewsSectionWidget(),
                    Divider(),
                    TrendingNewsSectionWidget(),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
