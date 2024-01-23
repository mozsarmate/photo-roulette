import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    super.key,
    required this.image,
  });

  final AssetEntity image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: image.thumbnailData.then((value) => value!),
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) return const CircularProgressIndicator();
        return GestureDetector(
          onTap: () async {
            print("Image tapped");
            await showDialog(
                context: context, builder: (_) => ImageDialog(image: image));
          },
          child: Container(
            child: Image.memory(bytes, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}

class ImageDialog extends StatelessWidget {
  final AssetEntity image;

// require image
  ImageDialog({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          child: FutureBuilder<Uint8List>(
              future: image.thumbnailData.then((value) => value!),
              builder: (_, snapshot) {
                final bytes = snapshot.data;
                if (bytes == null) return const CircularProgressIndicator();
                return Image.memory(bytes, fit: BoxFit.cover);
              }
          )
      ),
    );
  }
}
