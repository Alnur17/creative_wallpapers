import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/view_by_category.dart';
import 'package:creative_wallpapers/widgets/search_by_color.dart';
import 'package:flutter/material.dart';

import '../data/all_data.dart';
import '../widgets/search_by_category.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(color: textWhite),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: searchField,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: searchFieldText,
                    ),
                    hintText: 'Search here',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 18),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewByCategory(value: searchController.text)),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 25.0),
                        // Adjust icon padding as needed
                        child: Icon(
                          Icons.search_sharp,
                          color: textWhite,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: RichText(
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
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  categoryName.length + 1,
                  (index) {
                    if (index < categoryName.length) {
                      return SearchByCategory(
                        name: categoryName[index],
                        backImage: categoryImage[index],
                      );
                    } else {
                      return const SizedBox(width: 16);
                    }
                  },
                ),
              ),

              // Alternatives are given below

              // Padding(
              // padding: const EdgeInsets.only(right: 12),
              // child: Row(
              //   children: List.generate(
              //       categoryName.length,
              //       (index) => SearchByCategory(
              //             name: categoryName[index],
              //             backImage: categoryImage[index],
              //           )),
              // ),),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: RichText(
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
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  children: List.generate(
                    colorName.length + 1,
                    (index) {
                      if (index < colorName.length) {
                        return SearchByColor(
                          colorName: colorName[index],
                          gradient: colorGradients[index],
                        );
                      } else {
                        return const SizedBox(width: 16);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
