import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCashedImage extends StatelessWidget {
  final String imageURL;
  final BoxFit fit;
  final double height;

  const CustomCashedImage(
      {Key? key, required this.imageURL, required this.fit, this.height = 200})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      fit: fit,
      width: MediaQuery.of(context).size.width,
      height: height,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }
}
