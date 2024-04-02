import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/data/all_data.dart';
import 'package:creative_wallpapers/widgets/all_functions.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';




class FullImage extends StatefulWidget {
  const FullImage({
    super.key,
    required this.imageUrl,
    required this.altDescription,
    required this.likes,
    required this.height,
    required this.width,
  });

  final String imageUrl;
  final String altDescription;
  final int likes;
  final int height;
  final int width;

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: Stack(
        alignment: Alignment.center,
        children: [
          // Fullscreen Image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              placeholder: (context, url) => buildShimmerPlaceholder(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // Bottom Container
          Positioned(
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                //gradient: darkGradient,
                color: Colors.black87,
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      saveImageToDevice(context, widget.imageUrl);
                    },
                    child: const Icon(
                      Icons.downloading_sharp,
                      color: textWhite,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      _imageDetails(context);
                    },
                    child: const Icon(
                      Icons.info_outlined,
                      color: textWhite,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _imageDetails(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                capitalize(widget.altDescription),
                style: styleWB20,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Resolution: ( ${widget.height} x ${widget.width} )',style: styleWB16,),
                  Text(
                    'Likes: ${widget.likes}',
                    style: styleWB16,
                  ),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/all_functions.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';

import '../data/all_data.dart';

class FullImage extends StatelessWidget {
  const FullImage({
    Key? key,
    required this.imageUrl,
    required this.altDescription,
    required this.likes,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String imageUrl;
  final String altDescription;
  final int likes;
  final int height;
  final int width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Fullscreen Image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => buildShimmerPlaceholder(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // Bottom Container
          Positioned(
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black87,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      SaveToDevice.saveImageToDevice(context, imageUrl);
                    },
                    child: const Icon(
                      Icons.downloading_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      _imageDetails(context);
                    },
                    child: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _imageDetails(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalize(altDescription),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Resolution: (${height} x ${width})'),
                  Text('Likes: ${likes}'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}*/
