import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_roulette/components/playerWidget.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Player> players = [];
    List<Widget> playerWidgets = [
      PlayerWidget(name: "bujdi", points: 10, lastVote: "blatin", lastVoteWasCorrect: true, avatarPath: "assets/images/cross.png"),
      PlayerWidget(name: "blatin", points: 2, lastVote: "bujdi", lastVoteWasCorrect: false, avatarPath: "assets/images/cross.png")
    ];
    return Scaffold(
      body: Center(
        child: Row(
             children: <Widget>[Container(
                // margin: EdgeInsets.all(20),
                child: Column(
                    children: playerWidgets
                )
            )]
        )
      )
    );
  }
}

