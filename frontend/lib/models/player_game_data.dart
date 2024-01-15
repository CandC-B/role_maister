import 'package:cloud_firestore/cloud_firestore.dart';
class PlayerGameData {
  final String characterId;
  int votedToGetKicked;
  List<dynamic> votedToGetKickedBy;
  int word_count;
  bool isKickedFromWaitingRoom = false;

  PlayerGameData({
    required this.characterId,
    this.votedToGetKicked = 0,
    this.votedToGetKickedBy = const [],
    this.word_count = 0,
    this.isKickedFromWaitingRoom = false,
  });

  factory PlayerGameData.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      String characterId = data['characterId'] ?? '';
      int votedToGetKicked = data['votedToGetKicked'] ?? 0;
      List<dynamic> votedToGetKickedBy = List<dynamic>.from(data['votedToGetKickedBy'] ?? []);
      int word_count = data['word_count'] ?? 0;
      bool isKickedFromWaitingRoom = data['isKickedFromWaitingRoom'] ?? false;

      return PlayerGameData(
        characterId: characterId,
        votedToGetKicked: votedToGetKicked,
        votedToGetKickedBy: votedToGetKickedBy,
        word_count: word_count,
        isKickedFromWaitingRoom: isKickedFromWaitingRoom,
      );
    } else {
      throw Exception('Failed to parse document data');
    }
  }

  toMap() {
    return {
      'characterId': this.characterId,
      'votedToGetKicked': this.votedToGetKicked,
      'votedToGetKickedBy': this.votedToGetKickedBy,
      'word_count': this.word_count,
      'isKickedFromWaitingRoom': this.isKickedFromWaitingRoom,
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return PlayerGameData(
      characterId: statsData['characterId'],
      votedToGetKicked: statsData['votedToGetKicked'],
      votedToGetKickedBy: statsData['votedToGetKickedBy'],
      word_count: statsData['word_count'],
      isKickedFromWaitingRoom: statsData['isKickedFromWaitingRoom'],
    );
  }
}
