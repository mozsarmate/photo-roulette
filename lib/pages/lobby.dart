import 'package:flutter/material.dart';

class LobbyScreen extends StatefulWidget{
  //const LobbyScreen({required this.gamePin, super.key});
  final gamePin;
  const LobbyScreen({super.key, required String this.gamePin});

  @override
  State<LobbyScreen> createState() => _LobbyState(gamePin);
}

class _LobbyState extends State<LobbyScreen>{
  late List<String> players;
  final gamePin;

  _LobbyState(this.gamePin);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close),
              tooltip: "Quit session",
              onPressed: (){Navigator.pop(context);}
          ),
          title: Text(gamePin),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/main_background.jpg"),
                  fit: BoxFit.cover
              )
          ),

        )
    );
  }

}