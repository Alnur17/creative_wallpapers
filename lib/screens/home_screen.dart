import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:creative_wallpapers/screens/category_screen.dart';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:creative_wallpapers/widgets/full_image.dart';
import 'package:creative_wallpapers/provider/image_provider.dart';
import 'package:creative_wallpapers/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int currentPageIndex = 0;

  final ScrollController _carouselController = ScrollController();
  final ScrollController _gridController = ScrollController();

  @override
  void initState() {
    super.initState();
    _carouselController.addListener(_scrollListener);
    _gridController.addListener(_scrollListener);
    Provider.of<ImagesProvider>(context, listen: false).fetchImages();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ));
                  },
                  child: const Icon(
                    Icons.account_circle_outlined,
                    color: textWhite,
                    size: 30,
                  )),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Creative',
                      style: TextStyle(
                        //color: Color(0xffFFA500),
                        color: textRed,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Wallpaper',
                      style: TextStyle(
                        color: textWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(),
                      ));
                },
                child: const Icon(
                  Icons.search,
                  color: textRed,
                  size: 30,
                ),
              )
            ],
          ),
        ),
        body: Consumer<ImagesProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading && provider.images.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.hasError && provider.images.isEmpty) {
              return Center(child: Text('Error: ${provider.errorMessage}'));
            } else {
              return SingleChildScrollView(
                controller: _carouselController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsScreen(),
                                    ));
                              },
                              child: const Icon(
                                Icons.account_circle_outlined,
                                color: textWhite,
                                size: 30,
                              )),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Creative',
                                  style: TextStyle(
                                    //color: Color(0xffFFA500),
                                    color: textRed,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Wallpaper',
                                  style: TextStyle(
                                    color: textWhite,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryScreen(),
                                  ));
                            },
                            child: const Icon(
                              Icons.search,
                              color: textRed,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),*/
                    const SizedBox(height: 12),
                    CarouselSlider(
                      items: provider.images.asMap().entries.map((entry) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullImage(
                                        imageUrl: entry.value.regularUrl,

                                        //index: entry.key,
                                      ),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl: entry.value.thumbUrl,
                                  // placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                  // errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  height: 190,
                                  width: 1000,
                                ),
                              ),
                            ),
                            // Text(
                            //   entry.value.altDescription,
                            //   style: TextStyle(
                            //     color: Color(0xFFFFFFDC),
                            //     fontSize: 24,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        aspectRatio: 20 / 9,
                        enlargeCenterPage: true,
                        disableCenter: true,
                        initialPage: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 12, // Spacing between columns
                          mainAxisSpacing: 12,
                          childAspectRatio: 2.9 / 4, // Spacing between rows
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
                                    //index: index,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CachedNetworkImage(
                                      imageUrl: image.thumbUrl,
                                      // placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      // errorWidget: (context, url, error) => const Icon(Icons.error),
                                      // Adjust the image to fit the grid cell
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  right: 12,
                                  child: GestureDetector(
                                    onTap: () {
                                      provider.toggleFavorite(index);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: Icon(
                                        image.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: image.isFavorite
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (provider.isLoading && provider.hasMoreData)
                      const Center(child: CircularProgressIndicator()),
                    if (provider.hasError && provider.hasMoreData)
                      Center(child: Text('Error: ${provider.errorMessage}')),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

/*SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            CarouselSlider(
              items: imageItems
                  .asMap()
                  .entries
                  .map(
                    (item) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullImage(imageUrl: imageItems, index: item.key),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              item.value,
                              fit: BoxFit.cover,
                              height: 190,
                              width: 1000,
                            ),
                          ),
                          Text(
                            imageTexts[item.key],
                            style: TextStyle(
                              color: Color(0xFFFFFFDC),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                aspectRatio: 20 / 9,
                enlargeCenterPage: true,
                disableCenter: true,
                initialPage: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, bottom: 12, top: 12),
              child: GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 12, // Spacing between columns
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5 / 4, // Spacing between rows
                ),
                itemCount: imageItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullImage(
                            imageUrl: imageItems,
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              imageItems[index],
                              // Adjust the image to fit the grid cell
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
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

*/
