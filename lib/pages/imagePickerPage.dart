import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../components/assetThumbnail.dart';

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
        backgroundColor: Color(0xFF1A36B9),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Expanded(
                child: SizedBox(
                    height: 200.0,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                      ),
                      itemCount: images.length,
                      itemBuilder: (_, index) {
                        return AssetThumbnail(image: images[index]);
                      },
                    )),
              ),
              ElevatedButton(onPressed: _pickRandomImage, child: Text("Pick random images"))
            ]));
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
      Text("Permission not granted");
      print("Permission not granted");
    }
  }
}