import 'package:flutter/material.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/themes/app_text_size.dart';
import 'package:news_app/app/core/themes/app_textstyles.dart';

class DropCapTextWidget extends StatelessWidget {
  final String text;
  const DropCapTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();
    final String dropCap = text[0];
    final String rest = text.length > 1 ? text.substring(1) : '';

    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(
                right: AppSizes.horizontalSpaceSmall,
                bottom: 4,
              ),
              child: Text(
                dropCap,
                style: AppTextstyles.headline.copyWith(
                  fontSize: 68,
                  height: 0.85,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ),
          TextSpan(
            text: rest,
            style: TextStyle(
              fontFamily: 'Inter_18pt',
              fontSize: AppTextSize.body1,
              color: AppColor.primaryColor.withValues(alpha: 0.75),
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
