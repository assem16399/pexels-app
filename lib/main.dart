import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/layout/app_layout.dart';
import 'package:jo_sequal_software_pexels_app/modules/search/search_screen.dart';
import 'package:jo_sequal_software_pexels_app/modules/wallpaper_details/wallpaper_details_screen.dart';
import 'package:jo_sequal_software_pexels_app/providers/favorites_provider.dart';
import 'package:jo_sequal_software_pexels_app/providers/wallpapers_provider.dart';
import 'package:jo_sequal_software_pexels_app/shared/styles/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WallpapersProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        home: const AppLayout(),
        routes: {
          SearchScreen.routeName: (context) => SearchScreen(),
          WallpaperDetailsScreen.routeName: (context) => const WallpaperDetailsScreen(),
        },
      ),
    );
  }
}
