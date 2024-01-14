import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String uid;
  final String username;
  final String? email;
  double tokens;
  final List aliens;
  final List dyd;
  final List cthulhu;
  final int gamesPlayed;
  final int experience;
  final String? photoUrl;
  final List games;

  Player(
      {required this.uid,
      required this.username,
      required this.email,
      required this.tokens,
      required this.aliens,
      required this.dyd,
      required this.cthulhu,
      required this.gamesPlayed,
      required this.experience,
      required this.photoUrl,
      required this.games});

  factory Player.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      // Extract the necessary fields from the Firestore document
      String uid = data['uid'] ?? '';
      String username = data['username'] ?? '';
      String email = data['email'] ?? '';
      double tokens = data['tokens'] ?? 0.0;
      List<String> aliens = List<String>.from(data['aliens'] ?? []);
      List<String> dyd = List<String>.from(data['dyd'] ?? []);
      List<String> cthulhu = List<String>.from(data['cthulhu'] ?? []);
      int gamesPlayed = data['gamesPlayed'] ?? 0;
      int experience = data['experience'] ?? 0;
      String? photoUrl = data['photoUrl'];
      List games = List.from(data['games'] ?? []);

      // Return a new Player instance
      return Player(
        uid: uid,
        username: username,
        email: email,
        tokens: tokens,
        aliens: aliens,
        dyd: dyd,
        cthulhu: cthulhu,
        gamesPlayed: gamesPlayed,
        experience: experience,
        photoUrl: photoUrl,
        games: games,
      );
    } else {
      // Handle the case where data is null
      throw Exception('Failed to parse document data');
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'tokens': tokens,
      'aliens': aliens,
      'dyd': dyd,
      'cthulhu': cthulhu,
      'gamesPlayed': gamesPlayed,
      'experience': experience,
      'photoUrl': photoUrl,
      'games': games,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Player(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      tokens: map['tokens'],
      aliens: map['aliens'],
      dyd: map['dyd'],
      cthulhu: map['cthulhu'],
      gamesPlayed: map['gamesPlayed'],
      experience: map['experience'],
      photoUrl: map['photoUrl'],
      games: map['games'],
    );
  }
}
