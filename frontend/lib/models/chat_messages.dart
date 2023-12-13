import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  DateTime sentAt;
  String sentBy;
  String text;
  String senderName;
  String characterName;
  bool isInvalid;

  ChatMessages(
      {required this.sentBy,
      required this.sentAt,
      required this.text,
      required this.senderName,
      required this.characterName,
      this.isInvalid = false
    });

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String sentBy = documentSnapshot.get('sentBy');
    DateTime sentAt = documentSnapshot.get('sentAt');
    String text = documentSnapshot.get('text');
    String senderName = documentSnapshot.get('senderName');
    String characterName = documentSnapshot.get('characterName');
    bool isInvalid = documentSnapshot.get('isInvalid');

    return ChatMessages(
        sentBy: sentBy,
        sentAt: sentAt,
        text: text,
        senderName: senderName,
        characterName: characterName,
        isInvalid: isInvalid
      );
  }

  Map<String, dynamic> toMap() {
    return {
      'sentBy': sentBy,
      'sentAt': sentAt,
      'text': text,
      'senderName': senderName,
      'characterName': characterName,
      'isInvalid': isInvalid
    };
  }
}
