import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/shared/network/remote/http_helper.dart';

class WallpapersProvider with ChangeNotifier {
  List<Wallpaper> _wallpapers = [];

  List<Wallpaper> get wallpapers {
    return [..._wallpapers];
  }

  List<Wallpaper> get favoriteWallpapers {
    return _wallpapers.where((wallpaper) => wallpaper.inFavorites).toList();
  }

  Wallpaper findPhotoById(int id) {
    return _wallpapers.firstWhere((wallpaper) => wallpaper.id == id);
  }

  void toggleFavorites(int id) {
    final photo = findPhotoById(id);
    photo.inFavorites = !photo.inFavorites;
    notifyListeners();
  }

  var pageRequestCounter = 1;
  Future<void> fetchAndSetWallpapers({bool forceFetch = false}) async {
    if (_wallpapers.isEmpty || forceFetch) {
      if (forceFetch) {
        pageRequestCounter++;
      }
      try {
        final response = await HttpHelper.getRequest('https://api.pexels'
            '.com/v1/curated?per_page=11&page=$pageRequestCounter');
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
        _wallpapers.addAll(loadedWallpapers);
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }
}
