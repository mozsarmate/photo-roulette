import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_manager/photo_manager.dart';

import '../components/assetThumbnail.dart';
import '../components/button.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {

  List<AssetEntity> images = [];
  final maxAgeOfImage = 500;
  final numOfImagesWanted = 16;
  var numOfImagesGot = 2;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //backgroundColor: Color(0xFF1A36B9),
        body: Column(
          children: <Widget> [
            SizedBox(height: 50),
            Text("Image\nSelection",
              style: TextStyle(fontSize: 50, fontFamily: "Kanit"),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 5.0,
                                ),
                                itemCount: images.length,
                                itemBuilder: (_, index) {
                                  return AssetThumbnail(image: images[index]);
                                },
                              )),
                        ),
                      ]),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Button(action: _pickRandomImage, text: "Reroll images", isPrimary: false),
                Button(text: "Approve", isPrimary: true)
              ],
            ),
            SizedBox(height: 70)
          ],
        )
      );
  }

  Future<void> _pickRandomImage() async {
    var status = await PhotoManager.requestPermissionExtend();

    if (status.hasAccess) {
      // Permission is granted, proceed to access images
      images = await PhotoManager.getAssetListRange(start: 0, end: maxAgeOfImage);
      images.shuffle();
      numOfImagesGot = min(images.length, numOfImagesWanted);
      images = images.take(numOfImagesWanted).toList();
      setState(() {});
    } else {
      // todo add error handling
      print("Permission not granted");
    }
  }
}
