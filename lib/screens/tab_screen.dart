import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/screens/collections.dart';
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

  final List<Widget> _screens = [
    const HomeScreen(),
    const TrendingScreen(),
    const Collections(),
    //const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData() async {
    await Provider.of<ImagesProvider>(context, listen: false).fetchImages();
    await Provider.of<ImagesProvider>(context, listen: false).fetchTrendingImages('trending');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          _screens[_selectedPageIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  selectedItemColor: textRed,
                  unselectedItemColor: textWhite,
                  backgroundColor: Colors.black87,
                  showUnselectedLabels: false,
                  currentIndex: _selectedPageIndex,
                  // type: BottomNavigationBarType.shifting,
                  onTap: selectedPage,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled,size: 28,),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_fire_department_sharp,size: 30,),
                      label: 'Trending',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.collections_rounded,size: 26,),
                      label: 'Collection',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
