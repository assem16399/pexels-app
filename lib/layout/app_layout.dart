import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/modules/favorites/favorties_screen.dart';
import 'package:jo_sequal_software_pexels_app/modules/home/home_screen.dart';
import 'package:jo_sequal_software_pexels_app/modules/search/search_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final taps = [
    const HomeScreen(),
    const FavoritesScreen(),
  ];

  var currentScreenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pexels'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: taps[currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreenIndex,
        onTap: (index) {
          setState(() {
            currentScreenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
