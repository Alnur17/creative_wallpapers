import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  const FullImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  //final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fill,
          // Add a placeholder widget while loading
          placeholder: (context, progress) => CircularProgressIndicator(),
          errorWidget: (context, error, retry) => Icon(Icons.error),
        ),
      ),
    );
  }
}
