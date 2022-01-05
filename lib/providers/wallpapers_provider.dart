import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/shared/network/remote/http_helper.dart';

class WallpapersProvider with ChangeNotifier {
  final List<Wallpaper> _homeWallpapers = [];

  List<Wallpaper> get wallpapers {
    return [..._homeWallpapers];
  }

  Wallpaper findWallpaperById(int id) {
    return _homeWallpapers.firstWhere((wallpaper) => wallpaper.id == id);
  }

  void addWallpaperToWallpapers(Wallpaper addedWallpaper) {
    if (!_homeWallpapers.contains(addedWallpaper)) {
      _homeWallpapers.add(addedWallpaper);
      _isNewlyAdded = true;
      notifyListeners();
    }
  }

  var _isNewlyAdded = false;
  void removeNewlyAddedWallpaper([int id = 0]) {
    if (_isNewlyAdded) {
      _homeWallpapers.removeLast();
      _isNewlyAdded = false;
      notifyListeners();
    }
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
        notifyListeners();
      } on TimeoutException catch (_) {
        rethrow;
      } catch (_) {
        rethrow;
      }
    }
  }
}
