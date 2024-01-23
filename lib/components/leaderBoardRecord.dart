import 'package:flutter/material.dart';

class LeaderBoardRecord extends StatelessWidget {
  final int place;
  final String avatar;
  final String name;
  final int points;

  const LeaderBoardRecord({
    super.key,
    required this.place,
    required this.avatar,
    required this.name,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle nameStyle = TextStyle(
        color:
            place <= 3 ? Colors.white : Theme.of(context).colorScheme.secondary,
        fontSize: 18);

    Color barColor = place > 3
        ? Colors.white
        : place > 1
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary;

    return Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: barColor, borderRadius: BorderRadius.circular(13)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(place.toString(), style: nameStyle)),
                Image(image: AssetImage(avatar)),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      name,
                      style: nameStyle,
                    ))
              ]),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(points.toString(), style: nameStyle))
            ]));
  }
}
