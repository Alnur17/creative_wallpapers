import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/profile_item.dart';
import 'package:flutter/material.dart';

import '../data/all_data.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title:  const Text('Profile',style: styleRB24),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/Rectangle1.png',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sultan Md. Alnur',
            style: styleWB16
          ),
          const Text(
            'user@website.com',
            style: TextStyle(
              color: textWhite,
            ),
          ),
          // const SizedBox(
          //   height: 24,

          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              //padding: EdgeInsets.all(16),
              height: 50, //alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromARGB(255, 37, 37, 37),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.g_mobiledata_rounded,
                    size: 50,
                    color: textRed,
                  ),
                  Text(
                    'Sign in with google',
                    style: styleWB16,
                  )
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: items.length + 1,
          //     itemBuilder: (context, index) {
          //       if (index < items.length) {
          //         return ProfileItem(
          //             title: items[index].title,
          //             subTitle: items[index].subtitle,
          //             image: items[index].image);
          //       } else {
          //         return const SizedBox(height: 16,);
          //       }
          //     },
          //   ),
          // )
          Expanded(
            child: ListView.builder(
             // primary: false,
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Add padding for the first item
                  return Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: ProfileItem(
                      title: items[index].title,
                      subTitle: items[index].subtitle,
                      image: items[index].image,
                    ),
                  );
                } else if (index < items.length) {
                  // Render other items normally
                  return Padding(
                    padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                    child: ProfileItem(
                      title: items[index - 1].title, // Adjust index for items list
                      subTitle: items[index - 1].subtitle, // Adjust index for items list
                      image: items[index - 1].image, // Adjust index for items list
                    ),
                  );
                } else {
                  // Add padding for the last item
                  return const SizedBox(height: 16.0);
                }
              },
            ),
          )

        ],
      ),
    );
  }
}
