import 'dart:ui';

import 'package:creative_wallpapers/screens/collection_screen.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/favorite_screen.dart';
import 'package:creative_wallpapers/screens/home_screen.dart';
import 'package:creative_wallpapers/screens/trending_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/image_provider.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     Provider.of<ImagesProvider>(context, listen: false).fetchImages();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();
    //var activePageTitle = 'Home';

    if (_selectedPageIndex == 1) {
      activePage = const TrendingScreen();
      //activePageTitle = 'Trending';
    } else if (_selectedPageIndex == 2) {
      activePage = const CollectionScreen();
      // activePageTitle = 'Collection';
    } else if (_selectedPageIndex == 3) {
      activePage = const FavoriteScreen();
      //activePageTitle = 'Favorite';
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffFFFAEB),
      //   title: Text(activePageTitle,style: TextStyle(color: Colors.black),),
      // ),
      body: activePage,
      bottomNavigationBar: Container(
        height: 65,
        margin: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 40),
            child: BottomNavigationBar(
              selectedItemColor: textRed,
              unselectedItemColor: textWhite,
              //showUnselectedLabels: true,
              backgroundColor: Colors.transparent,
              // Set the background color of the BottomNavigationBar to transparent
              currentIndex: _selectedPageIndex,
              onTap: selectedPage,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                  backgroundColor: Colors.black12,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_fire_department_sharp),
                  label: 'Trending',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.collections_sharp),
                  label: 'Collection',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_sharp),
                  label: 'Favorite',
                ),
              ],
            ),
          ),
        ),
      ),

      /*bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(left: 8,bottom: 16,right: 8),
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.circular(30),
          child: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.onBackground,
            unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
            showUnselectedLabels: true,
            currentIndex: _selectedPageIndex,
            onTap: selectedPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
                backgroundColor: Colors.black12,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department_sharp),
                label: 'Trending',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.collections_sharp),
                label: 'Collection',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_sharp),
                label: 'Favorite',
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}
