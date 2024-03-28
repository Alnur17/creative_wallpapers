import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/full_image.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/image_provider.dart';

class ViewByCategory extends StatefulWidget {
  const ViewByCategory({
    super.key,
    required this.value,
  });

  final String value;

  @override
  State<ViewByCategory> createState() => _ViewByCategoryState();
}

class _ViewByCategoryState extends State<ViewByCategory> {
  final ScrollController _listController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listController.addListener(_scrollListener);
    initializeData();
  }

  void initializeData() async {
    await Provider.of<ImagesProvider>(context, listen: false)
        .clearColorSearch();
    final imagesProvider = Provider.of<ImagesProvider>(context, listen: false);
    imagesProvider.fetchImagesByColor(widget.value);
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
          .fetchImagesByColor(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: background,
        elevation: 0,
        title: Text(widget.value,style: styleWB24,),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProvider, _) {
          if (imagesProvider.isLoadingSearch) {
            return buildShimmerPlaceholder();
          } else if (imagesProvider.hasError || imagesProvider.images.isEmpty) {
            return Center(
              child: Text(
                'Error: ${imagesProvider.errorMessage}',
                style: styleWB24,
              ),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 12, // Spacing between columns
                mainAxisSpacing: 12, // Spacing between rows
                childAspectRatio:
                    0.75, // Aspect ratio of grid items (width / height)
              ),
              controller: _listController,
              itemCount: imagesProvider.searchImage.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullImage(
                        imageUrl: imagesProvider.searchImage[index].fullUrl,
                        altDescription: imagesProvider.searchImage[index].altDescription,
                        likes: imagesProvider.searchImage[index].likes,
                        height: imagesProvider.searchImage[index].height,
                        width: imagesProvider.searchImage[index].width,
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: imagesProvider.searchImage[index].thumbUrl,
                      fit: BoxFit.cover,
                    ),
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

/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/image_provider.dart';

class ViewByColor extends StatefulWidget {
  const ViewByColor({
    super.key,
    required this.colorNames,
  });

  final String colorNames;

  @override
  State<ViewByColor> createState() => _ViewByColorState();
}

class _ViewByColorState extends State<ViewByColor> {

  @override
  void initState() {
    final imagesProvider = Provider.of<ImagesProvider>(context, listen: false);
    imagesProvider.clearColorSearch();
    imagesProvider.fetchImagesByColor(widget.colorNames);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: const Text('View By Color'),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProvider, _) {
          if (imagesProvider.isLoadingSearch) {
            return buildShimmerPlaceholder();
          } else if (imagesProvider.hasError) {
            return Center(
              child: Text('Error: ${imagesProvider.errorMessage}',style: styleWB24,),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8, // Spacing between columns
                mainAxisSpacing: 8, // Spacing between rows
                childAspectRatio: 0.75, // Aspect ratio of grid items (width / height)
              ),
              itemCount: imagesProvider.searchImage.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: CachedNetworkImage(
                    imageUrl: imagesProvider.searchImage[index].thumbUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
} */
