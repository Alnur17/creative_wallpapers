

import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/about_screen.dart';
import 'package:flutter/material.dart';

import '../constant/style.dart';
import '../screens/security_and_privacy_screen.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;

  const ProfileItem(
      {required this.title,
      required this.subTitle,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'About') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutScreen()),
          );
        } else if (title == 'Security') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecurityPrivacyScreen()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 37, 37, 37),
        ),

        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: styleWB20,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subTitle,
                    style: styleWB16,
                  ),
                ],
              ),
            ),
            Image.asset(image,color: textRed,),
          ],
        ),
      ),
    );
  }
}
