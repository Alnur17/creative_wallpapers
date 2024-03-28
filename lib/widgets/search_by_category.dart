import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/view_by_category.dart';
import 'package:flutter/material.dart';

class SearchByCategory extends StatefulWidget {
  const SearchByCategory({
    super.key,
    required this.name,
    required this.backImage,
  });

  final String name;
  final String backImage;

  @override
  State<SearchByCategory> createState() => _SearchByCategoryState();
}

class _SearchByCategoryState extends State<SearchByCategory> {
  @override
  Widget build(BuildContext context) {
   // final imagesProvider = Provider.of<ImagesProvider>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        //await imagesProvider.fetchImagesByColor(widget.name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewByCategory(
              value: widget.name,
            ),
          ),
        );
      },
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.only(left: 12),
        child: Stack(
          alignment: const Alignment(0, 1),
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.backImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black54,
              ),
              child: Center(
                child: Text(
                  widget.name,
                  style: styleWB16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
