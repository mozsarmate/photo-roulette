import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  final String name;
  final int points;
  final String lastVote;
  final bool lastVoteWasCorrect;
  final String avatarPath;

  const PlayerWidget(
      {super.key,
      required this.name,
      required this.points,
      required this.lastVote,
      required this.lastVoteWasCorrect,
      required this.avatarPath});

  @override
  Widget build(BuildContext context) {
    Color textColor = lastVoteWasCorrect ? Colors.green : Colors.red;
    String iconPath = lastVoteWasCorrect
        ? "assets/images/check.png"
        : "assets/images/cross.png";
    return Container(
        margin: EdgeInsets.all(10),
        width: 250,
        decoration: BoxDecoration(
            color: Color(0x30FFFFFF), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Image(image: AssetImage(avatarPath)),
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: textColor, fontSize: 20)),
                    Row(children: <Widget>[
                      Image(
                          image: AssetImage(iconPath), color: textColor),
                      Text(lastVote, style: TextStyle(color: textColor))
                    ])
                  ],
                ))
          ],
        ));
  }
}
