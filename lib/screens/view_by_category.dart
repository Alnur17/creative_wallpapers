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
      Provider.of<ImagesProvider>(context, listen: false).fetchImagesByColorWhenScroll(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: background,
        elevation: 0,
        title: Text(
          widget.value,
          style: styleWB24,
        ),
      ),
      body: Consumer<ImagesProvider>(builder: (context, imagesProvider, _) {
        if (imagesProvider.isLoadingSearch) {
          return buildShimmerPlaceholder();
        } else if (imagesProvider.hasError) {
          return Center(
            child: Text('Error: ${imagesProvider.errorMessage}', style: styleWB24),
          );
        } else{
          if(imagesProvider.searchImage.isNotEmpty){
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
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
                        placeholder: (context, url) => buildShimmerPlaceholder(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
            );
          }else{
            return const Center(
              child: Text(
                'No Data Available',
                style: styleWB16,
              ),
            );
          }
        }
      }),
    );
  }

}
