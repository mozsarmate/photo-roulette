
import 'package:flutter/material.dart';

import 'backdropFilter.dart';
import 'button.dart';

class VotePanel extends StatefulWidget {
  VotePanel({required this.names, super.key, required this.image, required this.round, required this.max, required this.reveal});
  final List<String> names;
  Function reveal;
  final int round;
  final int max;
  final ImageProvider<Object> image;
  @override
  State<StatefulWidget> createState() => _VotePanelState(names, image, round, max, reveal);
}

class _VotePanelState extends State<VotePanel> {
  _VotePanelState(this.names, this.image, this.round, this.max, this.reveal);
  Function reveal;
  List<String> names;
  final ImageProvider<Object> image;
  var vote = -1;
  final int round;
  final int max;
  @override
  Widget build(BuildContext context) {
    return BlurredImage(
        image: image,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        isPrimary: false,
                        text: "Reveal",
                        action: reveal,
                      ),
                      Text("Round $round/$max", style: const TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  )
              ),
              Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20),
                  child: Image(
                    image: image,
                  )),
              Container(
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  //constraints: const BoxConstraints.expand(),
                  child: GridView.builder(
                    reverse: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 1.0, // Spacing between columns
                      mainAxisSpacing: 1.0, // Spacing between rows
                      childAspectRatio: 2.1
                    ),
                    itemCount: names.length, // 3 rows and 2 columns, so total 6 items
                    itemBuilder: (context, index) {
                      return Button(
                        isPrimary: vote==index,
                        text: names[index],
                        action: () {
                          setState(() {
                            vote = index;
                          });
                        },
                      );
                    },
                  )
              )
            ]
        )
    );

  }
}