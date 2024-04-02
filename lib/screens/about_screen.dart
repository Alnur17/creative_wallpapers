import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        toolbarHeight: 75,
        title: const Text('About',style: styleWB20,),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Our App',
              style: styleWB24
            ),
            SizedBox(height: 20),
            Text(
              'This is a Wallpaper application that showcases various features and functionalities.',
              style: styleWB16,),

            SizedBox(height: 20),
            Text(
              'Version: 1.0.0',
              style: styleWB16,
            ),
            SizedBox(height: 20),
            Text(
              'Developer: Sultan Md. Alnur',
              style: styleWB16,
            ),
            SizedBox(height: 20),
            Text(
              'Email: sultanmdalnur@gmail.com',
              style: styleWB16,
            ),
            SizedBox(height: 20),
            Text(
              'Website: https://github.com/Alnur17',
              style: styleWB16,
            ),
          ],
        ),
      ),
    );
  }
}
