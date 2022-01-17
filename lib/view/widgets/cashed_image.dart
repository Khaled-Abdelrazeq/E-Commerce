import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCashedImage extends StatelessWidget {
  final String imageURL;
  final BoxFit fit;

  const CustomCashedImage({Key? key, required this.imageURL, required this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      fit: fit,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }
}
