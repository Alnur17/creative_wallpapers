import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/data/dummy_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FullscreenImage extends StatelessWidget {
  FullscreenImage({
    super.key,
    //required this.imageUrl
  });

  //final String imageUrl;

  //double height = 600;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    double containerHeight = screenHeight -
        appBarHeight -
        statusBarHeight -
        65 -
        32; // 70 is the height of the bottom container, 32 is the total vertical margin

    return Scaffold(
      appBar: AppBar(title: const Text('Fullscreen Image')),
      body: Builder(
        builder: (context) {
          //final double height = MediaQuery.of(context).size as double;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.black54,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textWhite),
                        ),
                      ),
                      Icon(Icons.favorite_border_rounded,
                        color: textWhite,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: containerHeight,
                  viewportFraction: 0.9,
                  enlargeCenterPage: false,
                  // autoPlay: false,
                ),
                items: imageItems
                    .map((item) =>
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: item,
                          fit: BoxFit.fill,
                          //height: containerHeight,
                        ),
                      ),
                    ))
                    .toList(),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                height: 65,
                //color: Colors.red,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black54,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.save_alt_rounded),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.now_wallpaper_rounded),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child:Icon(Icons.info_outlined),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
