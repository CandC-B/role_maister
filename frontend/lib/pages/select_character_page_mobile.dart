import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/models/character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/cthulhu_characters_card.dart';
import 'package:role_maister/widgets/dyd_characters_card.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'dart:convert';

class SelectCharacterPageMobile extends StatefulWidget {
  const SelectCharacterPageMobile({super.key});

  @override
  State<SelectCharacterPageMobile> createState() =>
      _SelectCharacterPageMobileState();
}

class _SelectCharacterPageMobileState extends State<SelectCharacterPageMobile> {
  Map<String, dynamic>? charactersData;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadCharacterData();
  }

  Future<Map<String, dynamic>> loadCharacterData() async {
    try {
      final Map<String, dynamic> data =
          await firebase.getUserCharacters(singleton.user!.uid);
      return data;
    } catch (error) {
      throw Exception("Error al obtener personajes del usuario: $error");
    }
  }

  Future<void> createRandomPlayer() async {
    try {
      if (singleton.gameMode.value == "Aliens") {
        AliensCharacter newRandomUser = AliensCharacter.random();
        await firebase.createCharacter(newRandomUser.toMap());
      } else if (singleton.gameMode.value == "Dyd") {
        DydCharacter newRandomUser = DydCharacter.random();
        await firebase.createCharacter(newRandomUser.toMap());
      } else if (singleton.gameMode.value == "Cthulhu") {
        CthulhuCharacter newRandomUser = CthulhuCharacter.random();
        await firebase.createCharacter(newRandomUser.toMap());
      } else {
        AliensCharacter newRandomUser = AliensCharacter.random();
        await firebase.createCharacter(newRandomUser.toMap());
      }

      // Reload character data to update the UI
      Map<String, dynamic> data = await loadCharacterData();
      setState(() {
        charactersData = data;
      });
    } catch (error) {
      print("Error creating random player: $error");
    } finally {
      Navigator.of(context).pop();
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset('assets/images/small_logo.png'),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text("Creating random player...", style: TextStyle(color: Colors.white),),
            ],
          ),
        );
      },
    );
  }

  // TODO: pasar la historia
  Future<void> createNewGame(String characterId) async {
    Map<String, dynamic> mapUserStats = singleton.alienCharacter.toMap();
    if (singleton.gameMode.value == "Aliens") {
      Map<String, dynamic> mapUserStats = singleton.alienCharacter.toMap();
    } else if (singleton.gameMode.value == "Dyd") {
      Map<String, dynamic> mapUserStats = singleton.dydCharacter.toMap();
    } else if (singleton.gameMode.value == "Cthulhu") {
      Map<String, dynamic> mapUserStats = singleton.cthulhuCharacter.toMap();
    }
    mapUserStats["user"] = singleton.user!.uid;
    Map<String, dynamic> gameConfig = {
      "role_system": "aliens",
      "num_players": 1,
      "story_description": singleton.history,
      "players": [characterId]
    };
    String gameUid = await firebase.createGame(gameConfig);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    gameConfig.remove("players");
    mapUserStats.addAll(gameConfig);
    final response = await http.post(
        // TODO: add constants.dart in utils folder
        Uri.https("rolemaister.onrender.com", "/game/"),
        headers: headers,
        body: jsonEncode(mapUserStats));
    var coralMessage = json.decode(response.body)["message"];
    await firebase.saveMessage(coralMessage, DateTime.now(), gameUid, "IA");
    singleton.currentGame = gameUid;
  }

  void startMultiPlayerGame() async {
    print("START MULTI PLAYER GAME");
    final characterId = charactersData!.keys.elementAt(selectedIndex);
    final characterData = charactersData![characterId];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset('assets/images/small_logo.png'),
                  ),
                ),
              ),
              LinearProgressIndicator(
                color: Colors.amber,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 16),
              Text(
                "Creating Game...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
      barrierDismissible: false,
    );
    int queueLen = await firebase.getQueueLength();
    if (queueLen == 0) {
      await firebase.addUserToQueue(characterId);
      // TODO: no llamar a Coral
      await createNewGame(singleton.selectedCharacterId!);
      await firebase.addGameToQueue(characterId);
      while (await firebase.getQueueLength() < 2) {
        await Future.delayed(const Duration(seconds: 1));
      }
      // ignore: use_build_context_synchronously
      context.go("/game");
    } else {
      await firebase.addUserToQueue(characterId);
      while (await firebase.getQueueLength() < 2) {
        await Future.delayed(const Duration(seconds: 1));
      }
      String gameId = '';
      do {
        // Keep calling getGameId() until it returns a non-empty string
        gameId = await firebase.getGameId();
        await Future.delayed(const Duration(seconds: 1));
      } while (gameId.isEmpty);
      singleton.currentGame = gameId;
      print(singleton.currentGame);
      await firebase.modifyGame(gameId, singleton.selectedCharacterId!);
      // ignore: use_build_context_synchronously
      context.go("/game");
      await firebase.emptyQueue();
    }
  }

  void startSinglePlayerGame() async {
    print("START GAME");
    final characterId = charactersData!.keys.elementAt(selectedIndex);
    final characterData = charactersData![characterId];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset('assets/images/small_logo.png'),
                  ),
                ),
              ),
              LinearProgressIndicator(
                color: Colors.amber,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 16),
              Text(
                "Creating Game...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
      barrierDismissible: false,
    );
    createNewGame(singleton.selectedCharacterId!).then((value) {
      context.go("/game");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: !kIsWeb
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.png'),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(color: Colors.black87),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _showLoadingDialog();
                    createRandomPlayer();
                  },
                  child: Container(
                    height: 100.0, // Set a fixed height for the button
                    decoration: BoxDecoration(),
                    child: Card(
                      color: Colors.black,
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.deepPurple,
                          width: 1,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.casino_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Random Player",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    print("START GAME");
                    if (singleton.multiplayer) {
                      startMultiPlayerGame();
                    } else {
                      startSinglePlayerGame();
                    }
                  },
                  child: Container(
                    height: 100.0, // Set a fixed height for the button
                    child: Card(
                      color: Colors.black,
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.deepPurple,
                          width: 1,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Start Game",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // TODO: no reload when setstate index
          Expanded(
              child: ValueListenableBuilder<String>(
            valueListenable: singleton.gameMode,
            builder: (BuildContext context, String mode, child) {
              return FutureBuilder<Map<String, dynamic>>(
                  future: loadCharacterData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // You can show a loading indicator while loading the data
                      return Center(
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Image.asset('assets/images/small_logo.png'),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // Handle the error
                      return Text(
                          'Error loading character data: ${snapshot.error}');
                    } else {
                      charactersData = snapshot.data;
                      // Data loaded successfully, build the list
                      return ListView.builder(
                        itemCount: charactersData!.length,
                        itemBuilder: (context, index) {
                          final characterId =
                              charactersData!.keys.elementAt(index);
                          final characterData = charactersData![characterId];

                          singleton.selectedCharacterId =
                              charactersData!.keys.elementAt(selectedIndex);
                          if (singleton.gameMode.value == "Aliens") {
                            singleton.alienCharacter = AliensCharacter.fromMap(
                                charactersData![charactersData!.keys
                                    .elementAt(selectedIndex)]);
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: AliensCharacterCard(
                                character:
                                    AliensCharacter.fromMap(characterData),
                                selected: selectedIndex == index,
                              ),
                            );
                          } else if (singleton.gameMode.value == "Dyd") {
                            singleton.dydCharacter = DydCharacter.fromMap(
                                charactersData![charactersData!.keys
                                    .elementAt(selectedIndex)]);
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: DydCharacterCard(
                                character: DydCharacter.fromMap(characterData),
                                selected: selectedIndex == index,
                              ),
                            );
                          } else if (singleton.gameMode.value == "Cthulhu") {
                            singleton.cthulhuCharacter =
                                CthulhuCharacter.fromMap(charactersData![
                                    charactersData!.keys
                                        .elementAt(selectedIndex)]);
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: CthulhuCharacterCard(
                                character:
                                    CthulhuCharacter.fromMap(characterData),
                                selected: selectedIndex == index,
                              ),
                            );
                          } else {
                            singleton.alienCharacter = AliensCharacter.fromMap(
                                charactersData![charactersData!.keys
                                    .elementAt(selectedIndex)]);
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: AliensCharacterCard(
                                character:
                                    AliensCharacter.fromMap(characterData),
                                selected: selectedIndex == index,
                              ),
                            );
                          }
                        },
                      );
                    }
                  });
            },
          )),
        ],
      ),
    );
  }
}
