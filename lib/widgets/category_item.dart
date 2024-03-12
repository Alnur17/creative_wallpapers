import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
      child: Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(color: textWhite, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
