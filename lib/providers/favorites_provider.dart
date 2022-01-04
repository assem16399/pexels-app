import 'package:flutter/cupertino.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/shared/network/local/hive_helper.dart';

class FavoritesProvider with ChangeNotifier {
  Map<int, Wallpaper> _favoriteWallpapers = {};

  Map<int, Wallpaper> get wallpapers {
    return {..._favoriteWallpapers};
  }

  void fetchFavorites() {
    _favoriteWallpapers = HiveHelper.getAllBoxData('favorites');
  }

  void toggleFavoriteStatus({required int id, Wallpaper? wallpaper}) {
    if (_favoriteWallpapers.containsKey(id)) {
      _favoriteWallpapers.remove(id);
      HiveHelper.removeFromBox(id, 'favorites');
    } else {
      _favoriteWallpapers[id] = wallpaper!;
      HiveHelper.putIntoBox(id, wallpaper, 'favorites');
    }
    notifyListeners();
  }
}
