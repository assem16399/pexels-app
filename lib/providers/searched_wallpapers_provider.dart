import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/shared/network/remote/http_helper.dart';

class SearchedWallpapersProvider with ChangeNotifier {
  List<Wallpaper> _searchedWallpapers = [];

  List<Wallpaper> get searchedWallpapers {
    return [..._searchedWallpapers];
  }

  void clearSearchResults() {
    _searchedWallpapers.clear();
    notifyListeners();
  }

  Future<void> searchForWallpapers(String query) async {
    clearSearchResults();
    try {
      final response =
          await HttpHelper.getRequest('https://api.pexels.com/v1/search?query=$query&per_page=20');
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) return;
      final List<Wallpaper> loadedWallpapers = [];
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
      _searchedWallpapers.addAll(loadedWallpapers);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
