import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/models/wallpaper.dart';
import 'package:jo_sequal_software_pexels_app/providers/wallpapers_provider.dart';
import 'package:provider/provider.dart';

import 'wallpaper_grid_item.dart';

class WallpapersGridView extends StatelessWidget {
  final List<Wallpaper> wallpapers;
  final bool canLoadMore;
  const WallpapersGridView({Key? key, required this.wallpapers, this.canLoadMore = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: canLoadMore ? wallpapers.length + 1 : wallpapers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (context, index) {
          if (canLoadMore && index == wallpapers.length) {
            return GestureDetector(
              onTap: () {
                Provider.of<WallpapersProvider>(context, listen: false)
                    .fetchAndSetWallpapers(forceFetch: true);
              },
              child: const LoadMoreWallpapers(),
            );
          }
          return WallpaperGridItem(
            id: wallpapers[index].id!,
            imageUrl: wallpapers[index].src!.medium!,
            avgColor: wallpapers[index].avgColor!,
          );
        });
  }
}

class LoadMoreWallpapers extends StatelessWidget {
  const LoadMoreWallpapers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: Colors.black54,
          ),
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
