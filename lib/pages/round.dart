import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_roulette/pages/resultsPanel.dart';

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
                        fit: BoxFit.cover)),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 400,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if(state==0){
                                  state=1;
                                }else{
                                  state=0;
                                }
                              });
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: const Color(0x00000000)),
                                      borderRadius: BorderRadius.circular(20))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.primary),
                            ),
                            child: Text("Results",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 20)),
                          ),
                          (state == 0)
                              ? const VotePage(
                                  names: ["1", "2", "3", "4", "5", "6"])
                              : const ResultsPanel()
                        ],
                      ),
                    ))));
      },
    );
  }
}
