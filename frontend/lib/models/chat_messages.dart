import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChatMessages {
  final String id;
  DateTime sentAt;
  String sentBy;
  String text;
  String senderName;
  String characterName;
  bool isInvalid;
  String userImage;

  ChatMessages({
    String? id,
    required this.sentBy,
    required this.sentAt,
    required this.text,
    required this.senderName,
    required this.characterName,
    this.isInvalid = false,
    required this.userImage,
  }) : id = id ?? const Uuid().v4();

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String id = documentSnapshot.get('id');
    String sentBy = documentSnapshot.get('sentBy');
    DateTime sentAt = documentSnapshot.get('sentAt');
    String text = documentSnapshot.get('text');
    String senderName = documentSnapshot.get('senderName');
    String characterName = documentSnapshot.get('characterName');
    bool isInvalid = documentSnapshot.get('isInvalid');
    String userImage = documentSnapshot.get('userImage');

    return ChatMessages(
        id: id,
        sentBy: sentBy,
        sentAt: sentAt,
        text: text,
        senderName: senderName,
        characterName: characterName,
        isInvalid: isInvalid,
        userImage: userImage,
      );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sentBy': sentBy,
      'sentAt': sentAt,
      'text': text,
      'senderName': senderName,
      'characterName': characterName,
      'isInvalid': isInvalid,
      'userImage': userImage
    };
  }
}
