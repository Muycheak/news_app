import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/themes/app_colors.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSizes.verticalSpaceXXLarge,
          children: [
            // ── Breaking News shimmer ────────────────────────────────────────
            const _BreakingNewsShimmer(),

            const Divider(),

            // ── Trending Stories shimmer ─────────────────────────────────────
            const _TrendingStoriesShimmer(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Breaking News skeleton
// ---------------------------------------------------------------------------
class _BreakingNewsShimmer extends StatelessWidget {
  const _BreakingNewsShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Large hero image placeholder
        _shimmerBox(
          height: 220,
          width: double.infinity,
          borderRadius: AppSizes.borderRadiusLarge,
        ),
        const SizedBox(height: AppSizes.verticalSpaceMedium),

        // Source • time line
        _shimmerBox(height: 14, width: 160),
        const SizedBox(height: AppSizes.verticalSpaceSmall),

        // Headline – 2 lines
        _shimmerBox(height: 20, width: double.infinity),
        const SizedBox(height: AppSizes.verticalSpaceSmall),
        _shimmerBox(height: 20, width: 260),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Trending Stories skeleton
// ---------------------------------------------------------------------------
class _TrendingStoriesShimmer extends StatelessWidget {
  const _TrendingStoriesShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row: "Trending Stories" title + "View All" button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _shimmerBox(height: 22, width: 160),
            _shimmerBox(height: 22, width: 70),
          ],
        ),
        const SizedBox(height: AppSizes.verticalSpaceXLarge),

        // 3 article card skeletons
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) =>
              const SizedBox(height: AppSizes.verticalSpaceXLarge),
          itemBuilder: (_, __) => const _NewsCardShimmer(),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Individual news-card skeleton (mirrors AppNewsListWidget layout)
// ---------------------------------------------------------------------------
class _NewsCardShimmer extends StatelessWidget {
  const _NewsCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.neutralColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail image placeholder
          _shimmerBox(
            height: 200,
            width: double.infinity,
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Source • time row
                Row(
                  children: [
                    _shimmerBox(height: 12, width: 80),
                    const SizedBox(width: 8),
                    _shimmerBox(height: 12, width: 8),
                    const SizedBox(width: 8),
                    _shimmerBox(height: 12, width: 60),
                  ],
                ),
                const SizedBox(height: 8),

                // Title – 3 lines
                _shimmerBox(height: 22, width: double.infinity),
                const SizedBox(height: 6),
                _shimmerBox(height: 22, width: double.infinity),
                const SizedBox(height: 6),
                _shimmerBox(height: 22, width: 200),
                const SizedBox(height: 8),

                // Description – 3 lines
                _shimmerBox(height: 15, width: double.infinity),
                const SizedBox(height: 4),
                _shimmerBox(height: 15, width: double.infinity),
                const SizedBox(height: 4),
                _shimmerBox(height: 15, width: 220),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helper: a simple rounded rectangle shimmer block
// ---------------------------------------------------------------------------
Widget _shimmerBox({
  required double height,
  required double width,
  double borderRadius = AppSizes.borderRadiusSmall,
  Radius? topLeft,
  Radius? topRight,
}) {
  final BorderRadius radius = (topLeft != null || topRight != null)
      ? BorderRadius.only(
          topLeft: topLeft ?? Radius.zero,
          topRight: topRight ?? Radius.zero,
        )
      : BorderRadius.circular(borderRadius);

  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: radius,
    ),
  );
}
