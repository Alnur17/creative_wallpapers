
import 'package:creative_wallpapers/provider/image_provider.dart';
import 'package:creative_wallpapers/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final theme = ThemeData(
  useMaterial3: false,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 255, 0, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create:(_) =>   ImagesProvider(),),
      ],
      child: MaterialApp(
        title: 'Creative Wallpaper',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home:  const TabsScreen(),
      ),
    );
  }
}
