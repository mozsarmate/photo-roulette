import 'dart:io';
import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_roulette/player.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final DbCommunicator db = new DbCommunicator();
  Player buj = new Player("Bujdi", guess: "Miki", points: 3);


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

            ElevatedButton(onPressed: () => this.db.addPlayer(_firestore, "2066", buj), child: Text("Add Bujdi")),
            ElevatedButton(onPressed: () => db.incrementRound(_firestore, "2066"), child: Text("Next Round")),
            //ElevatedButton(onPressed: _downloadImage, child: Text('Download DA IMAGE'))
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
      //room 2066
      String fileName = "test";
      Reference storageReference = _storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask;
      // Get download URL
      String downloadURL = await storageReference.getDownloadURL();

      // Save image reference in Firestore
      await _firestore.collection('2066').doc('static').collection('images').add({
        "url": downloadURL,
        "commiter": "Bujdi",
        "img-id": 12
        // This adds the download URL to the images array without overwriting existing data
      });
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> _downloadImage() async{
    String img = "";
    _firestore.collection("2066").doc("static").collection("images").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot[1] == "Bujdi") {
            img = docSnapshot[0]["source"];
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

}


