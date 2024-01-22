import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'dart:math';

class Comunicator{

  void _initRoom(FirebaseFirestore firestore){
    Random rng = Random();
    int code = rng.nextInt(100) + rng.nextInt(9)*1000; //generate a fix 4 digit num
    String room = code.toString();
    Map<String, dynamic> static = {
      'images' : [],
      'order' : [],
      'owner' : []
    };
    Map<String, dynamic> state = {
      'round' : 0,
      'players' : [],
    };
    firestore.collection(room).doc("static").set(static).onError((e, _) => print("Error writing document: $e"));;
    firestore.collection(room).doc("state").set(state).onError((e, _) => print("Error writing document: $e"));;

  }

  void _createSeq(){

  }
}


