import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/toast.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/widgets/wallpapers_grid_view.dart';
import 'package:jo_sequal_software_pexels_app/shared/network/remote/http_helper.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  final List<Wallpaper> _searchedWallpapers = [];

  Future<void> searchForWallpapers(String query) async {
    setState(() {
      _searchedWallpapers.clear();
    });
    try {
      final response =
          await HttpHelper.getRequest('https://api.pexels.com/v1/search?query=$query&per_page=20');
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) return;

      extractedData['photos'].forEach((wallpaper) {
        setState(() {
          _searchedWallpapers.add(
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
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10, bottom: 5),
              child: Column(
                children: [
                  TextField(
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      label: Text('Search For what you are looking for'),
                    ),
                    onSubmitted: (value) async {
                      if (value.isEmpty) {
                        toast('Enter Something To Search For');
                        return;
                      }
                      try {
                        await searchForWallpapers(value);

                        if (_searchedWallpapers.isEmpty) {
                          toast('No results found, Try again');
                        }
                      } catch (_) {
                        toast('Something Went Wrong!');
                      }
                    },
                  ),
                ],
              ),
            ),
            if (_searchedWallpapers.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: deviceSize.height * 0.75,
                  child: WallpapersGridView(
                    wallpapers: _searchedWallpapers,
                    screenName: ScreenName.search,
                    canLoadMore: false,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
