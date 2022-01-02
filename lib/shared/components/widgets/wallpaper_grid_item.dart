import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/modules/wallpaper_details/wallpaper_details_screen.dart';

class WallpaperGridItem extends StatelessWidget {
  const WallpaperGridItem({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(WallpaperDetailsScreen.routeName);
      },
      child: SizedBox(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
