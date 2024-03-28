import 'package:creative_wallpapers/widgets/full_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constant/color_palate.dart';
import '../provider/image_provider.dart';
import '../widgets/shimmer_placeholder.dart';

class CollectionScreen extends StatefulWidget {
  final String collectionName;

  const CollectionScreen({super.key, required this.collectionName});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final ScrollController _listController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listController.addListener(_scrollListener);
    initializeData();
  }

  void initializeData() async {
    await Provider.of<ImagesProvider>(context, listen: false).clearSearch();
    final imagesProviders = Provider.of<ImagesProvider>(context, listen: false);
    imagesProviders.fetchCollectionImages(widget.collectionName);
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
          .fetchCollectionImages(widget.collectionName);
    }
  }

  // String capitalize(String input) {
  //   if (input.isEmpty) return input;
  //   return input[0].toUpperCase() + input.substring(1);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        backgroundColor: background,
        title: Text(
          widget.collectionName,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProviders, _) {
          if (imagesProviders.isLoading &&
              imagesProviders.collectionImage.isEmpty) {
            return buildShimmerPlaceholder();
          } else if (imagesProviders.hasError &&
              imagesProviders.images.isEmpty) {
            return Center(
              child: Text(
                imagesProviders.errorMessage,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  mainAxisSpacing: 12, // Spacing between items vertically
                  crossAxisSpacing: 12, // Spacing between items horizontally
                  childAspectRatio: 0.75, // Aspect ratio of each item
                ),
                controller: _listController,
                itemCount: imagesProviders.collectionImage.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullImage(
                          imageUrl:
                              imagesProviders.collectionImage[index].fullUrl,
                          altDescription: imagesProviders.collectionImage[index].altDescription,
                          likes: imagesProviders.collectionImage[index].likes,
                          height: imagesProviders.collectionImage[index].height,
                          width: imagesProviders.collectionImage[index].width,
                        ),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: imagesProviders.collectionImage[index].thumbUrl,
                        fit: BoxFit.cover,
                        // placeholder: (context, url) => buildShimmerPlaceholder(),
                        // errorWidget: (context, url, error) =>
                        //     const Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: background,
        title: const Text('Collection Images'),
      ),
      body:
      Consumer<ImagesProvider>(
        builder: (context, imagesProvider, _) {
          if (imagesProvider.isLoading &&
              imagesProvider.collectionImage.isEmpty) {
            return buildShimmerPlaceholder();
          } else if (imagesProvider.hasError && imagesProvider.images.isEmpty) {
            return Center(child: Text(imagesProvider.errorMessage));
          } else {
            return ListView.builder(
              controller: _listController,
              itemCount: imagesProvider.collectionImage.length,
              itemBuilder: (context, index) {
                final TrendingImage image =
                    imagesProvider.collectionImage[index];
                return Card(
                  color: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            capitalize(image.altDescription),
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
                                  .toggleFavoriteCollections(index);
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FullImage(imageUrl: image.fullUrl),
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: image.regularUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                buildShimmerPlaceholder(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        //const SizedBox(height: 10),
                      ],
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
  */
