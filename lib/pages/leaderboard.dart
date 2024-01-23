import 'package:flutter/material.dart';
import 'package:photo_roulette/components/button.dart';
import 'package:photo_roulette/components/leaderBoardRecord.dart';
import 'package:photo_roulette/components/mainAppBar.dart';

class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: mainAppBar,
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/main_background.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 150, left: 20),
                      child: Text("Good fckn\nGame",
                          style: TextStyle(
                              fontSize: 60, color: Colors.white, height: 1))),
                  Container(
                      child: Expanded(
                          child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    children: const <Widget>[
                      LeaderBoardRecord(
                          place: 1,
                          avatar: "assets/images/avatar_example.png",
                          name: "Bujdi",
                          points: 513),
                      LeaderBoardRecord(
                          place: 2,
                          avatar: "assets/images/avatar_example.png",
                          name: "Mate",
                          points: 445),
                      LeaderBoardRecord(
                          place: 3,
                          avatar: "assets/images/avatar_example.png",
                          name: "Blatin",
                          points: 279),
                      LeaderBoardRecord(
                          place: 4,
                          avatar: "assets/images/avatar_example.png",
                          name: "Blatin",
                          points: 279)
                    ],
                  ))),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(text: "Invite Others", isPrimary: false),
                      Button(text: "Play Again", isPrimary: true)
                    ],
                  ),
                  const SizedBox(height: 75)
                ])));
  }
}
