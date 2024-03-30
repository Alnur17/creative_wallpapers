import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  String title;
  String subTitle;
  String image;

  ProfileItem(
      {required this.title,
      required this.subTitle,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only( right: 16, left: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 37, 37, 37),
      ),

      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: styleWB20,
                  ),
                  Text(
                    subTitle,
                    style: styleWB16,
                  ),
                ],
              ),
            ),
          ),
          Image.asset(image,color: textRed,),
        ],
      ),
    );
  }
}
