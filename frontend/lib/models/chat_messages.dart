import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  String sentAt;
  String sentBy;
  String text;
  // String username;
  // String characterName;
  // bool isInvalid;

  ChatMessages(
      {required this.sentBy,
      required this.sentAt,
      required this.text,
      // required this.username,
      // required this.characterName,
      // this.isInvalid = false
    });

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String sentBy = documentSnapshot.get('sentBy');
    String sentAt = documentSnapshot.get('sentAt');
    String text = documentSnapshot.get('text');
    // String username = documentSnapshot.get('username');
    // String characterName = documentSnapshot.get('characterName');
    // bool isInvalid = documentSnapshot.get('isInvalid');

    return ChatMessages(
        sentBy: sentBy,
        sentAt: sentAt,
        text: text,
        // username: username,
        // characterName: characterName,
        // isInvalid: isInvalid
      );
  }
}
