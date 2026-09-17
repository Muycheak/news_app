import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_app/modules/article-details/widgets/action_icon_button_widget.dart';
import 'package:news_app/modules/article-details/widgets/drop_cap_text_widget.dart';
import 'package:news_app/modules/article-details/widgets/pull_quote_block_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app/app/core/constants/app_sizes.dart';
import 'package:news_app/app/core/themes/app_colors.dart';
import 'package:news_app/app/core/themes/app_text_size.dart';
import 'package:news_app/app/core/themes/app_textstyles.dart';
import 'package:news_app/app/core/widgets/smart_network_image.dart';
import 'package:news_app/modules/article-details/controller/article_details_controller.dart';

class ArticleDetailsScreen extends GetView<ArticleDetailsController> {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final article = controller.article;
    final String fallbackImage =
        'https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=1200&auto=format&fit=crop';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              stretch: true,
              backgroundColor: AppColor.primaryColor,
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppSmartNetworkImage(
                      imageUrl: article.urlToImage ?? fallbackImage,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    // Gradient overlay for readability
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColor.primaryColor.withValues(alpha: 0.7),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding,
                  vertical: AppSizes.verticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category tag + reading time
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.horizontalSpaceLarge,
                            vertical: AppSizes.verticalSpaceSmall,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.secondaryColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusSmall,
                            ),
                          ),
                          child: Text(
                            (article.source?.name ?? 'NEWS').toUpperCase(),
                            style: const TextStyle(
                              fontSize: AppTextSize.caption,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondaryColor,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.horizontalSpaceMedium),
                        Text(
                          '4 min read',
                          style: AppTextstyles.lable.copyWith(
                            fontSize: AppTextSize.caption,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSizes.verticalSpaceLarge),

                    // Headline
                    Text(
                      article.title ?? '',
                      style: AppTextstyles.headline.copyWith(
                        fontSize: AppTextSize.header1,
                        height: 1.25,
                      ),
                    ),

                    const SizedBox(height: AppSizes.verticalSpaceLarge),

                    Row(
                      children: [
                        // Author avatar
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColor.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            _initials(article.author),
                            style: const TextStyle(
                              fontFamily: 'Inter_18pt',
                              fontSize: AppTextSize.caption,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.horizontalSpaceMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.author ?? 'Unknown Author',
                                style: const TextStyle(
                                  fontFamily: 'Inter_18pt',
                                  fontSize: AppTextSize.caption,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${article.source?.name ?? ''} • ${article.getTimeAgo()}',
                                style: AppTextstyles.lable.copyWith(
                                  fontSize: AppTextSize.small,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSizes.verticalSpaceLarge),

                    Row(
                      children: [
                        ActionIconButtonWidget(
                          icon: Icons.share_outlined,
                          onTap: () => _shareArticle(article.url),
                        ),
                        const SizedBox(width: AppSizes.horizontalSpaceXLarge),
                        ActionIconButtonWidget(
                          icon: Icons.open_in_new_rounded,
                          onTap: () => _openInBrowser(article.url),
                        ),
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.verticalSpaceLarge,
                      ),
                      child: Divider(),
                    ),

                    if (article.description != null) ...[
                      DropCapTextWidget(text: article.description!),
                      const SizedBox(height: AppSizes.verticalSpaceXXLarge),
                    ],

                    if (article.description != null)
                      PullQuoteBlockWidget(text: article.description!),

                    const SizedBox(height: AppSizes.verticalSpaceXXLarge),

                    // Extended body (content excerpt)
                    Text(
                      article.description ?? 'No additional content available.',
                      style: TextStyle(
                        fontFamily: 'Inter_18pt',
                        fontSize: AppTextSize.body1,
                        color: AppColor.primaryColor.withValues(alpha: 0.75),
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 40),

                    if (article.url != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _openInBrowser(article.url),
                          icon: const Icon(Icons.open_in_new_rounded, size: 18),
                          label: const Text('Read Full Article'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadiusMedium,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontFamily: 'Inter_18pt',
                              fontSize: AppTextSize.body1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts[1][0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  Future<void> _openInBrowser(String? url) async {
    if (url == null) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _shareArticle(String? url) {
    if (url == null) return;
    Clipboard.setData(ClipboardData(text: url));
    Get.snackbar(
      'Link Copied',
      'Article link copied to clipboard.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.primaryColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(AppSizes.horizontalPadding),
      borderRadius: AppSizes.borderRadiusMedium,
    );
  }
}
