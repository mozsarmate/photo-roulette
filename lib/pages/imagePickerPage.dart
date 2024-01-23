import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/assetThumbnail.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png",
      "assets/images/avatar_example.png"
    ];
    List<Image> images = [];

    for (int i = 0; i < imagePaths.length; i++) {
      // images.add(Image(
      //     image: AssetThumbnail()),
      //     width: 30,
      //     height: 30
      // ));
    }

    return Scaffold(
        backgroundColor: Color(0xFF1A36B9),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.amber,
                  // child: GridView.builder(
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 4,
                  //     mainAxisSpacing: 2.0,
                  //     crossAxisSpacing: 2.0,
                  //   ),
                  //   itemCount: images.length,
                  //   itemBuilder: (_, index) {
                  //     return AssetThumbnail(image: images[index]);
                  //   },
                  //)
                ),
              ),
            ]));
  }
}
