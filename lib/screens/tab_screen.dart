import 'dart:ui';

import 'package:creative_wallpapers/screens/collection_screen.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/favorite_screen.dart';
import 'package:creative_wallpapers/screens/home_screen.dart';
import 'package:creative_wallpapers/screens/trending_screen.dart';
import 'package:flutter/cupertino.dart';
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

  final List<Widget> _screens = [
    const HomeScreen(),
    const TrendingScreen(),
    const CollectionScreen(),
    const FavoriteScreen(),
  ];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData() async {
    await Provider.of<ImagesProvider>(context, listen: false).fetchImages();
    await Provider.of<ImagesProvider>(context, listen: false)
        .fetchTrendingImages('popular');
    await Provider.of<ImagesProvider>(context, listen: false)
        .fetchCollectionImages('bird');
  }

  @override
  Widget build(BuildContext context) {
    // Widget activePage = const HomeScreen();
    // //var activePageTitle = 'Home';
    //
    // if (_selectedPageIndex == 1) {
    //   activePage = const TrendingScreen();
    //   //activePageTitle = 'Trending';
    // }   if (_selectedPageIndex == 2) {
    //   activePage = const CollectionScreen();
    //   // activePageTitle = 'Collection';
    // }   if (_selectedPageIndex == 3) {
    //   activePage = const FavoriteScreen();
    //   //activePageTitle = 'Favorite';
    // }

    return Scaffold(
      backgroundColor: background,
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffFFFAEB),
      //   title: Text(activePageTitle,style: TextStyle(color: Colors.black),),
      // ),
      body: Stack(
        children: [
          _screens[_selectedPageIndex],
          Align(
            alignment: const Alignment(0.0, 1.0),
            child: Container(
              height: 65,
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  selectedItemColor: textRed,
                  unselectedItemColor: textWhite,
                  //backgroundColor: Colors.transparent,
                  currentIndex: _selectedPageIndex,
                  // type: BottomNavigationBarType.fixed,
                  onTap: selectedPage,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled),
                      label: 'Home',
                      backgroundColor: Colors.black87,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_fire_department_sharp),
                      label: 'Trending',
                      backgroundColor: Colors.black87,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.collections_sharp),
                      label: 'Collection',
                      backgroundColor: Colors.black87,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_sharp),
                      label: 'Favorite',
                      backgroundColor: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      /* bottomNavigationBar: Container(
          height: 75,
          padding: const EdgeInsets.only(left: 12,right: 12,bottom: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 40),
              child: BottomNavigationBar(
                selectedItemColor: textRed,
                unselectedItemColor: textWhite,
                //showUnselectedLabels: true,
                //backgroundColor: Colors.red,
                // Set the background color of the BottomNavigationBar to transparent
                currentIndex: _selectedPageIndex ,
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
                    backgroundColor: Colors.black12,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.collections_sharp),
                    label: 'Collection',
                    backgroundColor: Colors.black12,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_sharp),
                    label: 'Favorite',
                    backgroundColor: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
        ),
        */

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
