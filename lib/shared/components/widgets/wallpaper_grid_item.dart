import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
    return Material(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        decoration:
            BoxDecoration(color: HexColor(avgColor), borderRadius: BorderRadius.circular(5)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageUrl,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
