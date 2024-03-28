import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/collection_screen.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';

import '../data/all_data.dart';

class Collections extends StatelessWidget {
  const Collections({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: background,
        elevation: 0,
        title: const Text(
          'Collections',
          style: styleWB24,
        ),
      ),
      body: ListView.builder(
        itemCount: collectionBackgroundImage.length + 1, // Add 1 for SizedBox
        itemBuilder: (context, index) {
          if (index < collectionBackgroundImage.length) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CollectionScreen(
                    collectionName: collectionNames[index],
                  ),
                ),
              ),
              child: Container(
                height: 250,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: collectionBackgroundImage[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              buildShimmerPlaceholder(),
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black54,
                      ),
                      child: Center(
                        child: Text(
                          collectionNames[index],
                          style: styleWB24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Add SizedBox after the last index
            return const SizedBox(height: 96);
          }
        },
      ),
    );
  }
}
