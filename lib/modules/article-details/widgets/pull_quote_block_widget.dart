import 'package:flutter/material.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/themes/app_text_size.dart';
import 'package:news_app/app/core/themes/app_textstyles.dart';

class PullQuoteBlockWidget extends StatelessWidget {
  final String text;
  const PullQuoteBlockWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // Use first sentence as the pull-quote
    final String quote = text.split('.').first.trim();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalSpaceXLarge,
        vertical: AppSizes.verticalSpaceXLarge,
      ),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColor.secondaryColor, width: 4),
        ),
        color: AppColor.neutralColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppSizes.borderRadiusMedium),
          bottomRight: Radius.circular(AppSizes.borderRadiusMedium),
        ),
      ),
      child: Text(
        '"$quote."',
        style: AppTextstyles.headline.copyWith(
          fontSize: AppTextSize.header4,
          fontStyle: FontStyle.italic,
          color: AppColor.primaryColor,
          height: 1.5,
        ),
      ),
    );
  }
}
