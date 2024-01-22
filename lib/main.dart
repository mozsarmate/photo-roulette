import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
          ElevatedButton(
            onPressed: _requestPermission,
            child: Text('Request Permission'),
          ),
          ElevatedButton(
            onPressed: _requestCameraPermission,
            child: Text('Request Camera Permission'),
          ),
          /* ElevatedButton(
            onPressed: _uploadImage,
            child: Text('Upload Image'),
          ),*/
          SizedBox(height: 20.0),
          Expanded(
            child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  itemCount: images.length,
                  itemBuilder: (_, index) {
                    return Text(images[index].id);
                  },
                )),
          )
        ]),
      ),
    );
  }

  Future<void> _requestPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend(); // the method can use optional param `permission`.
    if (ps.isAuth) {
      print('Permission Granted');
    } else if (ps.hasAccess) {
      print('Permission Granted Limited');
    } else {
      print('Permission Denied');
    }
  }

  Future<void> _pickRandomImage() async {
    var status = await Permission.storage.status;

    if (status.isGranted) {
      // Permission is granted, proceed to access images
      images = await PhotoManager.getAssetListRange(start: 0, end: 500);
      setState(() {});
    } else {
      // Permission is not granted, request permission
      if (await Permission.photos.request().isGranted) {
        // Permission is granted, proceed to access images
        images = await PhotoManager.getAssetListRange(start: 0, end: 500);
        setState(() {});
      } else {
        print('Permission Denied');
        // Permission is denied by the user
        // Handle the case where the user denies permission
        // You may want to display a message or guide the user to enable the permission manually
      }
    }
  }

  void _requestCameraPermission() {
    Permission.camera.request().then((value) {
      if (value.isGranted) {
        print('Permission Granted');
      } else if (value.isDenied) {
        print('Permission Denied');
      } else if (value.isPermanentlyDenied) {
        print('Permission Permanently Denied');
      } else if (value.isRestricted) {
        print('Permission Restricted');
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
