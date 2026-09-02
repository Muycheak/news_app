import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/themes/app_textstyles.dart';
import 'package:news_app/modules/home/controller/home_controller.dart';

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
        spacing: AppSizes.verticalSpaceMedium,
        children: [
          Obx(
            () => SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Obx(
                    () => InkWell(
                      onTap: () => controller.changeCategoryIndex(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.categoryIndex.value == index
                              ? AppColor.primaryColor
                              : AppColor.neutralColor,
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusSmall,
                          ),
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Center(
                          child: Text(
                            controller.categories[index],
                            style: AppTextstyles.headline.copyWith(
                              color: controller.categoryIndex.value == index
                                  ? AppColor.neutralColor
                                  : AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: AppSizes.horizontalSpaceMedium);
                },
                itemCount: controller.categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
