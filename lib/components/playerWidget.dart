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
    Widget checkOrName = lastVoteWasCorrect
        ? Image(image: AssetImage("assets/images/check.png"), color: Colors.green)
        : Text(lastVote, style: TextStyle(fontSize: 16, color: Colors.red));
    String iconPath = lastVoteWasCorrect
        ? "assets/images/check.png"
        : "assets/images/cross.png";
    TextStyle nameStyle = TextStyle(color: Colors.black, fontSize: 18);
    AssetImage avatar = AssetImage("assets/images/avatar_example.png");
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(13)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                Image(image: avatar),
                Padding(
                    padding: const EdgeInsets.only(left: 30, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          points.toString(),
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ))
              ]),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: checkOrName)
            ]));
  }
}
