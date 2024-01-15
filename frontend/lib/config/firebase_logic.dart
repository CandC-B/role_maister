import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/constants.dart';
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
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
          if (userData.containsKey(character["mode"])) {
            final List<dynamic> characters = userData[character["mode"]];
            characters.add(character["id"]);
            await userReference.update({
              character["mode"]: characters, // Corregir la sintaxis aquí
            });
          } else {
            await userReference.update({
              character["mode"]: [character["id"]],
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

  // Unused function
  Future<Map<String, dynamic>> getPlayersDataFromGameId(String gameId) async {
    try {
      // Get the document reference
      final DocumentReference gameReference =
          _firestore.collection("game").doc(gameId);

      // Get the document snapshot
      final DocumentSnapshot gameSnapshot = await gameReference.get();

      // Check if the document exists
      if (gameSnapshot.exists) {
        final Map<String, dynamic> gameData =
            gameSnapshot.data() as Map<String, dynamic>;
        // Extract the "players" field as a Map<String, dynamic>
        Map<String, dynamic> players = gameData['players'];

        // Use the players map as needed
        return players;
      } else {
        // Document doesn't exist
        throw Exception(
            "Waiting Room: Document with ID $gameId does not exist.");
      }
    } catch (e) {
      // Handle errors
      throw Exception("Waiting Room: Error fetching players data: $e");
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

  Stream<List<Map<String, dynamic>>> getCharactersStreamFromGameIdCard(
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
                characterData['votedToGetKickedBy'] = playerGameData.votedToGetKickedBy;
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

  Future<void> createGame(Map<String, dynamic> gameConfig) async {
    try {
      await _firestore
          .collection('game')
          .doc(gameConfig['uid'])
          .set(gameConfig);
    } catch (error) {
      rethrow;
    }
  }

  // Function to get game data from the Firestore collection 'game' by game short_uid
  Future<String> getGameUidByShortUid(String shortUid) async {
    try {
      // Reference to the Firestore collection 'game'
      CollectionReference gamesCollection =
          FirebaseFirestore.instance.collection('game');

      // Query to get the game document by short_uid
      QuerySnapshot<Map<String, dynamic>> gameSnapshot = await gamesCollection
          .where('short_uid', isEqualTo: shortUid)
          .limit(1)
          .get() as QuerySnapshot<Map<String, dynamic>>;

      if (gameSnapshot.docs.isNotEmpty) {
        // Get the first document
        Map<String, dynamic> gameData =
            gameSnapshot.docs.first.data() as Map<String, dynamic>;

        // Return the game data
        return gameData['uid'];
      } else {
        // Return null if there are no documents in the 'game' collection
        throw Exception("GAME: Document does not exist");
      }
    } catch (error) {
      print('Error getting game data: $error');
      throw error;
    }
  }

  // Function to get the short_uid of the game
  Future<String> getGameShortUid(String gameId) async {
    try {
      // Reference to the Firestore collection 'game'
      CollectionReference gamesCollection =
          FirebaseFirestore.instance.collection('game');

      // Query to get the game document by short_uid
      QuerySnapshot<Map<String, dynamic>> gameSnapshot = await gamesCollection
          .where('uid', isEqualTo: gameId)
          .limit(1)
          .get() as QuerySnapshot<Map<String, dynamic>>;

      if (gameSnapshot.docs.isNotEmpty) {
        // Get the first document
        Map<String, dynamic> gameData =
            gameSnapshot.docs.first.data() as Map<String, dynamic>;

        // Return the game data
        return gameData['short_uid'];
      } else {
        // Return null if there are no documents in the 'game' collection
        throw Exception("GAME: Document does not exist");
      }
    } catch (error) {
      print('Error getting game data: $error');
      throw error;
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

  Future<void> changePlayerBalance(String playerUid, double tokenChange) async {
    try {
      // Reference to the Firestore collection 'user'
      CollectionReference usersCollection = _firestore.collection('user');

      // Get the user document by user ID
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await usersCollection.doc(playerUid).get()
              as DocumentSnapshot<Map<String, dynamic>>;
      if (userSnapshot.exists) {
        // Modify the user data
        Map<String, dynamic> userData = userSnapshot.data()!;
        userData['tokens'] += tokenChange;
        print(userData);

        // Update the user document
        await usersCollection.doc(playerUid).update(userData);
        singleton.player = Player.fromMap(userData);
      } else {
        throw Exception("User not found");
      }
    } catch (error) {
      print('Error updating user profile picture: $error');
      throw error;
    }
  }

  Future<void> saveMessage(ChatMessages message, String currentGameId) async {
    if (message.text.trim().isNotEmpty) {
      try {

        print('CURRENT GAME ID: $currentGameId');
        print('MESSAGE ID: ${message.id}');

        await _firestore
            .collection('message')
            .doc(currentGameId)
            .collection('messages')
            .doc(message.id)
            // .add(message.toMap());
            .set(message.toMap());

        if (message.sentBy != 'System'){
          await updatePlayersTurn(currentGameId, false);
        }
          
      } catch (error) {
        print('Error saving message: $error');
        rethrow;
      }
    }
  }

  Future<void> deleteMessage(String currentGameId, String messageId) async {
    try {
      await _firestore
          .collection('message')
          .doc(currentGameId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (error) {
      print('Error deleting message: $error');
      rethrow;
    }
  }

  Stream<DocumentSnapshot> observePlayersTurn(String gameId) {
    return _firestore.collection('game').doc(gameId).snapshots();
  }

  Future<void> updatePlayersTurn(String gameId, bool isDeletedPlayer) async {
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
          Map<String, dynamic> gameData = gameSnapshot.data()!;
          String nextPlayerId = gameData['nextPlayersTurn'];
          int nextPlayerIndex = gameData['nextPlayersTurnIndex'];
          Map<String, dynamic> players =
              Map<String, dynamic>.from(gameData['players'] ?? []);


          // print('TURNO DEL PLAYER ANTERIOR: $nextPlayerId');
          // print('TURNO DEL PLAYER ANTERIOR INDEX: $nextPlayerIndex');
          // print('PLAYERS LENGTH: ${players.length}');
          // print('MY ID: ${singleton.user!.uid}');
          // print('DELETED PLAYER: $isDeletedPlayer');
          List<String> orderedKeys =  players.keys.toList()..sort();
          // print("ORDERED KEYS: $orderedKeys");

          if (nextPlayerId == 'IA' || (isDeletedPlayer /*&& nextPlayerId != singleton.user!.uid*/)) {
            nextPlayerIndex = (nextPlayerIndex + 1) % players.length;
            nextPlayerId = orderedKeys[nextPlayerIndex];
          } else {
            nextPlayerIndex = nextPlayerIndex;
            nextPlayerId = 'IA';
          }

          // print('TURNO DEL PLAYER SIGUIENTE: $nextPlayerId');
          // print('TURNO DEL PLAYER SIGUIENTE INDEX: $nextPlayerIndex');

          gameData['nextPlayersTurn'] = nextPlayerId;
          gameData['nextPlayersTurnIndex'] = nextPlayerIndex;


          tx.update(gameRef, gameData);
        }
      });
    } catch (error) {
      print('Error modifying the game: $error in updatePlayersTurn');
      throw error;
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

  Future<String> getUserImageFromUserId(String userId) async {
    try {
      print(userId);
      // Reference to the Firestore collection 'users' (adjust to your collection name)
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('user');

      // Query to get the user document by user ID
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

      if (userSnapshot.exists) {
        // If a user document is found, return the username
        return userSnapshot.get('photoUrl');
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

  // modificar valor del campo votedToGetKicked dentro del player que se le pase
  Future<void> saveKickVote(String gameId, String playerId) async {
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
          Map<String, dynamic> gameData = gameSnapshot.data()!;
          Map<String, dynamic> players =
              Map<String, dynamic>.from(gameData['players'] ?? []);
          var player = players[playerId];
          PlayerGameData playerGameData = PlayerGameData.fromMap(player);
          playerGameData.votedToGetKicked += 1;
          playerGameData.votedToGetKickedBy.add(singleton.user!.uid);
          players[playerId] = playerGameData.toMap();
          gameData['players'] = players;

          tx.update(gameRef, gameData);
        }
      });
    } catch (error) {
      print('Error modifying the game: $error in saveKickVote');
      throw error;
    }
  }

  void observeAndHandleGameChanges(
      String gameId, String currentUserUid, BuildContext context) {
    _firestore.collection('game').doc(gameId).snapshots().listen((event) async {
      if (event.exists) {
        final data = event.data() as Map<String, dynamic>?;
        if (data != null) {
          // check if currentUserUid is in the players list
          if (data['players'].containsKey(currentUserUid)) {
            // check if the player has voted to kick
            PlayerGameData playerGameData =
                PlayerGameData.fromMap(data['players'][currentUserUid]);

            Game game = Game.fromMap(data);
            print('GAME DATA: ' + game.toString());
            print('PLAYER ID: ' + currentUserUid);
            print('PLAYER DATA: ' +
                playerGameData.characterId +
                ' ' +
                playerGameData.votedToGetKicked.toString());

            if (data['players'].length != 1 &&
                playerGameData.votedToGetKicked >= data['players'].length - 1) {
              // kick the player
              print('A TOMAR POR CULO!!');
              print('GAME ID: ' + gameId);
              // context.widget.test = "A TOMAR POR CULO!!";
              // _GamePlayersState state = context.findAncestorStateOfType<_GamePlayersState>()!;

              deleteKickedPlayer(gameId, currentUserUid);

              print('PLAYER DELETED IN GAME: ' + gameId);

              await updatePlayersTurn(gameId, true);
              context.push("/");
              // singleton.currentGame = "";
            }
          }
        }
      }
    });
  }

  Future<void> kickPlayerFromWaitingRoom(String gameId, String playerId) async {
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
          print("HERE");
          Map<String, dynamic> gameData = gameSnapshot.data()!;
          Map<String, dynamic> players =
              Map<String, dynamic>.from(gameData['players'] ?? []);
          var player = players[playerId];
          PlayerGameData playerGameData = PlayerGameData.fromMap(player);
          playerGameData.isKickedFromWaitingRoom = true;
          players[playerId] = playerGameData.toMap();
          gameData['players'] = players;

          tx.update(gameRef, gameData);
        }
      });
    } catch (error) {
      print('Error modifying the game: $error in kickPlayerFromWaitingRoom');
      throw error;
    }
  }

  Future<void> deleteKickedPlayer(String gameId, String playerId) async {

    print('ENTRAMOS EN DELETE KICKED PLAYER');
    print('GAME ID: ' + gameId);
    print('KICKED PLAYER ID: ' + playerId);

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
          Map<String, dynamic> gameData = gameSnapshot.data()!;
          Map<String, dynamic> players =
              Map<String, dynamic>.from(gameData['players'] ?? []);
          players.remove(playerId);
          gameData['players'] = players;

          tx.update(gameRef, gameData);
        }
      });
    } catch (error) {
      print('Error modifying the game: $error in delete kicked player');
      throw error;
    }
  }

  Stream<double> getCurrentPlayerTokens() {
    return _firestore
        .collection('user')
        .doc(singleton.user!.uid)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;
        return double.parse((userData['tokens']).toStringAsFixed(2));
      } else {
        throw Exception("USER: Document does not exist");
      }
    });
  }

  Future<void> updatePlayerWordCount(
      String gameUid, String playerUid, int wordIncrement) async {
    try {
      // Reference to the game document
      DocumentReference<Map<String, dynamic>> gameReference =
          _firestore.collection('game').doc(gameUid);

      // Get the current game document
      DocumentSnapshot<Map<String, dynamic>> gameDocument =
          await gameReference.get();

      if (gameDocument.exists) {
        // Retrieve the current players map from the document
        Map<String, dynamic> players = gameDocument.data()?['players'] ?? {};

        // Check if the playerUid exists in the players map
        if (players.containsKey(playerUid)) {
          // Update the player's data
          players[playerUid]['word_count'] +=
              wordIncrement; // Assuming toMap() method in PlayerGameData

          // Update the game document with the modified players map
          await gameReference.update({'players': players});
        } else {
          print('Player with UID $playerUid not found in the game.');
        }
      } else {
        print('Game with UID $gameUid not found.');
      }
    } catch (e) {
      print('Error updating player data: $e');
    }
  }

  Future<void> updateAiWordCount(String gameUid, int wordIncrement) async {
    try {
      // Reference to the game document
      DocumentReference<Map<String, dynamic>> gameReference =
          _firestore.collection('game').doc(gameUid);

      // Get the current game document
      DocumentSnapshot<Map<String, dynamic>> gameDocument =
          await gameReference.get();

      if (gameDocument.exists) {
        int aiWordCount = gameDocument.data()?['ia_word_count'] ?? 0;
        aiWordCount += wordIncrement;
        await gameReference.update({'ia_word_count': aiWordCount});
      } else {
        print('Game with UID $gameUid not found.');
      }
    } catch (e) {
      print('Error updating player data: $e');
    }
  }

  Stream<double> getUserSpendingStream(String gameUid, String playerUid) {
    return _firestore
        .collection('game')
        .doc(gameUid)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> gameData =
            documentSnapshot.data() as Map<String, dynamic>;

        // Retrieve the current players map from the document
        Map<String, dynamic> players = gameData['players'] ?? {};

        // Check if the playerUid exists in the players map
        if (players.containsKey(playerUid)) {
          int playerWordCount = players[playerUid]['word_count'];
          int aiWordCount = gameData['ia_word_count'] ?? 0;
          int numPlayers = gameData['num_players'] ?? 0;

          // Return the calculated spending value
          return getPlayerGamePrice(playerWordCount, aiWordCount, numPlayers);
        } else {
          throw Exception('Player with UID $playerUid not found in the game.');
        }
      } else {
        throw Exception('Game with UID $gameUid not found.');
      }
    });
  }

  Future<List<Game>> fetchGamesByUserId(String userId) async {
    List<Game> games = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('game') // replace with your collection name
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        if (data['players'].keys.contains(userId)) {
          Game game = Game.fromMap(document.data() as Map<String, dynamic>);
          games.add(game);
        }
      }
    } catch (e) {
      print('Error fetching games: $e');
    }

    return games;
  }

  // Update the user's profile picture
  Future<void> updateUserPlayedGames(String userId) async {
    try {
      // Reference to the Firestore collection 'user'
      CollectionReference usersCollection = _firestore.collection('user');

      // Get the user document by user ID
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await usersCollection.doc(userId).get()
              as DocumentSnapshot<Map<String, dynamic>>;
      if (userSnapshot.exists) {
        // Modify the user data
        Map<String, dynamic> userData = userSnapshot.data()!;
        userData['gamesPlayed'] += 1;

        // Update the user document
        await usersCollection.doc(userId).update(userData);
        singleton.player = Player.fromMap(userData);
      } else {
        throw Exception("User not found");
      }
    } catch (error) {
      print('Error updating user profile picture: $error');
      throw error;
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

  // Firebase storage
  Future<String> uploadFile(Uint8List file, String fileName) async {
    try {
      Reference storageReference = _storage.ref().child(fileName);
      UploadTask uploadTask = storageReference.putData(file);
      await uploadTask.whenComplete(() => print("File uploaded successfully"));
      String url = await storageReference.getDownloadURL();
      return url;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // Update the user's profile picture
  Future<bool> updateUserProfilePicture(String userId, String url) async {
    try {
      // Reference to the Firestore collection 'user'
      CollectionReference usersCollection = _firestore.collection('user');

      // Get the user document by user ID
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await usersCollection.doc(userId).get()
              as DocumentSnapshot<Map<String, dynamic>>;
      if (userSnapshot.exists) {
        // Modify the user data
        Map<String, dynamic> userData = userSnapshot.data()!;
        userData['photoUrl'] = url;

        // Update the user document
        await usersCollection.doc(userId).update(userData);
        singleton.player = Player.fromMap(userData);
        return true;
      } else {
        throw Exception("User not found");
      }
    } catch (error) {
      print('Error updating user profile picture: $error');
      throw error;
    }
  }
}
