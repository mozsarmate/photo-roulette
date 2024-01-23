import 'package:flutter/material.dart';
import 'package:photo_roulette/pages/resultsPanel.dart';

class LobbyScreen extends StatefulWidget{
  //const LobbyScreen({required this.gamePin, super.key});
  final gamePin;
  final name; //for testing textField
  LobbyScreen({super.key, required String this.gamePin, required this.name});

  @override
  State<LobbyScreen> createState() => _LobbyState(gamePin, name);
}

class _LobbyState extends State<LobbyScreen>{
  late List<String> players;
  final gamePin;
  final name;

  _LobbyState(this.gamePin, this.name);


  @override
  Widget build(BuildContext context) {
    players=["Bujdi", "Marci", "Miki", "Bálint", "Máté", "Beni"];
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
        child: //Column(
          //children: <Widget>[
            //Text(name),
            GridView.count(
            crossAxisCount: 2,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.fromLTRB(50, 200, 50, 200),
            crossAxisSpacing: 180,
            children:List.generate(players.length, (index) => Text(players[index]),)),
              //children: List.generate(players.length, (index) => Center(child:Text(players[index]))),
            ),
          //],

      //)
    );
  }

}