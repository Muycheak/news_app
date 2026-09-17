import 'package:flutter/material.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/themes/app_colors.dart';

class ActionIconButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const ActionIconButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.horizontalSpaceMedium),
        decoration: BoxDecoration(
          color: AppColor.primaryColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        ),
        child: Icon(icon, size: 20, color: AppColor.primaryColor),
      ),
    );
  }
}
