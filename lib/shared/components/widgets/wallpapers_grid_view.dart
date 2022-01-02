import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/providers/wallpapers_provider.dart';
import 'package:provider/provider.dart';

import 'wallpaper_grid_item.dart';

class WallpapersGridView extends StatefulWidget {
  const WallpapersGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<WallpapersGridView> createState() => _WallpapersGridViewState();
}

class _WallpapersGridViewState extends State<WallpapersGridView> {
  @override
  void initState() {
    // TODO: implement initState
    _wallpapersFuture = _obtainWallpapersFuture();
    super.initState();
  }

  Future? _wallpapersFuture;
  Future _obtainWallpapersFuture() {
    return Provider.of<WallpapersProvider>(context, listen: false).fetchAndSetWallpapers();
  }

  var requestCounter = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _wallpapersFuture,
      builder: (context, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (dataSnapShot.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        } else {
          return Consumer<WallpapersProvider>(
            builder: (context, wallpapersProvider, _) => GridView.builder(
                itemCount: wallpapersProvider.wallpapers.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  if (index == wallpapersProvider.wallpapers.length) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<WallpapersProvider>(context, listen: false)
                            .fetchAndSetWallpapers(forceFetch: true, page: ++requestCounter);
                      },
                      child: const LoadMoreWallpapers(),
                    );
                  }
                  return WallpaperGridItem(
                    imageUrl: wallpapersProvider.wallpapers[index].src!.medium!,
                  );
                }),
          );
        }
      },
    );
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
