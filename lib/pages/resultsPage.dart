import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_roulette/components/playerWidget.dart';

import '../components/button.dart';
import '../models/player.dart';

class ResultsPage extends StatelessWidget {
  final List<Player> players;
  final AssetImage roundImage;
  final String imageOwner;

  const ResultsPage({
    super.key,
    required this.players,
    required this.roundImage,
    required this.imageOwner
  });

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Theme.of(context).colorScheme.secondary;

    List<Widget> playerWidgets = [];

    for (int i = 0; i < players.length; i++){
      Player p = players[i];
      playerWidgets.add(PlayerWidget(name: p.name, points: p.points, lastVote: p.guess, lastVoteWasCorrect: (p.guess == imageOwner), avatarPath: p.avatar));
    }


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x00000000),
        leadingWidth: 150,
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Row(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Image(image: AssetImage("assets/images/camera.png"), color: primary)
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(imageOwner, textAlign: TextAlign.center, style: TextStyle(color: primary, fontSize: 22))
              )
            ],
          ),
        ),
      ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: roundImage, fit: BoxFit.cover)
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                Center(
                    child: Container(
                        margin: EdgeInsets.all(50),
                        height: 400,
                        decoration: BoxDecoration(color: Color(0xCC777777), borderRadius: BorderRadius.circular(20)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: playerWidgets
                        )
                    )
                ),
                Button(text: "Next Round", isPrimary: false),
                SizedBox(height: 75)
              ],
            )

        )
      );
  }
}
