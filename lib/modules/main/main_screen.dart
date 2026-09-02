import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/themes/app_text_size.dart';
import 'package:news_app/app/core/themes/app_textstyles.dart';
import 'package:news_app/gen/assets.gen.dart';
import 'package:news_app/modules/home/home_screen.dart';
import 'package:news_app/modules/main/controller/main_controller.dart';
import 'package:news_app/modules/search/search_screen.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'NEWS TODAY',
          style: AppTextstyles.headline.copyWith(fontSize: AppTextSize.header1),
        ),
        elevation: 0.5,
      ),
      body: TabBarView(
        controller: controller.tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [HomeScreen(), SearchScreen()],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTabIndex,
          selectedItemColor: AppColor.secondaryColor,
          selectedLabelStyle: TextStyle(
            color: AppColor.secondaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedItemColor: AppColor.primaryColor,
          unselectedLabelStyle: TextStyle(
            color: AppColor.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.navigation.homeIcon,
                height: 24,
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.navigation.homeIcon,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  AppColor.secondaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.navigation.searchIcon,
                height: 24,
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.navigation.searchIcon,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  AppColor.secondaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Search",
            ),
          ],
        ),
      ),
    );
  }
}
