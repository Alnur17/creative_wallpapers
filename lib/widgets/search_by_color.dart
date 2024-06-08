import 'package:creative_wallpapers/screens/view_by_grid.dart';
import 'package:flutter/material.dart';

import '../constant/style.dart';

class SearchByColor extends StatelessWidget {
  const SearchByColor({super.key, required this.colorName, required this.gradient,});

  final String colorName;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ViewByGrid(value: colorName),
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
