import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/full_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../provider/image_provider.dart';
import '../model_class/trending_model.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
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
          .fetchCollectionImages('bird');
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
        title: const Text('Collection Images'),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProvider, _) {
          if (imagesProvider.isLoading &&
              imagesProvider.collectionImage.isEmpty) {
            return const Center(child: CircularProgressIndicator());
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
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16)),
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
                            ),maxLines: 1,
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
                                  .toggleFavoriteCollections(index);
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FullImage(imageUrl: image.fullUrl),));
                          },
                          child: CachedNetworkImage(
                            imageUrl: image.regularUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
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
}
