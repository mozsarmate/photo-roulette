import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  final numOfImagesWanted = 10;

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
          /* ElevatedButton(
            onPressed: _uploadImage,
            child: Text('Upload Image'),
          ),*/
          SizedBox(height: 20.0),
          ListView.builder(
            itemCount: images.length,
            itemBuilder: (_, index) {
              return AssetThumbnail(
                image: images[index],
              );
            },
          )
        ]),
      ),
    );
  }

  Future<void> _pickRandomImage() async {
    PhotoManager.requestPermissionExtend().then((PermissionState state) async {
      if (state.isAuth) {
        images = await PhotoManager.getAssetListRange(start: 0, end: 500);
        setState(() {});
      }
    });
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
