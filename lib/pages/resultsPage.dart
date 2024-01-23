import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_roulette/components/playerWidget.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Player> players = [];
    List<Widget> playerWidgets = [
      PlayerWidget(
          name: "eotvos",
          points: 2,
          lastVote: "blatin",
          lastVoteWasCorrect: true,
          avatarPath: "assets/images/avatar_example.png"),
      PlayerWidget(
          name: "blatin",
          points: 2,
          lastVote: "bujdi",
          lastVoteWasCorrect: false,
          avatarPath: "assets/images/avatar_example.png"),
      PlayerWidget(
          name: "brikk",
          points: 2,
          lastVote: "mate",
          lastVoteWasCorrect: false,
          avatarPath: "assets/images/avatar_example.png"),
      PlayerWidget(
          name: "bujdi",
          points: 10,
          lastVote: "blatin",
          lastVoteWasCorrect: true,
          avatarPath: "assets/images/avatar_example.png")
    ];
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/main_background.jpg"))
          ),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(50),
                height: 400,
                decoration: BoxDecoration(color: Color(0xCC777777), borderRadius: BorderRadius.circular(20)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: playerWidgets)
              )
            )
        )
              );
  }
}
