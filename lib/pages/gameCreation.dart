import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_roulette/components/button.dart';
import 'package:photo_roulette/models/communication.dart';
import 'package:photo_roulette/pages/lobby.dart';

import '../components/mainAppBar.dart';

class GameCreation extends StatefulWidget {
  const GameCreation({super.key});

  @override
  _GameCreationState createState() => _GameCreationState();
}

class _GameCreationState extends State<GameCreation> {
  final DbCommunicator db = new DbCommunicator();
  final FirebaseFirestore f = FirebaseFirestore.instance;

  double minNumOfRounds = 5;
  double maxNumOfRounds = 30;

  double minTimePerRound = 5;
  double maxTimePerRound = 30;

  double numOfRoundsSlider = 7;
  double timePerRoundSlider = 12;

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: mainAppBar,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/main_background.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 150, left: 20),
                  child: Text("Create new game",
                      style: TextStyle(
                          fontSize: 60, color: Colors.white, height: 1))),
              Container(
                  child: Expanded(
                child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    children: <Widget>[
                      const Text("Rounds",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Slider(
                        min: minNumOfRounds,
                        max: maxNumOfRounds,
                        divisions:
                            maxNumOfRounds.toInt() - minNumOfRounds.toInt(),
                        label: numOfRoundsSlider.round().toString(),
                        value: numOfRoundsSlider,
                        onChanged: (double value) {
                          HapticFeedback.vibrate();
                          setState(() {
                            numOfRoundsSlider = value;
                          });
                        },
                      ),
                      const Text("Time per round",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Slider(
                        min: minTimePerRound,
                        max: maxTimePerRound,
                        divisions: ((maxTimePerRound.toInt() -
                                    minTimePerRound.toInt()) /
                                5)
                            .toInt(),
                        label: timePerRoundSlider.round().toString() + " sec",
                        value: timePerRoundSlider,
                        onChanged: (double value) {
                          HapticFeedback.vibrate();
                          setState(() {
                            timePerRoundSlider = value;
                          });
                        },
                      ),
                      Button(
                          text: "Create lobby",
                          isPrimary: true,
                          action: () async {
                            setState(() {
                              showLoading = true;
                            });
                            String? code = await db.initRoom(
                                f,
                                numOfRoundsSlider.round(),
                                timePerRoundSlider.round());
                            if (code != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => LobbyScreen(
                                          gamePin: code,
                                          name: "test",
                                          key: null)
                                  )
                              );
                            }
                            //navigate to lobby
                          }),
                        (showLoading ? CircularProgressIndicator() : Container()),
                    ]),
              )),
            ],
          ),
        ));
  }
}
