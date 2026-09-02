import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController = TabController(vsync: this, length: 2);

  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    tabController.animateTo(index);
  }
}
