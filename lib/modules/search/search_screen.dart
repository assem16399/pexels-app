import 'package:flutter/material.dart';
import 'package:jo_sequal_software_pexels_app/providers/searched_wallpapers_provider.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/toast.dart';
import 'package:jo_sequal_software_pexels_app/shared/components/widgets/wallpapers_grid_view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final searchedWallpapers = Provider.of<SearchedWallpapersProvider>(context).searchedWallpapers;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10, bottom: 5),
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
                      if (value.isEmpty) {
                        toast('Enter Something To Search For');
                      }
                      try {
                        await Provider.of<SearchedWallpapersProvider>(context, listen: false)
                            .searchForWallpapers(value);
                        print(searchedWallpapers.length);
                        if (searchedWallpapers.isEmpty) {
                          print('here');
                          toast('No results found, Try again');
                        }
                      } catch (_) {
                        toast('Something Went Wrong!');
                      }
                    },
                  ),
                ],
              ),
            ),
            if (searchedWallpapers.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: deviceSize.height * 0.75,
                  child: WallpapersGridView(
                    wallpapers: searchedWallpapers,
                    canLoadMore: false,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
