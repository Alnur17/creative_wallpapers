import 'package:creative_wallpapers/widgets/full_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constant/color_palate.dart';
import '../constant/style.dart';
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
    initializeData(context);
  }

  initializeData(context) async {
    await Provider.of<ImagesProvider>(context, listen: false).clearList();
    await Provider.of<ImagesProvider>(context, listen: false)
        .resetCurrentPage();
    Provider.of<ImagesProvider>(context, listen: false)
        .fetchCollectionImages(widget.collectionName);
  }

  void _scrollListener() {
    if (_listController.position.pixels ==
        _listController.position.maxScrollExtent) {
      Provider.of<ImagesProvider>(context, listen: false)
          .fetchCollectionImages(widget.collectionName);
    }
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

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
              .copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProviders, _) {
          if (imagesProviders.isLoadingCollection &&
              imagesProviders.collectionImage.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: textRed,));
          } else if (imagesProviders.hasError &&
              imagesProviders.collectionImage.isEmpty) {
            return Center(
              child: Text(
                imagesProviders.errorMessage,
                style: styleWB16,
              ),
            );
          } else {
            return RefreshIndicator(
              backgroundColor: searchField,
              color: textRed,
              onRefresh: () async {
                await initializeData(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12,bottom: 12),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  controller: _listController,
                  itemCount: imagesProviders.collectionImage.length,
                  itemBuilder: (context, index) {
                    final image = imagesProviders.collectionImage[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullImage(
                            imageUrl: image.fullUrl,
                            altDescription: image.altDescription,
                            likes: image.likes,
                            height: image.height,
                            width: image.width,
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: image.thumbUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              buildShimmerPlaceholder(),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error, color: textWhite),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
