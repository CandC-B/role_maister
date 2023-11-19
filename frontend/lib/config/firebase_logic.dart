import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/player.dart';

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
          gameData['num_players'] = 2;

          // Add the current characterId to the list of players
          List<String> players = List<String>.from(gameData['players'] ?? []);
          players.add(characterId);
          gameData['players'] = players;

          // Update the game document
          tx.update(gameRef, gameData);
        }
      });
    } catch (error) {
      print('Error modifying the game: $error');
      throw error;
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
      });

      print('User added to the queue successfully.');
    } catch (error) {
      print('Error adding user to the queue: $error');
      rethrow;
    }
  }

  // Function to add a user to the 'queue' collection
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

  Future<String> getGameId() async {
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
