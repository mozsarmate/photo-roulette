import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate();

  runApp(
    Provider.value(
      value: FirebaseFirestore.instance,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Images Upload Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final maxAgeOfImage = 500;
  final numOfImagesWanted = 16;
  var numOfImagesGot = 2;

  List<AssetEntity> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Demo'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: _pickRandomImage,
            child: Text('Pick Random Images'),
          ),
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
          )
        ]),
      ),
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
        print('Permission Denied');
        // Permission is denied by the user
        // Handle the case where the user denies permission
        // You may want to display a message or guide the user to enable the permission manually
      }
    }
  }


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
