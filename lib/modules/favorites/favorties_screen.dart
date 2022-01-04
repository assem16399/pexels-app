import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/providers/favorites_provider.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/widgets/wallpapers_grid_view.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteWallpapers = Provider.of<FavoritesProvider>(context).wallpapers;
    return favoriteWallpapers.isEmpty
        ? const Center(
            child: Text('Start Adding Some Favorites'),
          )
        : WallpapersGridView(
            wallpapers: favoriteWallpapers.values.toList(),
            screenName: ScreenName.favorites,
            canLoadMore: false,
          );
  }
}
