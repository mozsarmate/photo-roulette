import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  final String name;
  final int points;
  final String lastVote;
  final bool lastVoteWasCorrect;
  final String avatarPath;

  const PlayerWidget({
    super.key,
    required this.name,
    required this.points,
    required this.lastVote,
    required this.lastVoteWasCorrect,
    required this.avatarPath
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: lastVoteWasCorrect ? Colors.green : Colors.red
    );
    return Container(
        margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: <Widget>[
          Image(image: AssetImage(avatarPath)),
          Column(
            children: <Widget>[
              Text(name, style: textStyle),
              Row(
                children: <Widget>[
                  Image(image: AssetImage(lastVoteWasCorrect ? "assets/images/check.png": "assets/images/cross.png")),
                  Text(lastVote, style: textStyle)
                ]
              )
            ],
          )
        ],
      )
    );
  }
}
