import 'package:flutter/material.dart';

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
