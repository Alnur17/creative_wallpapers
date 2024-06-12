import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/data/all_data.dart';
import 'package:creative_wallpapers/widgets/all_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/style.dart';

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
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: textRed,),
              ),
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
                color: Colors.black,
              ),
              child: Row(
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
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      handleApply(widget.imageUrl, context);
                    },
                    child: const Icon(
                      Icons.save_as,
                      color: textWhite,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 30),
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
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 40,bottom: 40,left: 16,right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                  Text(
                    'Resolution: ( ${widget.height} x ${widget.width} )',
                    style: styleWB16,
                  ),
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

Future<void> handleApply(String image, BuildContext context) async {
  try {
    final file = await DefaultCacheManager().getSingleFile(image);
    showModalBottomSheet(
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
       topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              const Text(
                "What would you like to do?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: textWhite,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone_android_sharp,
                    color: textWhite,
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                      // Set wallpaper for home screen
                      await WallpaperManager.setWallpaperFromFile(
                        file.path,
                        WallpaperManager.HOME_SCREEN,
                      );
                      Fluttertoast.showToast(
                        msg: "Wallpaper applied to Home Screen",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                    child: const Text(
                      'Set on home screen',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textWhite,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.screen_lock_portrait_sharp,
                    color: textWhite,
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                      // Set wallpaper for lock screen
                      await WallpaperManager.setWallpaperFromFile(
                        file.path,
                        WallpaperManager.LOCK_SCREEN,
                      );
                      Fluttertoast.showToast(
                        msg: "Wallpaper applied to Lock Screen",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                    child: const Text(
                      "Set on lock screen",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textWhite,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phonelink_lock_sharp,
                    color: textWhite,
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                      // Set wallpaper for both screens
                      await WallpaperManager.setWallpaperFromFile(
                        file.path,
                        WallpaperManager.BOTH_SCREEN,
                      );
                      Fluttertoast.showToast(
                        msg: "Wallpaper applied to both screens",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                    child: const Text(
                      'Set on both screen',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textWhite,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Failed to apply wallpaper",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
