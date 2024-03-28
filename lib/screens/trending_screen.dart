import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/save_images.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:creative_wallpapers/model_class/trending_image.dart';

import '../provider/image_provider.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  int _currentImageIndex = 0;


  // final ScrollController _scrollController = ScrollController();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(_scrollListener);
  //   Provider.of<ImagesProvider>(context, listen: false).fetchTrendingImages('');
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  //
  // void _scrollListener() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     Provider.of<ImagesProvider>(context, listen: false)
  //         .fetchTrendingImages('');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        // appBar: AppBar(
        //   backgroundColor: background,
        //   elevation: 0,
        //   title: const Text("Trending Wallpapers"),
        // ),
        body: Consumer<ImagesProvider>(
          builder: (context, imagesProvider, _) {
            return Stack(
              children: [
                Positioned.fill(
                  child: imagesProvider.isLoadingTrending
                      ? buildShimmerPlaceholder()
                      : CarouselSlider.builder(
                          itemCount: imagesProvider.trendImage.length,
                          options: CarouselOptions(
                            //height: MediaQuery.of(context).size.height,
                            scrollDirection: Axis.vertical,
                            autoPlay: false,
                            padEnds: true,
                            viewportFraction: 1,
                            initialPage: _currentImageIndex,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentImageIndex = index;
                              });
                              if (
                                  index == imagesProvider.trendImage.length - 1) {
                                // Load more data
                                imagesProvider.fetchTrendingImages('trending');

                              }
                            },
                          ),
                          itemBuilder: (context, index, realIndex) {
                            TrendingImage image =
                                imagesProvider.trendImage[index];
                            return CachedNetworkImage(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              imageUrl: image.regularUrl,
                              fit: BoxFit.contain,
                              placeholder: (context, url) =>
                                  buildShimmerPlaceholder(),
                            );
                          },
                        ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black54,
                    ),
                    child: const Text(
                      "Trending",
                      style: styleWB24,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black54,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            String imageUrl = imagesProvider.trendImage[_currentImageIndex].fullUrl;
                            SaveToDevice.saveImage(context, imageUrl);
                          },
                          child: const Icon(
                            Icons.downloading_sharp,
                            color: textWhite,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.favorite_border_rounded,
                          color: textWhite,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

// Function to build shimmer effect
}

/*
import 'package:creative_wallpapers/constant/color_palate.dart';

import 'package:creative_wallpapers/widgets/full_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../provider/image_provider.dart';
import '../model_class/trending_image.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  final ScrollController _listController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_listController.position.pixels ==
        _listController.position.maxScrollExtent) {
      Provider.of<ImagesProvider>(context, listen: false)
          .fetchTrendingImages('mosque');
    }
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: const Text('Trending Images'),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProvider, _) {
          if (imagesProvider.isLoading && imagesProvider.trendImage.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (imagesProvider.hasError && imagesProvider.images.isEmpty) {
            return Center(child: Text(imagesProvider.errorMessage));
          } else {
            return ListView.builder(
              controller: _listController,
              itemCount: imagesProvider.trendImage.length,
              itemBuilder: (context, index) {
                final TrendingImage image = imagesProvider.trendImage[index];
                return Card(
                  color: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          capitalize(image.altDescription),
                          //image.altDescription.toUpperCase(),
                          style: const TextStyle(
                            color: textWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            image.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: image.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            Provider.of<ImagesProvider>(context, listen: false)
                                .toggleFavoriteTrending(index);
                          },
                        ),
                      ),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullImage(
                                      imageUrl: image.fullUrl,
                                      altHeader: image.altDescription,
                                    ),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: image.regularUrl,
                                fit: BoxFit.cover,
                                height: 250,
                                width: double.maxFinite,
                                placeholder: (context, url) =>
                                    Center(child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.download,
                                  size: 24,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );


  }
}
*/

/*Scaffold(
      appBar: AppBar(
        title: const Text('Trending Images'),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProvider, _) {
          if (imagesProvider.isLoading && imagesProvider.trendImage.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (imagesProvider.hasError && imagesProvider.images.isEmpty) {
            return Center(child: Text(imagesProvider.errorMessage));
          } else {
            return ListView.builder(
              controller: _listController,
              itemCount: imagesProvider.trendImage.length,
              itemBuilder: (context, index) {
                final TrendingImage image = imagesProvider.trendImage[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullImage(imageUrl: image.regularUrl),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black54,
                                child: ListTile(
                                  title: Text(
                                    capitalize(image.altDescription),
                                    //image.altDescription.toUpperCase(),
                                    style: const TextStyle(
                                      color: textWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      image.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: image.isFavorite ? Colors.red : null,
                                    ),
                                    onPressed: () {
                                      Provider.of<ImagesProvider>(context,
                                              listen: false)
                                          .toggleFavoriteTrending(index);
                                    },
                                  ),
                                ),
                              ),
                              CachedNetworkImage(
                                imageUrl: image.regularUrl,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );*/
