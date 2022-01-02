import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/constants.dart';

class WallpapersProvider with ChangeNotifier {
  List<Wallpaper> _wallpapers = [];

  List<Wallpaper> get wallpapers {
    return [..._wallpapers];
  }

  Future<void> fetchAndSetWallpapers({bool forceFetch = false, int page = 1}) async {
    if (_wallpapers.isEmpty || forceFetch) {
      final url = Uri.parse('https://api.pexels.com/v1/curated?per_page=11&page=$page');
      try {
        final response = await http.get(url, headers: {
          'Authorization': kPexelsApiKey,
        });
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
        print(_wallpapers[0].src!.medium);
      } catch (error) {
        rethrow;
      }
    }
  }
}
