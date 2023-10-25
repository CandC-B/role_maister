import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  String sentAt;
  String sentBy;
  String text;

  ChatMessages(
      {required this.sentBy, required this.sentAt, required this.text});

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String sentBy = documentSnapshot.get('sentBy');
    String sentAt = documentSnapshot.get('sentAt');
    String text = documentSnapshot.get('text');

    return ChatMessages(sentBy: sentBy, sentAt: sentAt, text: text);
  }
}
