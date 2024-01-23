import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String name;
  late int points;
  late String guess;
  late String avatar;

  Player(this.name, {this.guess = '', this.points = 0, this.avatar = ''});

  // Constructor to create a Player object from a DocumentSnapshot
  Player.fromSnapshot(DocumentSnapshot snapshot, this.name) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    // Initialize properties from the snapshot data
    points = data['points'] ?? 0;
    guess = data['guess'] ?? '';
    avatar = data['avatar'] ?? '';
  }
}
