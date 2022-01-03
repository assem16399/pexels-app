import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/providers/searched_wallpapers_provider.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/widgets/wallpapers_grid_view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20, bottom: 5),
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
                      try {
                        await Provider.of<SearchedWallpapersProvider>(context, listen: false)
                            .searchForWallpapers(value);
                      } catch (error) {
                        print(error);
                      }
                    },
                  ),
                ],
              ),
            ),
            if (Provider.of<SearchedWallpapersProvider>(context).searchedWallpapers.isNotEmpty)
              Consumer<SearchedWallpapersProvider>(
                  builder: (context, searchedWallpapersProvider, _) {
                return SizedBox(
                  width: double.infinity,
                  height: deviceSize.height * 0.75,
                  child: WallpapersGridView(
                    wallpapers: searchedWallpapersProvider.searchedWallpapers,
                    canLoadMore: false,
                  ),
                );
              })
          ],
        ),
      ),
    );
  }
}
