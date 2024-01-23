import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_roulette/components/backdropFilter.dart';
import 'package:photo_roulette/pages/resultsPage.dart';

import '../components/votePanel.dart';
import '../models/image_model.dart';

class GamePage extends StatefulWidget {
  const GamePage({required this.gamePin, super.key});

  final String gamePin;

  @override
  State<StatefulWidget> createState() => _GameState(gamePin);
}
class _GameState extends State<GamePage>{
  _GameState(this.gamePin);
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
        List<ImageModel> res = [];
        for (var docSnapshot in querySnapshot.docs) {
          print("image");
          if (docSnapshot.exists) {
            var data = docSnapshot.data();
            res.add(
              ImageModel(
                  imageUrl: data["url"],
                  owner: data["commiter"],
                  id: data["img-id"]),
            );
          }
        }
        setState(() {
          images = res;
        });
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  ImageProvider<Object> getImageUrl(int id) {
    print(id);
    for (int i = 0; i < images.length; i++) {
      if (images[i].id == id) {
        return NetworkImage(images[i].imageUrl);
      }
    }
    return const AssetImage("assets/images/main_background.jpg");
  }
  void revealAns(){
    _firestore.collection("2066").doc('state').update({'revealed': true});
  }

  @override
  Widget build(BuildContext context) {
    if(images.isEmpty){
      return const Text("Loading...");
    }
    return StreamBuilder(
      stream: _firestore.collection("2066").doc('state').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("Loading...");
        }
        final data = snapshot.data!;
        //final List<String> names = data["names"].cast<String>();
        return (data['revealed'])
            ? const ResultsPage()
            : VotePanel(
          names: const ["Blatin", "Johannes", "Lukas", "asd"], image: getImageUrl(data['round']), round:4, max:images.length, reveal: revealAns);
      },
    );

  }
}
