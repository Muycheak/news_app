import 'package:flutter/material.dart';
import 'package:news_app/app/core/locals/local_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/app/core/widgets/loadings/place_hoder_view.dart';

class AppSmartNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Alignment alignment;
  const AppSmartNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.fitWidth,
    this.height = double.infinity,
    this.width = double.infinity,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: fit,
      filterQuality: FilterQuality.high,
      errorWidget: (context, url, error) {
        return Icon(Icons.image_not_supported);
      },
      placeholder: (context, url) {
        return PlaceHolderView(backgroundColor: Colors.transparent);
      },
      cacheManager: LocalCache().cacheManager,
    );
  }
}
