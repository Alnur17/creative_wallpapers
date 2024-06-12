import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:creative_wallpapers/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/color_palate.dart';
import '../constant/style.dart';
import '../data/all_data.dart';
import '../provider/image_provider.dart';
import '../screens/search_screen.dart';
import 'full_image_screen.dart';
import '../widgets/shimmer_placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _carouselController = ScrollController();
  final ScrollController _gridController = ScrollController();
  bool _showGif = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showGif = false;
      });
    });
    _carouselController.addListener(_scrollListener);
    _gridController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _carouselController.dispose();
    _gridController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final provider = Provider.of<ImagesProvider>(context, listen: false);
    if (_gridController.position.pixels ==
        _gridController.position.maxScrollExtent) {
      provider.loadMoreImages();
    }
  }

  _refreshImages() async {
    final provider = Provider.of<ImagesProvider>(context, listen: false);
    await provider.fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: background,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Creative',
                    style: styleRB24,
                  ),
                  TextSpan(
                    text: 'Wallpaper',
                    style: styleWB24,
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ));
                },
                child: _showGif
                    ? Image.asset(
                        'assets/icons/Settings.gif',
                        width: 32,
                      )
                    : Image.asset(
                        'assets/icons/SettingsW.png',
                        width: 32,
                      )),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: _showGif
                  ? Image.asset(
                      'assets/icons/SearchAnimations.gif',
                      width: 32,
                    )
                  : Image.asset(
                      'assets/icons/Searching.png',
                      width: 32,
                    ),
            )
          ],
        ),
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.images.isEmpty) {
            return buildShimmerEffect();
          } else {
            return RefreshIndicator(
              backgroundColor: searchField,
              color: textRed,
              onRefresh: () async {
                await _refreshImages();
              },
              child: SingleChildScrollView(
                controller: _carouselController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    CarouselSlider(
                      items: provider.images.map(
                        (entry) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullImage(
                                    imageUrl: entry.regularUrl,
                                    altDescription: entry.altDescription,
                                    likes: entry.likes,
                                    height: entry.height,
                                    width: entry.width,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: entry.thumbUrl,
                                    placeholder: (context, url) =>
                                        buildShimmerPlaceholder(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    top: 12,
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    color: Colors.black54,
                                  ),
                                  child: Text(
                                    capitalize(entry.altDescription),
                                    style: const TextStyle(
                                      color: textWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        aspectRatio: 20 / 9,
                        enlargeCenterPage: true,
                        disableCenter: true,
                        initialPage: 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 12, right: 12, left: 12),
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                        controller: _gridController,
                        itemCount: provider.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          final image = provider.images[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullImage(
                                    imageUrl: image.regularUrl,
                                    altDescription: image.altDescription,
                                    likes: image.likes,
                                    height: image.height,
                                    width: image.width,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl: image.thumbUrl,
                                      placeholder: (context, url) =>
                                          buildShimmerPlaceholder(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
