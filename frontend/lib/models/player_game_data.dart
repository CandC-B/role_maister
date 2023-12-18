import 'package:cloud_firestore/cloud_firestore.dart';
class PlayerGameData {
  final String characterId;
  int votedToGetKicked;

  PlayerGameData({
    required this.characterId,
    this.votedToGetKicked = 0,
  });

  factory PlayerGameData.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      String characterId = data['characterId'] ?? '';
      int votedToGetKicked = data['votedToGetKicked'] ?? 0;

      return PlayerGameData(
        characterId: characterId,
        votedToGetKicked: votedToGetKicked,
      );
    } else {
      throw Exception('Failed to parse document data');
    }
  }

  toMap() {
    return {
      'characterId': this.characterId,
      'votedToGetKicked': this.votedToGetKicked,
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return PlayerGameData(
      characterId: statsData['characterId'],
      votedToGetKicked: statsData['votedToGetKicked'],
    );
  }
}
