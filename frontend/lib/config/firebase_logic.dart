import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';

FirebaseService firebase = FirebaseService();

FirebaseService firestoreService = FirebaseService();

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createCharacter(Map<String, dynamic> character) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('character').add(character);
      return docRef.id;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> createGame(Map<String, dynamic> gameConfig) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('game').add(gameConfig);
      return docRef.id;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> saveMessage(String messageText, DateTime sentAt,
      String currentGameId, String sentBy) async {
    if (messageText.trim().isNotEmpty) {
      Map<String, dynamic> message = {
        'text': messageText,
        'sentAt': sentAt,
        'sentBy': sentBy,
      };

      try {
        DocumentReference docRef = await _firestore
            .collection('message')
            .doc(currentGameId)
            .collection('messages')
            .add(message);
      } catch (error) {
        rethrow;
      }
    }
  }

  // Stream<List<Map<String, dynamic>>?> fetchMessagesByGameId(String gameId) {
  Stream<QuerySnapshot> fetchMessagesByGameId(String gameId) {
    return _firestore
        .collection('message')
        // .doc(gameId.trim())
        .doc(gameId)
        // .doc('m6VtWFlpFAS7ePjF6q0i')
        .collection('messages')
        .orderBy('sentAt', descending: true)
        .snapshots();
    // .map((QuerySnapshot querySnapshot) {
    //     List<Map<String, dynamic>> allMessages = [];
    //     querySnapshot.docs.forEach((doc) {
    //       if (doc.exists) {
    //         allMessages.add(doc.data() as Map<String, dynamic>);
    //       }
    //     });
    //     return allMessages;
    //   }
    // );
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      AppSingleton singleton = AppSingleton();
      singleton.user = user;
      context.go("/");
      context.push("/");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      // print('User signed in: ${user?.email}');
      singleton.user = user;
      context.go("/terms_conditions");
      context.push("/terms_conditions");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("The account already exists for that email");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    AppSingleton singleton = AppSingleton();
    singleton.user = null;
    // ignore: use_build_context_synchronously
    context.go("/");
    context.push("/");
  }
}
