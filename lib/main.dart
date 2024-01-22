import 'package:flutter/material.dart';
import 'package:photo_roulette/pages/home.dart';
import 'package:photo_roulette/themes/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
        home: const HomePage(),
        theme: mainTheme);
  }
}
