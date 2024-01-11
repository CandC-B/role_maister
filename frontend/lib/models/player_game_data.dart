import 'package:cloud_firestore/cloud_firestore.dart';
class PlayerGameData {
  final String characterId;
  int votedToGetKicked;
  bool isKickedFromWaitingRoom = false;

  PlayerGameData({
    required this.characterId,
    this.votedToGetKicked = 0,
    this.isKickedFromWaitingRoom = false,
  });

  factory PlayerGameData.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic>? data = document.data();
    if (data != null) {
      String characterId = data['characterId'] ?? '';
      int votedToGetKicked = data['votedToGetKicked'] ?? 0;
      bool isKickedFromWaitingRoom = data['isKickedFromWaitingRoom'] ?? false;

      return PlayerGameData(
        characterId: characterId,
        votedToGetKicked: votedToGetKicked,
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
      'isKickedFromWaitingRoom': this.isKickedFromWaitingRoom,
    };
  }

  static fromMap(Map<String, dynamic> statsData) {
    return PlayerGameData(
      characterId: statsData['characterId'],
      votedToGetKicked: statsData['votedToGetKicked'],
      isKickedFromWaitingRoom: statsData['isKickedFromWaitingRoom'],
    );
  }
}
