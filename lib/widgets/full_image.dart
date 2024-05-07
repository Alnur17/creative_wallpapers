import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/data/all_data.dart';
import 'package:creative_wallpapers/widgets/all_functions.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                      handleApply(widget.imageUrl, context);
                    },
                    child: const Icon(
                      Icons.save_as,
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
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                const Text(
                  "What would you like to do?",
                  style: TextStyle(
                    fontSize: 18,
                    color: textWhite,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(Icons.phone_android_sharp,
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
                          fontSize: 14,
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
                  children: [
                    const Icon(Icons.screen_lock_portrait_sharp,
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
                          fontSize: 14,
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
                  children: [
                    const Icon(Icons.phonelink_lock_sharp,
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
                          fontSize: 14,
                          color: textWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
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


// Future<void> handleApply(BuildContext context, String imageUrl) async {
//   try {
//     final file = await DefaultCacheManager().getSingleFile(imageUrl);
//     Fluttertoast.showToast(
//       msg: "Applying wallpaper...",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//     );
//     await WallpaperManager.setWallpaperFromFile(file.path, WallpaperManager.HOME_SCREEN);
//     Fluttertoast.showToast(
//       msg: "Wallpaper applied successfully",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//     );
//   } catch (e) {
//     Fluttertoast.showToast(
//       msg: "Failed to apply wallpaper",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//     );
//   }
// }

/*Future<Null> handleApply(String image, BuildContext context) async {
  String? result;
  // ignore: prefer_typing_uninitialized_variables
  var file;

  try {
    showModalBottomSheet(
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                const Text(
                  "What would you like to do?",
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.w700,
                    color: textWhite,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(Icons.phone_android_sharp,
                      color: textWhite,
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg:
                              "Setting Home Screen Wallpaper Please Wait... ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        file =
                            await DefaultCacheManager().getSingleFile(image);
                        result = await WallpaperManager.setWallpaperFromFile(
                                file.path, WallpaperManager.HOME_SCREEN)
                            // ignore: missing_return
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: "Successfully Set Wallpaper",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          return null;
                        });
                      },
                      child: const Text(
                        'Set on home screen',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
                  children: [
                     const Icon(Icons.screen_lock_portrait_sharp,
                       color: textWhite,
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg:
                              "Setting Lock Screen Wallpaper Please Wait... ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        file =
                            await DefaultCacheManager().getSingleFile(image);
                        result = await WallpaperManager.setWallpaperFromFile(
                                file.path, WallpaperManager.LOCK_SCREEN)
                            // ignore: missing_return
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: "Successfully Set Wallpaper",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          return null;
                        });
                      },
                      child: const Text(
                        "Set on lock screen",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
                  children: [
                    const Icon(Icons.phonelink_lock_sharp,
                      color: textWhite,
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg:
                              "Setting Both Screen Wallpaper Please Wait... ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        file =
                            await DefaultCacheManager().getSingleFile(image);
                        result = await WallpaperManager.setWallpaperFromFile(
                                file.path, WallpaperManager.BOTH_SCREEN)
                            // ignore: missing_return
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: "Successfully Set Wallpaper",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          return null;
                        });
                      },
                      child: const Text(
                        'Set on both screen',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  } on PlatformException {
    result = 'Failed to get wallpaper.';
  }
}*/

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
