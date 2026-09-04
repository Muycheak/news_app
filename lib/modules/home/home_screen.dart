import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/modules/home/controller/home_controller.dart';
import 'package:news_app/modules/home/widgets/breaking_news_section_widget.dart';
import 'package:news_app/modules/home/widgets/category_list_horizontal_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.verticalPadding,
        horizontal: AppSizes.horizontalPadding,
      ),
      child: Column(
        spacing: AppSizes.verticalSpaceXXLarge,
        children: [CategoryListHorizontalWidget(), BreakingNewsSectionWidget()],
      ),
    );
  }
}
