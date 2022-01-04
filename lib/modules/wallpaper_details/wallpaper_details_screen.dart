import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:jo_sequal_software_pexels_app/providers/favorites_provider.dart';
import 'package:jo_sequal_software_pexels_app/providers/wallpapers_provider.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/toast.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class WallpaperDetailsScreen extends StatelessWidget {
  const WallpaperDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/wallpaper-details';

  void downloadImage(String imageUrl) async {
    try {
      // Saved with this method.
      toast('Downloading...');
      var imageId = await ImageDownloader.downloadImage(imageUrl);
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      // var path = await ImageDownloader.findPath(imageId);
      // var size = await ImageDownloader.findByteSize(imageId);
      // var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
      toast('Something Went Wrong! Try Again');
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final wallpaper = Provider.of<WallpapersProvider>(context, listen: false).findWallpaperById(id);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            color: HexColor(wallpaper.avgColor!),
            width: double.infinity,
            height: deviceSize.height,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: wallpaper.src!.original!,
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
                    onPressed: () => downloadImage(wallpaper.src!.original!),
                    child: const Icon(Icons.arrow_circle_down_sharp),
                  ),
                  Consumer<FavoritesProvider>(
                    builder: (context, favoritesProvider, _) => FloatingActionButton(
                      heroTag: 'favorite',
                      onPressed: () =>
                          favoritesProvider.toggleFavoriteStatus(id: id, wallpaper: wallpaper),
                      child: Icon(favoritesProvider.wallpapers.containsKey(id)
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
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
