import 'package:flutter/material.dart';
import 'home.dart';
import 'imagePickerPage.dart';
import 'leaderboard.dart';
import 'lobby.dart';
import 'resultsPanel.dart';
import 'round.dart';

class Testing extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 100,),
          ElevatedButton(
            child: const Text("Home"),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
            },
          ),
          ElevatedButton(
            child: const Text("imagePickerPage"),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ImagePickerPage()));
            },
          ),
          ElevatedButton(
            child: const Text("Lobby"),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LobbyScreen(gamePin: "123456", name: "Beni")));
            },
          ),
          ElevatedButton(
            child: const Text("Round"),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const RoundScreen(gamePin: "123456")));
            },
          ),
          ElevatedButton(
            child: const Text("Round Results"),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResultsPanel()));//will need game pin
            },
          ),
          ElevatedButton(
            child: const Text("Game Results"),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaderBoardPage()));
            },
          )
        ],
      ),
    );
  }

}