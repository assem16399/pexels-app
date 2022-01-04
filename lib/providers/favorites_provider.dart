import 'package:flutter/cupertino.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';

class FavoritesProvider with ChangeNotifier {
  final Map<int, Wallpaper> _favoriteWallpapers = {};

  Map<int, Wallpaper> get wallpapers {
    return {..._favoriteWallpapers};
  }

  void toggleFavoriteStatus({required int id, Wallpaper? wallpaper}) {
    if (_favoriteWallpapers.containsKey(id)) {
      _favoriteWallpapers.remove(id);
    } else {
      _favoriteWallpapers[id] = wallpaper!;
    }
    notifyListeners();
    print(_favoriteWallpapers.length);
  }
}
