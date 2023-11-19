import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String uid;
  final String username;
  final String? email;
  final int tokens;
  final List aliensCharacters;
  final List dydCharacters;
  final List cthulhuCharacters;
  final int gamesPlayed;
  final int experience;

  Player({required this.uid, required this.username, required this.email, required this.tokens ,required this.aliensCharacters ,required this.dydCharacters ,required this.cthulhuCharacters, required this.gamesPlayed, required this.experience});

  factory Player.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      // Extract the necessary fields from the Firestore document
      String uid = data['uid'] ?? '';
      String username = data['username'] ?? '';
      String email = data['email'] ?? '';
      int tokens = data['tokens'] ?? 0;
      List<String> aliensCharacters = List<String>.from(data['aliensCharacters'] ?? []);
      List<String> dydCharacters = List<String>.from(data['characters'] ?? []);
      List<String> cthulhuCharacters = List<String>.from(data['characters'] ?? []);
      int gamesPlayed = data['gamesPlayed'] ?? 0;
      int experience = data['experience'] ?? 0;

      // Return a new Player instance
      return Player(
        uid: uid,
        username: username,
        email: email,
        tokens: tokens,
        aliensCharacters: aliensCharacters,
        dydCharacters: dydCharacters,
        cthulhuCharacters: cthulhuCharacters,
        gamesPlayed: gamesPlayed,
        experience: experience
      );
    } else {
      // Handle the case where data is null
      throw Exception('Failed to parse document data');
    }
  }
}