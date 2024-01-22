import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_roulette/pages/round.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RoundScreen(gamePin: 'asd')
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _imagePicker = ImagePicker();
//
//   File? _image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _image != null
//                 ? Image.file(
//               _image!,
//               height: 150.0,
//             )
//                 : Text('toljad fel elobb a kepet tesom'),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             ElevatedButton(
//               onPressed: _uploadImage,
//               child: Text('Upload Image'),
//             ),
//             SizedBox(height: 20.0),
//             StreamBuilder(
//               stream: _firestore.collection('images').snapshots(),
//               builder: (context, snap) {
//                 if (!snap.hasData) {
//                   return CircularProgressIndicator();
//                 }
//
//                 var docs = snap.data!.docs;
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: docs.length,
//                     itemBuilder: (context, index) {
//                       var imageUrl = docs[index]['url'];
//                       return Image.network(
//                         imageUrl,
//                         height: 100.0,
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _pickImage() async {
//     final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected');
//       }
//     });
//   }
//
//   Future<void> _uploadImage() async{
//     if (_image == null){
//       return;
//     }
//     try{
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString() + _image.;
//       Reference storageReference = _storage.ref().child('images/$fileName');
//       UploadTask uploadTask = storageReference.putFile(_image!);
//       await uploadTask;
//       // Get download URL
//       String downloadURL = await storageReference.getDownloadURL();
//
//       // Save image reference in Firestore
//       await _firestore.collection('images').add({
//         'url': downloadURL,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } catch (error) {
//       print('Error uploading image: $error');
//     }
//   }
// }
//
//
