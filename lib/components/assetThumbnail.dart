import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
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
          return Image.memory(bytes, fit: BoxFit.cover);
        });
  }
}