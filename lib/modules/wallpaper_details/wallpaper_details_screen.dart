import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jo_sequal_software_pexels_app/providers/wallpapers_provider.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class WallpaperDetailsScreen extends StatelessWidget {
  const WallpaperDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/wallpaper-details';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final photoProvider = Provider.of<WallpapersProvider>(context);
    final photo = photoProvider.findPhotoById(id);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            color: HexColor(photo.avgColor!),
            width: double.infinity,
            height: deviceSize.height,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: photo.src!.original!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: 'download',
                    onPressed: () {},
                    child: const Icon(Icons.arrow_circle_down_sharp),
                  ),
                  FloatingActionButton(
                    heroTag: 'favorite',
                    onPressed: () {
                      photoProvider.toggleFavorites(id);
                    },
                    child: Icon(photo.inFavorites ? Icons.favorite : Icons.favorite_border),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
