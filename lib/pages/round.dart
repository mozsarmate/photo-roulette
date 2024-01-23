import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_roulette/components/backdropFilter.dart';
import 'package:photo_roulette/pages/resultsPanel.dart';

import '../components/votePanel.dart';
import '../models/image_model.dart';

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
  List<ImageModel> images = [];
  List<String> players = [];
  @override
  void initState() {
    super.initState();
    fetchData();
    // Your function to run on widget load
  }

  Future<void> fetchData() async {
    _firestore.collection("2066").doc("static").collection("images").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot.exists) {
            var data = docSnapshot.data();
            images.add(
              ImageModel(
                  imageUrl: data["url"],
                  owner: data["commiter"],
                  id: data["img-id"]),
            );
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }


  ImageProvider<Object> getImageUrl(int id) {
    for (int i = 0; i < images.length; i++) {
      if (images[i].id == id) {
        return NetworkImage(images[i].imageUrl);
      }
    }
    return const AssetImage("assets/images/main_background.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("2066").doc('state').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("Loading...");
        }
        final data = snapshot.data!;
        final collection = snapshot.
        //final List<String> names = data["names"].cast<String>();
        return BlurredImage(
            image: getImageUrl(data['round']),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 150, left: 20, right: 20),
                      child: Image(
                        image: getImageUrl(data['round']),
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: (data['answer'])
                          ? VotePanel(
                              names: ["Blatin", "Johannes", "Lukas"])
                          : const ResultsPanel()),
                ]
            )
        );
      },
    );
  }
}
