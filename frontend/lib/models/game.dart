import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:role_maister/models/player_game_data.dart';
import 'package:uuid/uuid.dart';
import 'package:shortid/shortid.dart';
class Game {
  final String uid;
  final String short_uid;
  final int num_players;
  final String role_system;
  final Map<String, dynamic> players;
  final String story_description;
  final Map<String, dynamic> ready_players;
  final bool game_ready;

  Game({
    String? uid,
    String? short_uid,
    required this.num_players,
    required this.role_system,
    required this.players,
    required this.story_description,
    required this.ready_players,
    required this.game_ready,
  }) : uid = uid ?? const Uuid().v4(),
        short_uid = shortid.generate();

  factory Game.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      String uid = data['uid'] ?? '';
      String short_uid = data['short_uid'] ?? '';
      int num_players = data['num_players'] ?? 0;
      String role_system = data['role_system'] ?? '';
      Map<String, dynamic> players = Map<String, dynamic>.from(data['players'] ?? []);
      String story_description = data['story_description'] ?? '';
      Map<String, dynamic> ready_players = Map<String, dynamic>.from(data['ready_players'] ?? []);
      bool game_ready = data['game_ready'] ?? false;

      return Game(
        uid: uid,
        short_uid: short_uid,
        num_players: num_players,
        role_system: role_system,
        players: players,
        story_description: story_description,
        ready_players: ready_players,
        game_ready: game_ready,
      );
    } else {
      throw Exception('Failed to parse document data');
    }
  }

  toMap() {
    return {
      'uid': this.uid,
      'short_uid': this.short_uid,
      'num_players': this.num_players,
      'role_system': this.role_system,
      'players': this.players,
      'story_description': this.story_description,
      'ready_players': this.ready_players,
      'game_ready': this.game_ready,
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return Game(
      uid: statsData['uid'],
      short_uid: statsData['short_uid'],
      num_players: statsData['num_players'],
      role_system: statsData['role_system'],
      players: statsData['players'],
      story_description: statsData['story_description'],
      ready_players: statsData['ready_players'],
      game_ready: statsData['game_ready'],
    );
  }
}
