import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:news_app/modules/search/controller/search_controller.dart'
    as search_controller;

class SearchScreen extends GetView<search_controller.SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search'));
  }
}
