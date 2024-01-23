import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:photo_roulette/models/player.dart';

class DbCommunicator {
  DbCommunicator();

  /// Initializes a room in Firestore with given structure.
  /// Returns a Future indicating the completion of the operation.
  Future<void> initRoom(FirebaseFirestore firestore, int numOfRounds, int timePerRound) async {
    try {
      int code = _generateRoomCode();
      String room = code.toString();
      Map<String, dynamic> staticData = {'order': [], 'owner': [], 'timePerRound': timePerRound, 'numOfRounds': numOfRounds};
      Map<String, dynamic> stateData = {
        'round': 0,
        'answerHidden': true,
        'voted': 0
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
  Future<Map<String, dynamic>?> getStaticData(
      FirebaseFirestore firestore, String roomCode) async {
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection(roomCode).doc("static").get();
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
  Future<Map<String, dynamic>?> getStateData(
      FirebaseFirestore firestore, String roomCode) async {
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection(roomCode).doc("state").get();
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

  Future<List<Player>?> getResults(
      FirebaseFirestore firestore, String roomCode) async {
    try {
      // Query the 'players' subcollection
      QuerySnapshot playersSnapshot = await firestore
          .collection(roomCode)
          .doc("state")
          .collection("players")
          .get();

      // Convert the query results to a list of Player objects

      List<Player> players =
          playersSnapshot.docs.map((doc) => Player.fromSnapshot(doc, doc.id)).toList();
      // Sort the players by points
      players.sort((a, b) => b.points.compareTo(a.points));
      return players.isNotEmpty ? players : null;
    } catch (e) {
      print("Error fetching players data: $e");
      return null;
    }
  }

  Future<void> addPlayer(
      FirebaseFirestore firestore, String roomCode, Player player) async {
    try {
      await firestore
          .collection(roomCode)
          .doc("state")
          .collection("players")
          .doc(player.name)
          .set({
        "points": player.points,
        "guess": player.guess,
        "avatar": player.avatar
      });
    } catch (e) {
      print("Error adding player: $e");
      return null;
    }
  }

  Future<void> incrementRound(
      FirebaseFirestore firestore, String roomCode) async {
    try {
      // Reference to the document
      DocumentReference stateDoc = firestore.collection(roomCode).doc("state");

      // Get the document
      DocumentSnapshot stateSnapshot = await stateDoc.get();
      if (stateSnapshot.exists && stateSnapshot.data() != null) {
        // Extract the data in a safe way
        Map<String, dynamic> data =
            stateSnapshot.data() as Map<String, dynamic>;
        int currentRound = data.containsKey('round') ? data['round'] as int : 0;

        // Increment and update the round value
        await stateDoc.update({"round": currentRound + 1});
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error incrementing round: $e");
      return null; // Consider using 'Future.error(e)' to propagate the error.
    }
  }

  Future<void> incrementVoted(
      FirebaseFirestore firestore, String roomCode) async {
    try {
      // Reference to the document
      DocumentReference stateDoc = firestore.collection(roomCode).doc("state");

      // Get the document
      DocumentSnapshot stateSnapshot = await stateDoc.get();
      if (stateSnapshot.exists && stateSnapshot.data() != null) {
        // Extract the data in a safe way
        Map<String, dynamic> data =
            stateSnapshot.data() as Map<String, dynamic>;
        int currentVote = data.containsKey('voted') ? data['voted'] as int : 0;

        // Increment and update the round value
        await stateDoc.update({"voted": currentVote + 1});
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error incrementing round: $e");
      return null; // Consider using 'Future.error(e)' to propagate the error.
    }
  }

  Future<void> resetVoted(FirebaseFirestore firestore, String roomCode) async {
    try {
      // Reference to the document
      DocumentReference stateDoc = firestore.collection(roomCode).doc("state");

      // Get the document
      DocumentSnapshot stateSnapshot = await stateDoc.get();
      if (stateSnapshot.exists && stateSnapshot.data() != null) {
        // Increment and update the round value
        await stateDoc.update({"voted": 0});
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error incrementing round: $e");
      return null; // Consider using 'Future.error(e)' to propagate the error.
    }
  }

  Future<void> resetRound(FirebaseFirestore firestore, String roomCode) async {
    try {
      // Reference to the document
      DocumentReference stateDoc = firestore.collection(roomCode).doc("state");

      // Get the document
      DocumentSnapshot stateSnapshot = await stateDoc.get();
      if (stateSnapshot.exists && stateSnapshot.data() != null) {
        // Increment and update the round value
        await stateDoc.update({"round": 0});
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error incrementing round: $e");
      return null; // Consider using 'Future.error(e)' to propagate the error.
    }
  }
}
