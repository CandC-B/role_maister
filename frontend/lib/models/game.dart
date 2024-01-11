import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:role_maister/models/player_game_data.dart';
import 'package:uuid/uuid.dart';
import 'package:shortid/shortid.dart';
class Game {
  final String uid;
  final String creator_uid;
  final String short_uid;
  int ia_word_count;
  final int num_players;
  final String role_system;
  final Map<String, dynamic> players;
  final String story_description;
  final Map<String, dynamic> ready_players;
  final bool game_ready;

  Game({
    String? uid,
    required this.creator_uid,
    String? short_uid,
    this.ia_word_count = 0,
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
      int ia_word_count = data['ia_word_count'] ?? 0;
      String creator_uid = data['creator_uid'] ?? '';
      String short_uid = data['short_uid'] ?? '';
      int num_players = data['num_players'] ?? 0;
      String role_system = data['role_system'] ?? '';
      Map<String, dynamic> players = Map<String, dynamic>.from(data['players'] ?? []);
      String story_description = data['story_description'] ?? '';
      Map<String, dynamic> ready_players = Map<String, dynamic>.from(data['ready_players'] ?? []);
      bool game_ready = data['game_ready'] ?? false;

      return Game(
        uid: uid,
        ia_word_count: ia_word_count,
        creator_uid: creator_uid,
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
      'ia_word_count': this.ia_word_count,
      'creator_uid': this.creator_uid, 
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
      ia_word_count: statsData['ia_word_count'],
      creator_uid: statsData['creator_uid'],
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
