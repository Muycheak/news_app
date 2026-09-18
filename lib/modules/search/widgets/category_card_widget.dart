import 'package:flutter/material.dart';
import 'package:news_app/app/core/themes/app_colors.dart';

class CategoryCardWidget extends StatelessWidget {
  final String title;
  final double height;
  final double? width;
  final TextStyle? titleStyle;
  final Alignment alignment;
  final String imageUrl;

  const CategoryCardWidget({
    super.key,
    required this.title,
    required this.height,
    this.width,
    this.titleStyle,
    this.alignment = Alignment.bottomLeft,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColor.primaryColor.withValues(alpha: 0.4),
            BlendMode.darken,
          ),
        ),
      ),
      padding: const EdgeInsets.all(20),
      alignment: alignment,
      child: Text(
        title,
        style:
            titleStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
