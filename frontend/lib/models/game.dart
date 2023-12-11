import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
// TODO 11/12 Al añadir players como map peta la partida y no inicia, revisar
class Game {
  final String uid;
  final int num_players;
  final String role_system;
  final Map<String, String> players;
  final String story_description;

  Game({
    String? uid,
    required this.num_players,
    required this.role_system,
    required this.players,
    required this.story_description,
  }) : uid = uid ?? const Uuid().v4();

  factory Game.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      // Extract the necessary fields from the Firestore document
      String uid = data['uid'] ?? '';
      int num_players = data['num_players'] ?? 0;
      String role_system = data['role_system'] ?? '';
      Map<String, String> players = Map<String, String>.from(data['players'] ?? []);
      String story_description = data['story_description'] ?? '';

      return Game(
        uid: uid,
        num_players: num_players,
        role_system: role_system,
        players: players,
        story_description: story_description,
      );
    } else {
      // Handle the case where data is null
      throw Exception('Failed to parse document data');
    }
  }

  toMap() {
    return {
      'uid': this.uid,
      'num_players': this.num_players,
      'role_system': this.role_system,
      'players': this.players,
      'story_description': this.story_description,
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return Game(
      num_players: statsData['num_players'],
      role_system: statsData['role_system'],
      players: statsData['players'],
      story_description: statsData['story_description'],
    );
  }
}
