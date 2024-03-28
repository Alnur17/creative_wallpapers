import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/data/all_data.dart';
import 'package:creative_wallpapers/widgets/save_images.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Expanded(
      //         child: Text(
      //           widget.altHeader ?? '',
      //           style: const TextStyle(color: textWhite, fontSize: 20),
      //           maxLines: 2,
      //           overflow: TextOverflow.ellipsis,
      //         ),
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.all(8),
      //         child: Icon(Icons.favorite_border_rounded),
      //       ),
      //     ],
      //   ),
      // ),
      body: Stack(
        children: [
          // Fullscreen Image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => buildShimmerPlaceholder(),
              // placeholder: (context, url) =>
              //     const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
          // Bottom Container
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                //gradient: darkGradient,
                color: Colors.black54,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      SaveToDevice.saveImage(context, imageUrl);
                    },
                    child: const Icon(
                      Icons.downloading_sharp,
                      color: textWhite,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _setAsWallpaper(context);
                    },
                    child: const Icon(
                      Icons.now_wallpaper_rounded,
                      color: textWhite,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _imageDetails(context);
                    },
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: textWhite,
                      size: 30,
                    ),
                  ),
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


  void _setAsWallpaper(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: matteBlack,
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
                style: styleWB18,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Resolution: $height x $width',style: styleWB16,),
                  Text(
                    'Likes: $likes',
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
                style: styleWB18,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Resolution: ( $height x $width )',style: styleWB16,),
                  Text(
                    'Likes: $likes',
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

/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  const FullImage({super.key,
    required this.imageUrl,
    this.altHeader,
  });
  final String? altHeader;
  final String imageUrl;

  //final int index;

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    altHeader ?? '',
                    style: TextStyle(color: textWhite,fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Icon(Icons.favorite_border_rounded),
              ],
            ),
          ),
        ),

        body: Center(
          child: Column(
            children: [

              CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                height: 65,
                //color: Colors.red,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black54,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.save_alt_rounded),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.now_wallpaper_rounded),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child:Icon(Icons.info_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 */
