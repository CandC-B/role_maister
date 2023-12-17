import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/chat_messages.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/game.dart';
import 'package:role_maister/models/player.dart';
import 'package:role_maister/models/player_game_data.dart';
import 'package:role_maister/widgets/aliens_characters_card.dart';
import 'package:uuid/uuid.dart';

FirebaseService firebase = FirebaseService();

FirebaseService firestoreService = FirebaseService();

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getCharacter(
      String characterId, String gameMode) async {
    try {
      final DocumentReference characterReference = _firestore
          .collection('character')
          .doc(gameMode)
          .collection(gameMode)
          .doc(characterId);
      final DocumentSnapshot characterSnapshot = await characterReference.get();
      if (characterSnapshot.exists) {
        return characterSnapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception("CHARACTER: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createCharacter(Map<String, dynamic> character) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('character')
            .doc(character["mode"])
            .collection(character["mode"])
            .doc(character["id"])
            .set(character);
        final DocumentReference userReference =
            _firestore.collection('user').doc(user.uid);
        final DocumentSnapshot userSnapshot = await userReference.get();

        if (userSnapshot.exists) {
          final Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          if (userData.containsKey(singleton.gameMode.value)) {
            final List<dynamic> characters = userData[singleton.gameMode.value];
            characters.add(character["id"]);
            await userReference.update({
              singleton.gameMode.value: characters, // Corregir la sintaxis aquí
            });
          } else {
            await userReference.update({
              singleton.gameMode.value: [character["id"]],
            });
          }
        } else {
          throw Exception("USER: Document does not exist");
        }
      } else {
        throw Exception("USER: User is null");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateCharacter(Map<String, dynamic> character) async {
    try {
      await _firestore
          .collection('character')
          .doc(character["mode"])
          .collection(character["mode"])
          .doc(character["id"])
          .update(character);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteCharacter(Map<String, dynamic> character) async {
    try {
      await _firestore
          .collection('character')
          .doc(character["mode"])
          .collection(character["mode"])
          .doc(character["id"])
          .delete();
      final DocumentReference userReference =
          _firestore.collection("user").doc(singleton.user!.uid);
      // String list = "";
      // if (character["mode"] == "Aliens") {
      //   list = "aliensCharacters";
      // } else if (character["mode"] == "Dyd") {
      //   list = "dydCharacters";
      // } else if (character["mode"] == "Cthulhu") {
      //   list = "cthulhuCharacters";
      // }
      // ----
      final DocumentSnapshot userSnapshot = await userReference.get();

      if (userSnapshot.exists) {
        // Obtener la lista actual
        List<dynamic> currentList = userSnapshot.get(character["mode"]);

        // Eliminar el elemento de la lista en memoria
        currentList.remove(character["id"]);

        // Actualizar el documento en Firestore con la lista modificada
        await userReference.update({
          character["mode"]: currentList,
        });
      } else {
        print('El documento con ID no existe.');
      }

      // ----
      // final DocumentSnapshot userSnapshot = await userReference.get();
      // final Map<String, dynamic>? userData =
      //     userSnapshot.data() as Map<String, dynamic>?;
      // final List<String> characterIds = List<String>.from(
      //   userData?[character["mode"]] ?? [],
      // );
      // characterIds.remove(character["id"]);
      // await userReference.update({characterIds} as Map<Object, Object?>);
      print("Character deleted successfully");
    } catch (error) {
      print("Error deleting character: $error");
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
        if (userData.containsKey(singleton.gameMode.value)) {
          final List<dynamic> characterIds = userData[singleton.gameMode.value];
          // Create a map to store character data
          Map<String, dynamic> charactersData = {};

          // Iterate over character IDs
          for (String characterId in characterIds) {
            // Retrieve the character document
            final DocumentReference characterReference = _firestore
                .collection("character")
                .doc(singleton.gameMode.value)
                .collection(singleton.gameMode.value)
                .doc(characterId);
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

  Future<Map<String, dynamic>> getUserCharactersFromMode(
      String userId, String mode) async {
    try {
      final DocumentReference userReference =
          _firestore.collection("user").doc(userId);
      final DocumentSnapshot userSnapshot = await userReference.get();
      if (userSnapshot.exists) {
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        if (userData.containsKey(mode)) {
          final List<dynamic> characterIds = userData[mode];
          // Create a map to store character data
          Map<String, dynamic> charactersData = {};

          // Iterate over character IDs
          for (String characterId in characterIds) {
            // Retrieve the character document
            final DocumentReference characterReference = _firestore
                .collection("character")
                .doc(mode)
                .collection(mode)
                .doc(characterId);
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

  Future<List<dynamic>> getUserCharactersIdFromMode(
      String userId, String mode) async {
    try {
      final DocumentReference userReference =
          _firestore.collection("user").doc(userId);
      final DocumentSnapshot userSnapshot = await userReference.get();
      if (userSnapshot.exists) {
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        if (userData.containsKey(mode)) {
          return userData[mode];
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

  Stream<QuerySnapshot<Object?>> fetchCharactersByMode(String mode) async* {
    print("get characters from mode");
    // get the characters from the database
    yield* _firestore
        .collection('character')
        .doc(mode)
        .collection(mode)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getCharactersStreamFromGameId(
      String gameId) {
    try {
      final DocumentReference gameReference =
          _firestore.collection("game").doc(gameId);

      return gameReference.snapshots().asyncMap((gameSnapshot) async {
        if (gameSnapshot.exists) {
          final Map<String, dynamic> gameData =
              gameSnapshot.data() as Map<String, dynamic>;

          if (gameData.containsKey("players")) {
            final playerIds = gameData["players"];
            Map<String, dynamic> players_ready = gameData["ready_players"];
            List<Map<String, dynamic>> charactersData = [];

            for (int i = 0; i < playerIds.values.length; i++) {
              PlayerGameData playerGameData =
                  PlayerGameData.fromMap(playerIds.values.elementAt(i));

              final DocumentReference characterReference = _firestore
                  .collection('character')
                  .doc(singleton.gameMode.value)
                  .collection(singleton.gameMode.value)
                  .doc(playerGameData.characterId);

              final DocumentSnapshot characterSnapshot =
                  await characterReference.get();

              if (characterSnapshot.exists) {
                final Map<String, dynamic> characterData =
                    characterSnapshot.data() as Map<String, dynamic>;
                characterData["ready"] =
                    players_ready[playerIds.keys.elementAt(i)];
                charactersData.add(characterData);
              } else {
                print("CHARACTER: Document does not exist for player ID: " +
                    playerGameData.characterId);
              }
            }
            return charactersData;
          } else {
            throw Exception("GAME: Attribute 'players' does not exist");
          }
        } else {
          throw Exception("GAME: Document does not exist");
        }
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getCharactersFromGameId(
      String gameId) async {
    try {
      final DocumentReference gameReference =
          _firestore.collection("game").doc(gameId);
      final DocumentSnapshot gameSnapshot = await gameReference.get();
      if (gameSnapshot.exists) {
        final Map<String, dynamic> gameData =
            gameSnapshot.data() as Map<String, dynamic>;

        if (gameData.containsKey("players")) {
          print("test");
          final playerIds = gameData["players"];
          List<Map<String, dynamic>> charactersData = [];
          for (int i = 0; i < playerIds.values.length; i++) {
            PlayerGameData playerGameData =
                PlayerGameData.fromMap(playerIds.values.elementAt(i));
            print(playerGameData);
            final DocumentReference characterReference = _firestore
                .collection('character')
                .doc(singleton.gameMode.value)
                .collection(singleton.gameMode.value)
                .doc(playerGameData.characterId);
            final DocumentSnapshot characterSnapshot =
                await characterReference.get();
            if (characterSnapshot.exists) {
              final Map<String, dynamic> characterData =
                  characterSnapshot.data() as Map<String, dynamic>;
              charactersData.add(characterData);
            } else {
              // Handle the case where a character document does not exist
              print("CHARACTER: Document does not exist for player ID: " +
                  playerGameData.characterId);
            }
          }
          // final List<String> characterIdsList =
          //     List<String>.from(playerIds.values);
          // print(characterIdsList);

          return charactersData;
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

  // Future<void> getAliensCharactersFromUserId(String userId) async {
  //   List<AliensCharacter> characters = [];

  //   try {
  //     CollectionReference charactersCollection =
  //         FirebaseFirestore.instance.collection('characters');

  //     QuerySnapshot querySnapshot =
  //         await charactersCollection.where('userId', isEqualTo: userId).get();

  //     querySnapshot.docs.forEach((DocumentSnapshot document) {
  //       Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  //       if (data.containsKey('aliensCharacters')) {
  //         List<dynamic> charactersList = data['aliensCharacters'];

  //         charactersList.forEach((characterData) {
  //           AliensCharacter character = AliensCharacter.fromMap(characterData);
  //           characters.add(character);
  //         });
  //       }
  //     });
  //   } catch (e) {
  //     print("Error fetching characters: $e");
  //   }
  // }

  // Future<void> getDydCharactersFromUserId(String userId) async {
  //   List<DydCharacter> characters = [];

  //   try {
  //     CollectionReference charactersCollection =
  //         FirebaseFirestore.instance.collection('characters');

  //     QuerySnapshot querySnapshot =
  //         await charactersCollection.where('userId', isEqualTo: userId).get();

  //     querySnapshot.docs.forEach((DocumentSnapshot document) {
  //       Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  //       if (data.containsKey('dydCharacters')) {
  //         List<dynamic> charactersList = data['dydCharacters'];

  //         charactersList.forEach((characterData) {
  //           DydCharacter character = DydCharacter.fromMap(characterData);
  //           characters.add(character);
  //         });
  //       }
  //     });
  //   } catch (e) {
  //     print("Error fetching characters: $e");
  //   }
  // }

  // Future<void> getCthulhuCharactersFromUserId(String userId) async {
  //   List<CthulhuCharacter> characters = [];

  //   try {
  //     CollectionReference charactersCollection =
  //         FirebaseFirestore.instance.collection('characters');

  //     QuerySnapshot querySnapshot =
  //         await charactersCollection.where('userId', isEqualTo: userId).get();

  //     querySnapshot.docs.forEach((DocumentSnapshot document) {
  //       Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  //       if (data.containsKey('cthulhuCharacters')) {
  //         List<dynamic> charactersList = data['cthulhuCharacters'];

  //         charactersList.forEach((characterData) {
  //           CthulhuCharacter character =
  //               CthulhuCharacter.fromMap(characterData);
  //           characters.add(character);
  //         });
  //       }
  //     });
  //   } catch (e) {
  //     print("Error fetching characters: $e");
  //   }
  // }

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

  Future<Map<String, dynamic>> getGame(String gameId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection('game').doc(gameId).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception("GAME: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }

// TODO I have changed this
  Future<void> createGame(Map<String, dynamic> gameConfig) async {
    try {
      print(gameConfig);
      await _firestore
          .collection('game')
          .doc(gameConfig['uid'])
          .set(gameConfig);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> isGameReady(String gameId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection('game').doc(gameId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData =
            documentSnapshot.data() as Map<String, dynamic>;
        return gameData['game_ready'];
      } else {
        throw Exception("GAME: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setGameReady(String gameId) async {
    try {
      CollectionReference gamesCollection =
          FirebaseFirestore.instance.collection('game');
      // Get a reference to the specific game document
      DocumentReference gameRef = gamesCollection.doc(gameId);

      // Use a transaction to ensure atomic updates
      await FirebaseFirestore.instance.runTransaction((Transaction tx) async {
        // Get the current game data
        DocumentSnapshot<Map<String, dynamic>> gameSnapshot =
            await tx.get(gameRef) as DocumentSnapshot<Map<String, dynamic>>;
        if (gameSnapshot.exists) {
          // Modify the game data
          Map<String, dynamic> gameData = gameSnapshot.data()!;
          gameData['game_ready'] = true;

          tx.update(gameRef, gameData);
        }
      });
    } catch (error) {
      print('Error modifying the game: $error');
      throw error;
    }
  }


  Future<bool> allPlayersReady(String gameId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection('game').doc(gameId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData =
            documentSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> readyPlayers = gameData['ready_players'];
        for (var value in readyPlayers.values) {
          if (value == false) {
            return false;
          }
        }
        return true;
      } else {
        throw Exception("GAME: Document does not exist");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> gamePlayerReady(String gameId) async {
    try {
      CollectionReference gamesCollection =
          FirebaseFirestore.instance.collection('game');
      // Get a reference to the specific game document
      DocumentReference gameRef = gamesCollection.doc(gameId);

      // Use a transaction to ensure atomic updates
      await FirebaseFirestore.instance.runTransaction((Transaction tx) async {
        // Get the current game data
        DocumentSnapshot<Map<String, dynamic>> gameSnapshot =
            await tx.get(gameRef) as DocumentSnapshot<Map<String, dynamic>>;
        if (gameSnapshot.exists) {
          // Modify the game data
          Map<String, dynamic> gameData = gameSnapshot.data()!;
          gameData['ready_players'][singleton.player!.uid] = true;

          tx.update(gameRef, gameData);
        }
      });
    } catch (error) {
      print('Error modifying the game: $error');
      throw error;
    }
  }

  // Function to modify the game by updating num_players and adding a player
  Future<void> modifyGame(String gameId, String characterId) async {
    try {
      CollectionReference gamesCollection =
          FirebaseFirestore.instance.collection('game');
      // Get a reference to the specific game document
      DocumentReference gameRef = gamesCollection.doc(gameId);

      // Use a transaction to ensure atomic updates
      await FirebaseFirestore.instance.runTransaction((Transaction tx) async {
        // Get the current game data
        DocumentSnapshot<Map<String, dynamic>> gameSnapshot =
            await tx.get(gameRef) as DocumentSnapshot<Map<String, dynamic>>;
        if (gameSnapshot.exists) {
          // Modify the game data
          Map<String, dynamic> gameData = gameSnapshot.data()!;
          PlayerGameData playerGameData =
              PlayerGameData(characterId: characterId);
          // Add the current characterId to the list of players
          Map<String, dynamic> players =
              Map<String, dynamic>.from(gameData['players'] ?? []);
          Map<String, dynamic> players_ready =
              Map<String, dynamic>.from(gameData['ready_players'] ?? []);
          players[singleton.player!.uid] = playerGameData.toMap();
          players_ready[singleton.player!.uid] = false;
          gameData['players'] = players;
          gameData['num_players'] = players.length;
          gameData['ready_players'] = players_ready;

          tx.update(gameRef, gameData);
        }
      });
    } catch (error) {
      print('Error modifying the game: $error');
      throw error;
    }
  }

  // Function to get the game data from the Firestore collection 'game' by user ID

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

  Future<void> emptyQueue() async {
    try {
      CollectionReference queueCollection =
          FirebaseFirestore.instance.collection('queue');
      WriteBatch batch = FirebaseFirestore.instance.batch();
      QuerySnapshot snapshot = await queueCollection.get();

      // Delete each document in the 'queue' collection
      snapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      // Commit the batched write
      await batch.commit();
    } catch (error) {
      print('Error emptying the queue: $error');
      throw error;
    }
  }

  // Function to get the length of the queue
  Future<int> getQueueLength() async {
    try {
      // Reference to the Firestore collection 'queue'
      CollectionReference queueCollection =
          FirebaseFirestore.instance.collection('queue');
      // Fetch the documents from the 'queue' collection
      QuerySnapshot snapshot = await queueCollection.get();

      // Return the count of documents in the 'queue' collection
      return snapshot.size;
    } catch (error) {
      print('Error getting queue length: $error');
      throw error;
    }
  }

  Future<void> addUserToQueue(String characterId) async {
    try {
      // Get the current user ID
      String userId = singleton.user!.uid;

      // Reference to the Firestore collection 'queue'
      CollectionReference queueCollection =
          FirebaseFirestore.instance.collection('queue');

      // Add a new document to the 'queue' collection
      await queueCollection.add({
        'userId': userId,
        'characterId': characterId,
        'timestamp': FieldValue.serverTimestamp(),
        'ready': false,
      });

      print('User added to the queue successfully.');
    } catch (error) {
      print('Error adding user to the queue: $error');
      rethrow;
    }
  }

  // Function to add the game id to the queue
  Future<void> addGameToQueue(String characterId) async {
    try {
      // Reference to the Firestore collection 'queue'
      CollectionReference queueCollection =
          FirebaseFirestore.instance.collection('queue');

      // Get the current user ID
      String userId = singleton.user!.uid;

      // Check if the user already has a document in the 'queue' collection
      QuerySnapshot<Map<String, dynamic>> existingUserDocs =
          await queueCollection
              .where('userId', isEqualTo: userId)
              .limit(1)
              .get() as QuerySnapshot<Map<String, dynamic>>;

      if (existingUserDocs.docs.isNotEmpty) {
        // User already exists in the 'queue', update the existing document
        DocumentReference<Map<String, dynamic>> existingUserDoc =
            existingUserDocs.docs.first.reference;

        await existingUserDoc.update({
          'gameId': singleton.currentGame,
        });
      } else {
        // User doesn't exist in the 'queue', add a new document
        await queueCollection.add({
          'userId': userId,
          'characterId': characterId,
          'timestamp': FieldValue.serverTimestamp(),
          'gameId': singleton.currentGame,
        });
      }

      print('User added to the queue successfully.');
    } catch (error) {
      print('Error adding user to the queue: $error');
      rethrow;
    }
  }

  Future<String> getGameIdFromQueue() async {
    try {
      // Reference to the Firestore collection 'queue'
      CollectionReference queueCollection =
          FirebaseFirestore.instance.collection('queue');
      // Query to get the first document ordered by timestamp
      QuerySnapshot snapshot =
          await queueCollection.orderBy('timestamp').limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        // Get the first document
        Map<String, dynamic> firstDocument =
            snapshot.docs.first.data() as Map<String, dynamic>;

        // Check if 'gameId' field exists in the first document
        if (firstDocument.containsKey('gameId')) {
          // Retrieve the 'gameId' attribute from the first document
          String gameId = firstDocument['gameId'];
          // Return the 'gameId' attribute
          return gameId;
        } else {
          return '';
        }
      }
      // Return null if there are no documents in the 'queue' collection
      throw Exception("Queue not found");
    } catch (error) {
      print('Error getting current game Id: $error');
      throw error;
    }
  }

  Future<void> addReadyToQueue() async {
    try {
      // Reference to the Firestore collection 'queue'
      CollectionReference queueCollection =
          FirebaseFirestore.instance.collection('queue');

      // Get the current user ID
      String userId = singleton.user!.uid;

      // Check if the user already has a document in the 'queue' collection
      QuerySnapshot<Map<String, dynamic>> existingUserDocs =
          await queueCollection.orderBy('timestamp').limit(1).get()
              as QuerySnapshot<Map<String, dynamic>>;

      if (existingUserDocs.docs.isNotEmpty) {
        // User already exists in the 'queue', update the existing document
        DocumentReference<Map<String, dynamic>> existingUserDoc =
            existingUserDocs.docs.first.reference;

        await existingUserDoc.update({
          'ready': true,
        });
      } else {
        // User doesn't exist in the 'queue', add a new document
        throw Exception("User not found");
      }
    } catch (error) {
      print('Error adding user to the queue: $error');
      rethrow;
    }
  }

  Future<bool> checkIfReady() async {
    try {
      // Reference to the Firestore collection 'queue'
      CollectionReference queueCollection =
          FirebaseFirestore.instance.collection('queue');
      // Query to get the first document ordered by timestamp
      QuerySnapshot snapshot =
          await queueCollection.orderBy('timestamp').limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        // Get the first document
        Map<String, dynamic> firstDocument =
            snapshot.docs.first.data() as Map<String, dynamic>;

        // Check if 'gameId' field exists in the first document
        if (firstDocument.containsKey('ready')) {
          // Retrieve the 'gameId' attribute from the first document
          bool ready = firstDocument['ready'];
          // Return the 'gameId' attribute
          return ready;
        } else {
          return false;
        }
      }
      // Return null if there are no documents in the 'queue' collection
      throw Exception("Queue not found");
    } catch (error) {
      print('Error getting current game Id: $error');
      throw error;
    }
  }

  Future<void> saveUser(Player player) async {
    try {
      _firestore.collection('user').doc(player.uid).set(player.toMap());
      // TODO error contorl if user cannot be created
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchPlayerData(BuildContext context) async {
    DocumentSnapshot<Map<String, dynamic>> playerDocument =
        await _firestore.collection('user').doc(singleton.user?.uid).get();

    Player player = Player.fromDocument(playerDocument);
    singleton.player = player;
    context.go("/");
    context.push("/");
  }

  Future<void> saveMessage(ChatMessages message, String currentGameId) async {
    if (message.text.trim().isNotEmpty) {
      // String sender;
      // if (message.sentBy == "IA") {
      //   sender = 'IA';
      // } else {
      //   sender = await getUsername(message.sentBy);
      // }

      // Map<String, dynamic> messageData = {
      //   'text': message.text,
      //   'sentAt': message.sentAt,
      //   'sentBy': message.sentBy,
      //   'senderName': sender,
      // };

      try {
        await _firestore
            .collection('message')
            .doc(currentGameId)
            .collection('messages')
            .add(message.toMap());
      } catch (error) {
        print('Error saving message: $error');
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
          // final senderName = data['senderName'] as String;
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

  Future<String> getUsername(String userId) async {
    try {
      print(userId);
      // Reference to the Firestore collection 'users' (adjust to your collection name)
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('user');

      // Query to get the user document by user ID
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

      if (userSnapshot.exists) {
        // If a user document is found, return the username
        return userSnapshot.get('username');
      } else {
        // If no user document is found, return an appropriate value (null or an empty string, for example)
        throw Exception("User not found");
      }
    } catch (error) {
      print('Error getting username: $error');
      throw error;
    }
  }

  Future<List<String>> getUsernames(
      List<QueryDocumentSnapshot<Object?>> messages) async {
    List<String> usernames = [];
    for (var message in messages) {
      String userId = message.get('sentBy');
      String username = await firebase.getUsername(userId);
      usernames.add(username);
    }
    return usernames;
  }

  Future<bool?> signIn(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      singleton.user = credential.user;
      firebase.fetchPlayerData(context);
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

  Future<List<Game>> fetchGamesByUserId(String userId) async {
    List<Game> games = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('game') // replace with your collection name
          .where('users', arrayContains: userId)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Assuming 'name' is the field containing game information
        Game game = Game.fromMap(document.data() as Map<String, dynamic>);
        games.add(game);
      }
    } catch (e) {
      print('Error fetching games: $e');
    }

    return games;
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
