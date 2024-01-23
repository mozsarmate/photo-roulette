import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/mainAppBar.dart';

class GameCreation extends StatefulWidget {
  const GameCreation({super.key});

  @override
  _GameCreationState createState() => _GameCreationState();
}

class _GameCreationState extends State<GameCreation> {

  double minNumOfRounds = 5;
  double maxNumOfRounds = 30;

  double minTimePerRound = 5;
  double maxTimePerRound = 30;

  double numOfRoundsSlider = 7;
  double timePerRoundSlider = 12;

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
                        divisions: maxNumOfRounds.toInt() - minNumOfRounds.toInt(),
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
                        divisions: ((maxTimePerRound.toInt() - minTimePerRound.toInt())/5).toInt(),
                        label: timePerRoundSlider.round().toString(),
                        value: timePerRoundSlider,
                        onChanged: (double value) {
                          HapticFeedback.vibrate();
                          setState(() {
                            timePerRoundSlider = value;
                          });
                        },
                      ),
                    ]),
              )),
            ],
          ),
        ));
  }
}
