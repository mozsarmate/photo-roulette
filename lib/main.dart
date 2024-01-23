import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_roulette/pages/home.dart';
import 'package:photo_roulette/pages/resultsPanel.dart';
import 'package:photo_roulette/themes/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
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
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Photo Roulette",
        //home: const RoundScreen(gamePin: "123"),
        home: HomePage(),
        theme: mainTheme
    );
  }
}