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

      // add the character id to the user's list of characters
      final User? user = _auth.currentUser;
      if (user != null) {
        final DocumentReference userReference =
            _firestore.collection('user').doc(user.uid);
        final DocumentSnapshot userSnapshot = await userReference.get();

        if (userSnapshot.exists) {
          final Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          if (userData.containsKey("characters")) {
            final List<dynamic> characters = userData["characters"];
            characters.add(docRef.id);
            await userReference.update({"characters": characters});
          } else {
            await userReference.update({"characters": [docRef.id]});
          }
        } else {
          throw Exception("USER: Document does not exist");
        }
      } else {
        throw Exception("USER: User is null");
      }
      return docRef.id;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserCharacters(String userId) async {
    try {
      final DocumentReference userReference =
          _firestore.collection("user").doc(userId);
      final DocumentSnapshot userSnapshot = await userReference.get();

      if (userSnapshot.exists) {
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        if (userData.containsKey("characters")) {
          final List<dynamic> characterIds = userData["characters"];
          // Create a map to store character data
          Map<String, dynamic> charactersData = {};

          // Iterate over character IDs
          for (String characterId in characterIds) {
            // Retrieve the character document
            final DocumentReference characterReference =
                _firestore.collection("character").doc(characterId);
            final DocumentSnapshot characterSnapshot =
                await characterReference.get();
            if (characterSnapshot.exists) {
              // Add character data to the map
              charactersData[characterId] = characterSnapshot.data();
            } else {
              // Handle the case where a character document does not exist
              throw Exception("Character with ID $characterId does not exist");
            }
          }
          // Return the map of character data
          return charactersData;

        } else {
          throw Exception("USER: Attribute 'characters' does not exist");
        }
      } else {
        throw Exception("USER: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }

  // TODO: modificar esta función para el multiplayer
  Future<Map<String, dynamic>> getCharacters(String gameId) async {
    try {
      final DocumentReference gameReference =
          _firestore.collection("game").doc(gameId);
      final DocumentSnapshot gameSnapshot = await gameReference.get();

      if (gameSnapshot.exists) {
        final Map<String, dynamic> gameData =
            gameSnapshot.data() as Map<String, dynamic>;

        if (gameData.containsKey("players")) {
          final List<dynamic> players = gameData["players"];

          if (players.isNotEmpty) {
            final String characterId = players[0];
            final DocumentReference characterReference =
                _firestore.collection('character').doc(characterId);
            final DocumentSnapshot characterSnapshot =
                await characterReference.get();

            if (characterSnapshot.exists) {
              final Map<String, dynamic> characterData =
                  characterSnapshot.data() as Map<String, dynamic>;

              // print(characterData);
              return characterData;
            } else {
              throw Exception("CHARACTER: Document does not exist");
            }
          } else {
            throw Exception("GAME: 'players' list is empty");
          }
        } else {
          throw Exception("GAME: Attribute 'players' does not exist");
        }
      } else {
        throw Exception("GAME: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> checkUsernameAlreadyExist(String username) async {
    try {
      final CollectionReference userReference =
          FirebaseFirestore.instance.collection("user");

      QuerySnapshot querySnapshot =
          await userReference.where("username", isEqualTo: username).get();
      if(querySnapshot.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
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

  Future<void> saveUser(User user, String username) async {
    Map<String, dynamic> currentUser = {
      'uid': user.uid,
      'username': username,
      'email': user.email,
      'characters': [],
    };
    try {
      _firestore.collection('user').doc(user.uid).set(currentUser);
      // TODO error contorl if user cannot be created
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

  Future<List<Map<String, dynamic>>?> fetchConversationByGameID(
      String gameId) async {
    try {
      List<Map<String, dynamic>> allMessages = [];

      final querySnapshot = await _firestore
          .collection('message')
          .doc(gameId)
          .collection('messages')
          .orderBy('sentAt', descending: true)
          .get();

      querySnapshot.docs.forEach((doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          final sentBy = data['sentBy'] as String;
          final text = data['text'] as String;
          if (sentBy == "IA") {
            allMessages.add({"role": "CHATBOT", "message": text});
          }
        }
      });

      return allMessages;
    } catch (e) {
      print("Error fetching conversation: $e");
      return null;
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

  Future<bool?> signIn(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      AppSingleton singleton = AppSingleton();
      singleton.user = user;
      context.go("/");
      context.push("/");
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return true;
    }
  }

  Future<User?> signUp(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      // print('User signed in: ${user?.email}');
      singleton.user = user;
      context.go("/rules");
      context.push("/rules");
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    AppSingleton singleton = AppSingleton();
    singleton.user = null;
    // ignore: use_build_context_synchronously
    context.go("/");
    context.push("/");
  }

  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    context.go("/sign_in");
    context.push("/sign_in");
  }
}
