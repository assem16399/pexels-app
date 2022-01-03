import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jo_sequal_software_pexels_app/modules/wallpaper_details/wallpaper_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class WallpaperGridItem extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String avgColor;
  const WallpaperGridItem(
      {Key? key, required this.id, required this.imageUrl, required this.avgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(WallpaperDetailsScreen.routeName, arguments: id);
      },
      child: Container(
        color: HexColor(avgColor),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
