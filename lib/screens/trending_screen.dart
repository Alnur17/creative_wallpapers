import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:creative_wallpapers/model_class/trending_image.dart';

import '../constant/style.dart';
import '../provider/image_provider.dart';
import '../widgets/all_functions.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Consumer<ImagesProvider>(
          builder: (context, imagesProvider, _) {
            return Stack(
              alignment: const Alignment(0, 0),
              children: [
                Positioned.fill(
                  child: imagesProvider.isLoadingTrending
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: textRed,
                        ))
                      : CarouselSlider.builder(
                          itemCount: imagesProvider.trendImage.length,
                          options: CarouselOptions(
                            scrollDirection: Axis.vertical,
                            autoPlay: false,
                            padEnds: true,
                            viewportFraction: 1,
                            initialPage: _currentImageIndex,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentImageIndex = index;
                              });
                              if (index ==
                                  imagesProvider.trendImage.length - 1) {
                                // Load more data
                                imagesProvider.fetchTrendingImages('trending');
                              }
                            },
                          ),
                          itemBuilder: (context, index, realIndex) {
                            TrendingImage image =
                                imagesProvider.trendImage[index];
                            return CachedNetworkImage(
                              height: double.infinity,
                              width: double.infinity,
                              imageUrl: image.regularUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                            );
                          },
                        ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black54,
                    ),
                    child: const Text(
                      "Trending",
                      style: styleWB20,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black54,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        String imageUrl = imagesProvider
                            .trendImage[_currentImageIndex].fullUrl;
                        saveImageToDevice(context, imageUrl);
                      },
                      child: const Icon(
                        Icons.downloading_sharp,
                        color: textWhite,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                if (_currentImageIndex == 0)
                  Positioned(
                    bottom: 106,
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black87,
                        ),
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please scroll to see more image',
                                  style: styleWB16,
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/icons/Arrow.gif',
                          ),
                        )),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
