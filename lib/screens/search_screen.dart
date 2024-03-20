import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:flutter/material.dart';

import '../widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final List<String> names = ['Pizza', 'Burger', 'Salad', 'Pasta', 'Sandwich'];
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color(0xFF353935),
        //backgroundColor: Colors.black.withOpacity(0.1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: const TextField(
                style: TextStyle(color: textWhite),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: searchField,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: searchFieldText),
                  hintText: 'Search by category, colors',
                  prefixIcon: Align(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Icon(
                      Icons.search_sharp,
                      color: textWhite,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Search by ',
                    style: TextStyle(
                      //color: Color(0xffFFA500),
                      color: textWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Category',
                    style: TextStyle(
                      color: textRed,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  names
                      .length, // Change the itemCount as per your requirement
                  (index) => CategoryItem(name: names[index]),
                ),
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Search by ',
                    style: TextStyle(
                      //color: Color(0xffFFA500),
                      color: textWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Color',
                    style: TextStyle(
                      color: textRed,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
