import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/roundPage.dart';

class RoundScreen extends StatefulWidget {
  const RoundScreen({required this.gamePin, super.key});

  final String gamePin;

  @override
  State<StatefulWidget> createState() => _RoundState(gamePin);
}

class _RoundState extends State<RoundScreen> {
  _RoundState(this.gamePin);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int state = 0;
  String gamePin;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("games").doc(gamePin).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("Loading...");
        }
        final data = snapshot.data as DocumentSnapshot;
        //final List<String> names = data["names"].cast<String>();
        return Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/main_background.jpg"),
                        fit: BoxFit.cover
                    )
                ),
              child:
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: (state == 0)
                        ? const VotePage(names: ["1", "2", "3", "4", "5", "6"])
                        : (state == 1)
                        ? const Text("2")
                        : const Text("Error"),
                  )


            )
        );
      },
    );

  }
}