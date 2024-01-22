import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoundScreen extends StatefulWidget{
  RoundScreen({required this.gamePin, super.key});

  String gamePin;


  @override
  State<StatefulWidget> createState()=> _RoundState(gamePin);

}
class _RoundState extends State<RoundScreen>{
  _RoundState(this.gamePin);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String gamePin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lobby'),
        ),
        body:
        StreamBuilder(
          stream: _firestore.collection(gamePin).doc('state').snapshots(),
          builder: (context, snap) {
            print(snap.data);
            if(snap.hasData){
              return Text(snap.data!['round'].toString());
            }
            else
            return CircularProgressIndicator();
          },
        )

    );
  }
}