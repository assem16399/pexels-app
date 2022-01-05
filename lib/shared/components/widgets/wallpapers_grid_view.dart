import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/modules/wallpaper_details/wallpaper_details_screen.dart';
import 'package:jo_sequal_software_pexels_app/providers/wallpapers_provider.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/toast.dart';
import 'package:provider/provider.dart';

import 'load_more_wallpapers.dart';
import 'wallpaper_grid_item.dart';

enum ScreenName { home, search, favorites }

class WallpapersGridView extends StatelessWidget {
  final List<Wallpaper> wallpapers;
  final bool canLoadMore;
  final ScreenName screenName;
  const WallpapersGridView(
      {Key? key,
      required this.wallpapers,
      this.canLoadMore = true,
      this.screenName = ScreenName.home})
      : super(key: key);

  void manageWallpaperDetailsNavigation(BuildContext context, Wallpaper wallpaper) {
    final wallpapersProvider = Provider.of<WallpapersProvider>(context, listen: false);
    if (screenName != ScreenName.home) {
      wallpapersProvider.addWallpaperToWallpapers(wallpaper);
    }
    Navigator.of(context)
        .pushNamed(WallpaperDetailsScreen.routeName, arguments: wallpaper.id!)
        .then((_) {
      if (screenName != ScreenName.home) {
        wallpapersProvider.removeNewlyAddedWallpaper();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
          itemCount: canLoadMore ? wallpapers.length + 1 : wallpapers.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2 / 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            if (canLoadMore && index == wallpapers.length) {
              return GestureDetector(
                onTap: () async {
                  try {
                    await Provider.of<WallpapersProvider>(context, listen: false)
                        .fetchAndSetWallpapers(forceFetch: true);
                  } on TimeoutException catch (_) {
                    toast('Timeout!! Check Your Internet Connection');
                  } catch (_) {
                    toast('Something Went Wrong!!');
                  }
                },
                child: const LoadMoreWallpapers(),
              );
            }
            return GestureDetector(
              onTap: () {
                manageWallpaperDetailsNavigation(context, wallpapers[index]);
              },
              child: WallpaperGridItem(
                id: wallpapers[index].id!,
                imageUrl: wallpapers[index].src!.medium!,
                avgColor: wallpapers[index].avgColor!,
              ),
            );
          }),
    );
  }
}
