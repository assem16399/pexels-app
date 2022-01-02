import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: searchController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  label: Text('Search For what you are looking for'),
                ),
                onSubmitted: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
