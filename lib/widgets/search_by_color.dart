import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/view_by_category.dart';
import 'package:flutter/material.dart';

class SearchByColor extends StatelessWidget {
  const SearchByColor({super.key, required this.colorName, required this.gradient,});

  final String colorName;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    //final imagesProvider = Provider.of<ImagesProvider>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        //await imagesProvider.fetchImagesByColor(colorName);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ViewByCategory(value: colorName),
          ),
        );
      },
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            colorName,
            style: styleWB16,
          ),
        ),
      ),
    );
  }
}
