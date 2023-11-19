import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/player.dart';
import 'package:role_maister/widgets/aliens_characters_card.dart';

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
          if (singleton.gameMode.value == "Aliens") {
            if (userData.containsKey("aliensCharacters")) {
              final List<dynamic> characters = userData["aliensCharacters"];
              characters.add(docRef.id);
              await userReference.update({"aliensCharacters": characters});
            } else {
              await userReference.update({
                "aliensCharacters": [docRef.id]
              });
            }
          } else if (singleton.gameMode.value == "Dyd") {
            if (userData.containsKey("dydCharacters")) {
              final List<dynamic> characters = userData["dydCharacters"];
              characters.add(docRef.id);
              await userReference.update({"dydCharacters": characters});
            } else {
              await userReference.update({
                "dydCharacters": [docRef.id]
              });
            }
          } else if (singleton.gameMode.value == "Cthulhu") {
            if (userData.containsKey("cthulhuCharacters")) {
              final List<dynamic> characters = userData["cthulhuCharacters"];
              characters.add(docRef.id);
              await userReference.update({"cthulhuCharacters": characters});
            } else {
              await userReference.update({
                "cthulhuCharacters": [docRef.id]
              });
            }
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
        if (singleton.gameMode.value == "Aliens") {
          if (userData.containsKey("aliensCharacters")) {
            final List<dynamic> characterIds = userData["aliensCharacters"];
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
                throw Exception(
                    "Character with ID $characterId does not exist");
              }
            }
            // Return the map of character data
            return charactersData;
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else if (singleton.gameMode.value == "Dyd") {
          if (userData.containsKey("dydCharacters")) {
            final List<dynamic> characterIds = userData["dydCharacters"];
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
                throw Exception(
                    "Character with ID $characterId does not exist");
              }
            }
            // Return the map of character data
            return charactersData;
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else if (singleton.gameMode.value == "Cthulhu") {
          if (userData.containsKey("cthulhuCharacters")) {
            final List<dynamic> characterIds = userData["cthulhuCharacters"];
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
                throw Exception(
                    "Character with ID $characterId does not exist");
              }
            }
            // Return the map of character data
            return charactersData;
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else {
          throw Exception("USER: Game mode not selected");
        }
      } else {
        throw Exception("USER: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }


  Future<Map<String, dynamic>> getUserCharactersFromMode(String userId, String mode) async {
    try {
      final DocumentReference userReference =
          _firestore.collection("user").doc(userId);
      final DocumentSnapshot userSnapshot = await userReference.get();
      if (userSnapshot.exists) {
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        if (mode == "Aliens") {
          if (userData.containsKey("aliensCharacters")) {
            final List<dynamic> characterIds = userData["aliensCharacters"];
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
                throw Exception(
                    "Character with ID $characterId does not exist");
              }
            }
            // Return the map of character data
            return charactersData;
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else if (mode == "Dyd") {
          if (userData.containsKey("dydCharacters")) {
            final List<dynamic> characterIds = userData["dydCharacters"];
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
                throw Exception(
                    "Character with ID $characterId does not exist");
              }
            }
            // Return the map of character data
            return charactersData;
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else if (mode == "Cthulhu") {
          if (userData.containsKey("cthulhuCharacters")) {
            final List<dynamic> characterIds = userData["cthulhuCharacters"];
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
                throw Exception(
                    "Character with ID $characterId does not exist");
              }
            }
            // Return the map of character data
            return charactersData;
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else {
          throw Exception("USER: Game mode not selected");
        }
      } else {
        throw Exception("USER: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }
  
  Future<List<dynamic>> getUserCharactersIdFromMode(String userId, String mode) async {
    try {
      final DocumentReference userReference =
          _firestore.collection("user").doc(userId);
      final DocumentSnapshot userSnapshot = await userReference.get();
      if (userSnapshot.exists) {
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        if (mode == "Aliens") {
          if (userData.containsKey("aliensCharacters")) {
            return userData["aliensCharacters"];
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else if (mode == "Dyd") {
          if (userData.containsKey("dydCharacters")) {
            return userData["dydCharacters"];
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else if (mode == "Cthulhu") {
          if (userData.containsKey("cthulhuCharacters")) {
            return userData["cthulhuCharacters"];
          } else {
            throw Exception("USER: Attribute 'characters' does not exist");
          }
        } else {
          throw Exception("USER: Game mode not selected");
        }
      } else {
        throw Exception("USER: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> fetchCharactersByUserId(String userId, String mode) async* {
    print("actualización------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    List<dynamic> charactersId = await getUserCharactersIdFromMode(userId, mode);
    yield*  _firestore
        .collection('character')
        .where(FieldPath.documentId, whereIn: charactersId)
        .snapshots();
  }

  // TODO: modificar esta función para el multiplayer
  Future<Map<String, dynamic>> getCharactersFromGameId(String gameId) async {
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

  Future<void> getAliensCharactersFromUserId(String userId) async {
    List<AliensCharacter> characters = [];

    try {
      CollectionReference charactersCollection =
          FirebaseFirestore.instance.collection('characters');

      QuerySnapshot querySnapshot =
          await charactersCollection.where('userId', isEqualTo: userId).get();

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        if (data.containsKey('aliensCharacters')) {
          List<dynamic> charactersList = data['aliensCharacters'];

          charactersList.forEach((characterData) {
            AliensCharacter character = AliensCharacter.fromMap(characterData);
            characters.add(character);
          });
        }
      });
    } catch (e) {
      print("Error fetching characters: $e");
    }
  }

  Future<void> getDydCharactersFromUserId(String userId) async {
    List<DydCharacter> characters = [];

    try {
      CollectionReference charactersCollection =
          FirebaseFirestore.instance.collection('characters');

      QuerySnapshot querySnapshot =
          await charactersCollection.where('userId', isEqualTo: userId).get();

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        if (data.containsKey('dydCharacters')) {
          List<dynamic> charactersList = data['dydCharacters'];

          charactersList.forEach((characterData) {
            DydCharacter character = DydCharacter.fromMap(characterData);
            characters.add(character);
          });
        }
      });
    } catch (e) {
      print("Error fetching characters: $e");
    }
  }

  Future<void> getCthulhuCharactersFromUserId(String userId) async {
    List<CthulhuCharacter> characters = [];

    try {
      CollectionReference charactersCollection =
          FirebaseFirestore.instance.collection('characters');

      QuerySnapshot querySnapshot =
          await charactersCollection.where('userId', isEqualTo: userId).get();

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        if (data.containsKey('cthulhuCharacters')) {
          List<dynamic> charactersList = data['cthulhuCharacters'];

          charactersList.forEach((characterData) {
            CthulhuCharacter character =
                CthulhuCharacter.fromMap(characterData);
            characters.add(character);
          });
        }
      });
    } catch (e) {
      print("Error fetching characters: $e");
    }
  }

  Future<bool> checkUsernameAlreadyExist(String username) async {
    try {
      final CollectionReference userReference =
          FirebaseFirestore.instance.collection("user");

      QuerySnapshot querySnapshot =
          await userReference.where("username", isEqualTo: username).get();
      if (querySnapshot.docs.isEmpty) {
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

  Future<void> createRandomPlayer() async {
    try {
      AliensCharacter newRandomUser = AliensCharacter.random();
      await firebase.createCharacter(newRandomUser.toMap());
// TODO create random player
      // Reload character data to update the UI
    } catch (error) {
      print("Error creating random player: $error");
    }
  }

  Future<void> saveUser(Player player) async {
    Map<String, dynamic> currentPlayer = {
      'uid': player.uid,
      'username': player.username,
      'email': player.email,
      'tokens': player.tokens,
      'aliensCharacters': player.aliensCharacters,
      'dydCharacters': player.dydCharacters,
      'cthulhuCharacters': player.cthulhuCharacters,
      'gamesPlayed': player.gamesPlayed,
      'experience': player.experience
    };
    try {
      _firestore.collection('user').doc(player.uid).set(currentPlayer);
      // TODO error contorl if user cannot be created
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchPlayerData() async {
    DocumentSnapshot<Map<String, dynamic>> playerDocument =
        await _firestore.collection('user').doc(singleton.user?.uid).get();

    Player player = Player.fromDocument(playerDocument);
    print(player);
    singleton.player = player;
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
      if (e.code == 'email-already-in-use') {}
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
