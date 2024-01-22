import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'communication.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload Demo',
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
  final dbComunicator db = new dbComunicator();

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Image.file(
              _image!,
              height: 150.0,
            )
                : Text('toljad fel elobb a kepet tesom'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
            ElevatedButton(
              onPressed: () => this.db.initRoom(_firestore),
              child: Text('initroom'),
            ),
            SizedBox(height: 20.0),
            StreamBuilder(
              stream: _firestore.collection('images').snapshots(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return CircularProgressIndicator();
                }

                var docs = snap.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var imageUrl = docs[index]['url'];
                      return Image.network(
                        imageUrl,
                        height: 100.0,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  Future<void> _uploadImage() async{
    if (_image == null){
      return;
    }
    try{
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = _storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask;
      // Get download URL
      String downloadURL = await storageReference.getDownloadURL();

      // Save image reference in Firestore
      await _firestore.collection('images').add({
        'url': downloadURL,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      print('Error uploading image: $error');
    }
  }
}


