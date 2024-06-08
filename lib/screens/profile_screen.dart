import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/profile_item.dart';
import 'package:flutter/material.dart';

import '../constant/style.dart';
import '../data/all_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 75,
        elevation: 0,
        title: const Text(
          'Settings',
          style: styleWB20,
        ),
      ),
      body: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Add padding for the first item
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ProfileItem(
                title: items[index].title,
                subTitle: items[index].subtitle,
                image: items[index].image,
              ),
            );
          } else if (index < items.length) {
            // Render other items normally
            return Padding(
              padding:
                  const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: ProfileItem(
                title: items[index].title,
                subTitle: items[index].subtitle,
                image: items[index].image,
              ),
            );
          } else {
            return const SizedBox(height: 16.0);
          }
        },
      ),
    );
  }
}
