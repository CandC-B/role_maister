import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String uid;
  final String username;
  final String? email;
  final int tokens;
  final List characters;
  final int gamesPlayed;
  final int experience;

  Player({required this.uid, required this.username, required this.email, required this.tokens ,required this.characters, required this.gamesPlayed, required this.experience});

  factory Player.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      // Extract the necessary fields from the Firestore document
      String uid = data['uid'] ?? '';
      String username = data['username'] ?? '';
      String email = data['email'] ?? '';
      int tokens = data['tokens'] ?? 0;
      List<String> characters = List<String>.from(data['characters'] ?? []);
      int gamesPlayed = data['gamesPlayed'] ?? 0;
      int experience = data['experience'] ?? 0;

      // Return a new Player instance
      return Player(
        uid: uid,
        username: username,
        email: email,
        tokens: tokens,
        characters: characters,
        gamesPlayed: gamesPlayed,
        experience: experience
      );
    } else {
      // Handle the case where data is null
      throw Exception('Failed to parse document data');
    }
  }
}