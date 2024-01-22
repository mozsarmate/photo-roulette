import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoundScreen extends StatefulWidget{
  const RoundScreen({required this.gamePin, super.key});

  final String gamePin;


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
        body:
        StreamBuilder(
          stream: _firestore.collection(gamePin).doc('state').snapshots(),
          builder: (context, snap) {
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