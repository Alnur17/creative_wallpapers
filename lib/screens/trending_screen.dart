import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage
import '../provider/image_provider.dart';
import '../model_class/trending_model.dart'; // Assuming TrendingImage class is defined in this file



class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  final ScrollController _listController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listController.addListener(_scrollListener);
    Provider.of<ImagesProvider>(context, listen: false).fetchSearchedImages('bird');
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final provider = Provider.of<ImagesProvider>(context, listen: false);
    if (_listController.position.pixels ==
        _listController.position.maxScrollExtent) {
      provider.loadMoreImage();
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Images'),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, imagesProvider, _) {
          if (imagesProvider.isLoading && imagesProvider.trendImage.isEmpty) {
            return Center(child: CircularProgressIndicator());
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
                    ListTile(
                      title: Text(
                        image.altDescription,
                        style: TextStyle(
                          color: textWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      trailing: Icon(Icons.favorite_border_rounded),
                    ),
                    CachedNetworkImage(
                      imageUrl: image.regularUrl, // Assuming regularUrl is the URL of the image
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
