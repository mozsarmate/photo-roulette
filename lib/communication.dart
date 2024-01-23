import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:photo_roulette/player.dart';

class DbCommunicator {
  DbCommunicator();

  /// Initializes a room in Firestore with given structure.
  /// Returns a Future indicating the completion of the operation.
  Future<void> initRoom(FirebaseFirestore firestore) async {
    try {
      int code = _generateRoomCode();
      String room = code.toString();
      Map<String, dynamic> staticData = {
        'order': [],
        'owner': []
      };
      Map<String, dynamic> stateData = {
        'round': 0,
        'players': [],
      };

      await firestore.collection(room).doc("static").set(staticData);
      await firestore.collection(room).doc("state").set(stateData);
    } catch (e) {
      print("Error initializing room: $e");
      // Consider how to handle the error. Maybe rethrow or return a status.
    }
  }

  /// Generates a fixed 4-digit room code.
  int _generateRoomCode() {
    Random rng = Random();
    return rng.nextInt(9000) + 1000; // Ensures a 4-digit number
  }

  /// Fetches the static data from a specified room.
  Future<Map<String, dynamic>?> getStaticData(FirebaseFirestore firestore, String roomCode) async {
    try {
      DocumentSnapshot docSnapshot = await firestore.collection(roomCode).doc("static").get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        print("No static data found for room $roomCode");
        return null;
      }
    } catch (e) {
      print("Error fetching static data: $e");
      return null;
    }
  }

  /// Fetches the state data from a specified room.
  Future<Map<String, dynamic>?> getStateData(FirebaseFirestore firestore, String roomCode) async {
    try {
      DocumentSnapshot docSnapshot = await firestore.collection(roomCode).doc("state").get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        print("No state data found for room $roomCode");
        return null;
      }
    } catch (e) {
      print("Error fetching state data: $e");
      return null;
    }
  }

  Future<List<Player>?> getResults(FirebaseFirestore firestore, String roomCode) async {
    try {
      DocumentSnapshot docSnapshot = await firestore.collection(roomCode).doc("state").get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey('players') && data['players'] is List) {
          List<Player> players = data['players'];
          players.sort((a, b) => b.points.compareTo(a.points));
          return players;
        } else {
          print("No players data found in the room $roomCode");
          return null;
        }
      } else {
        print("State document does not exist in room $roomCode");
        return null;
      }
    } catch (e) {
      print("Error fetching players data: $e");
      return null;
    }
  }



}

