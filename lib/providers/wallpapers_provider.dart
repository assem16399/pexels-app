import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/shared/network/remote/http_helper.dart';

class WallpapersProvider with ChangeNotifier {
  final List<Wallpaper> _allWallpapers = [];

  final List<Wallpaper> _homeWallpapers = [];

  List<Wallpaper> get wallpapers {
    return [..._homeWallpapers];
  }

  List<Wallpaper> get favoriteWallpapers {
    return _allWallpapers.where((wallpaper) => wallpaper.inFavorites).toList();
  }

  Wallpaper findWallpaperById(int id) {
    return _allWallpapers.firstWhere((wallpaper) => wallpaper.id == id);
  }

  void toggleFavorites(int id) {
    final photo = findWallpaperById(id);
    photo.inFavorites = !photo.inFavorites;
    notifyListeners();
  }

  void addSearchedWallpaperToAllWallpaper(Wallpaper addedWallpaper) {
    if (!_allWallpapers.contains(addedWallpaper)) {
      _allWallpapers.add(addedWallpaper);
      notifyListeners();
    }
  }

  void cleanUnFavoritesWallpaperFromAllWallpaper() {
    _allWallpapers.removeWhere((wallpaper) => !wallpaper.inFavorites);
    notifyListeners();
  }

  var _pageRequestCounter = 1;
  var _requestedWallpapers = 11;
  Future<void> fetchAndSetWallpapers({bool forceFetch = false}) async {
    if (_homeWallpapers.isEmpty || forceFetch) {
      if (forceFetch) {
        _pageRequestCounter++;
        _requestedWallpapers = 12;
      }
      try {
        final response = await HttpHelper.getRequest('https://api.pexels'
            '.com/v1/curated?per_page=$_requestedWallpapers&page=$_pageRequestCounter');
        final extractedData = jsonDecode(response.body) as Map<String, dynamic>?;
        if (extractedData == null) return;
        List<Wallpaper> loadedWallpapers = [];
        extractedData['photos'].forEach((wallpaper) {
          loadedWallpapers.add(
            Wallpaper(
              id: wallpaper['id'],
              width: wallpaper['width'],
              height: wallpaper['height'],
              imageUrl: wallpaper['image_url'],
              alt: wallpaper['alt'],
              photographer: wallpaper['photographer'],
              photographerId: wallpaper['photographer_id'],
              avgColor: wallpaper['avg_color'],
              photographerUrl: wallpaper['photographer_url'],
              src: WallpaperSource(
                original: wallpaper['src']['original'],
                large2x: wallpaper['src']['large2x'],
                large: wallpaper['src']['large'],
                medium: wallpaper['src']['medium'],
                portrait: wallpaper['src']['portrait'],
                small: wallpaper['src']['small'],
                tiny: wallpaper['src']['tiny'],
              ),
            ),
          );
        });
        _homeWallpapers.addAll(loadedWallpapers);
        _allWallpapers.addAll(loadedWallpapers);
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }
}
