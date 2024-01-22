import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_options.dart';
import 'dart:math';

class Comunicator{

  void _initRoom(FirebaseFirestore firestore){
    Random rng = Random();
    int code = rng.nextInt(100) + rng.nextInt(9)*1000; //generate a fix 4 digit num
    Map<String, dynamic> players = {
      'name1' : '',
      'ready1' : '',
    };
    firestore.collection(code.toString()).add(players);
  }

  void _createSeq(){

  }
}


