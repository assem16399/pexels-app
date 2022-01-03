import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/providers/wallpapers_provider.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/widgets/wallpapers_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                builder: (context, wallpapersProvider, _) => WallpapersGridView(
                      wallpapers: wallpapersProvider.wallpapers,
                    ));
          }
        });
  }
}
