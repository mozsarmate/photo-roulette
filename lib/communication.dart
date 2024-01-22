import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'dart:math';

class Comunicator{

  void _initRoom(FirebaseFirestore firestore){
    Random rng = Random();
    int code = rng.nextInt(100) + rng.nextInt(9)*1000; //generate a fix 4 digit num
    Map<String, dynamic> static = {
      'images' : [],
      'order' : [],
    };
    Map<String, dynamic> state = {
      'round' : 0,
      'players' : [],
    };
    firestore.collection(code.toString()).doc('static').set(static);
    firestore.collection(code.toString()).doc('state').set(state);
  }

  void _createSeq(){

  }
}


