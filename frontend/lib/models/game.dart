import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Game {
  final String uid;
  final int num_players;
  final String role_system;
  final List users;
  final List players;
  final String story_description;

  Game({
    String? uid,
    required this.num_players,
    required this.role_system,
    required this.players,
    required this.users,
    required this.story_description,
  }) : uid = uid ?? const Uuid().v4();

  factory Game.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      // Extract the necessary fields from the Firestore document
      String uid = data['uid'] ?? '';
      int num_players = data['num_players'] ?? 0;
      String role_system = data['role_system'] ?? '';
      List<String> players = List<String>.from(data['players'] ?? []);
      List<String> users = List<String>.from(data['users'] ?? []);
      String story_description = data['story_description'] ?? '';

      return Game(
        uid: uid,
        num_players: num_players,
        role_system: role_system,
        players: players,
        users: users,
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
      'users': this.users,
      'story_description': this.story_description,
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return Game(
      num_players: statsData['num_players'],
      role_system: statsData['role_system'],
      players: statsData['players'],
      users: statsData['users'],
      story_description: statsData['story_description'],
    );
  }
}
