import 'package:flutter/material.dart';

class ReadyPlayerWidget extends StatelessWidget {
  final String avatar;
  final String name;
  final bool ready;

  const ReadyPlayerWidget({
    super.key,
    required this.avatar,
    required this.name,
    required this.ready,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle nameStyle = const TextStyle(
        color:
        Colors.white,
        fontSize: 18);

    Color barColor = ready
        ? Colors.green
        : Colors.transparent;

    return Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: barColor, borderRadius: BorderRadius.circular(13), border: Border.all(color: const Color(0xFF929292))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Image(image: AssetImage(avatar))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      name,
                      style: nameStyle,
                    ))
              ])]),);
  }
}
