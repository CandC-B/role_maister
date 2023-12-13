import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/cohere_logic.dart';
import 'package:role_maister/models/character.dart';
import 'package:role_maister/models/cohere_models.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/game.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/models/player_game_data.dart';
import 'package:role_maister/widgets/cthulhu_characters_card.dart';
import 'package:role_maister/widgets/dyd_characters_card.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectCharacterPageMobile extends StatefulWidget {
  const SelectCharacterPageMobile({super.key});

  @override
  State<SelectCharacterPageMobile> createState() =>
      _SelectCharacterPageMobileState();
}

class _SelectCharacterPageMobileState extends State<SelectCharacterPageMobile> {
  Map<String, dynamic>? charactersData = {};
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
      if (singleton.gameMode.value == "aliens") {
        AliensCharacter newRandomUser = AliensCharacter.random();
        newRandomUser.userId = singleton.user!.uid;
        await firebase.createCharacter(newRandomUser.toMap());
      } else if (singleton.gameMode.value == "dyd") {
        DydCharacter newRandomUser = DydCharacter.random();
        newRandomUser.userId = singleton.user!.uid;
        await firebase.createCharacter(newRandomUser.toMap());
      } else if (singleton.gameMode.value == "cthulhu") {
        CthulhuCharacter newRandomUser = CthulhuCharacter.random();
        newRandomUser.userId = singleton.user!.uid;
        await firebase.createCharacter(newRandomUser.toMap());
      } else {
        AliensCharacter newRandomUser = AliensCharacter.random();
        newRandomUser.userId = singleton.user!.uid;
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
              Text(
                AppLocalizations.of(context)!.random_character,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> createNewGame(String characterId) async {
    Map<String, dynamic> game_players = {singleton.player!.uid: PlayerGameData(characterId: characterId).toMap()};
    Game newGame = Game(
      num_players: 1,
      role_system: singleton.gameMode.value,
      players: game_players,
      story_description: singleton.history,
    );
    singleton.currentGame = newGame.uid;
    await firebase.createGame(newGame.toMap());

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String response;
    if (singleton.gameMode.value == "aliens") {
      response = await createGame(newGame);
    } else {
      throw Exception("Tonto el que lo lea");
    }
    var coralMessage = response;
    // await firebase.saveMessage(coralMessage, DateTime.now(), newGame.uid, "IA");
    await firebase.saveMessage(
      ChatMessages(
          sentBy: "IA",
          sentAt: DateTime.now(),
          text: coralMessage,
          characterName: "",
          senderName: "IA"),
      newGame.uid,
    );
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
                AppLocalizations.of(context)!.creating_game,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
      barrierDismissible: false,
    );

    int queueLen = await firebase.getQueueLength();
    // TODO: para partidas con más jugadores lo único que hará falta
    // distingir el primer jugador y el último del resto
    // primero --> crea el game en firebase
    // medio --> añade su id al juego
    // último --> añade su id y llama a Coral
    // TODO: esto no escala a multiples partidas a la vez (se necesiaría una cola por partida multi)
    if (queueLen == 0) {
      // First user to enter the queue
      await firebase.addUserToQueue(characterId);
      Map<String, dynamic> game_players = {singleton.player!.uid: PlayerGameData(characterId: characterId).toMap()};
      Game newGame = Game(
        num_players: 1,
        role_system: singleton.gameMode.value,
        players: game_players,
        story_description: singleton.history,
      );
      singleton.currentGame = newGame.uid;
      await firebase.createGame(newGame.toMap());
      await firebase.addGameToQueue(characterId);
      while (!await firebase.checkIfReady()) {
        print("Waiting...");
        await Future.delayed(const Duration(seconds: 1));
      }
      print('Empty queue');
      await firebase.emptyQueue();
      // ignore: use_build_context_synchronously
      context.go("/game");
    } else {
      // Second user to enter the queue
      await firebase.addUserToQueue(characterId);
      String gameId = '';
      do {
        // Keep calling getGameId() until it returns a non-empty string
        gameId = await firebase.getGameIdFromQueue();
        await Future.delayed(const Duration(seconds: 1));
      } while (gameId.isEmpty);

      singleton.currentGame = gameId;
      print(singleton.currentGame);
      await firebase.modifyGame(gameId, singleton.selectedCharacterId!);
      // Prompt Coral to start the game
      Game currentGame = Game.fromMap(await firebase.getGame(gameId));
      var coralMessage = await createGame(currentGame);
      // await firebase.saveMessage(
      //     coralMessage, DateTime.now(), singleton.currentGame!, "IA");
      await firebase.saveMessage(
        ChatMessages(
            sentBy: "IA",
            sentAt: DateTime.now(),
            text: coralMessage,
            characterName: "",
            senderName: "IA"),
        singleton.currentGame!,
      );

      print("LAST USER");
      await firebase.addReadyToQueue();

      // ignore: use_build_context_synchronously
      context.go("/game");
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
                AppLocalizations.of(context)!.creating_game,
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
          ? const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.png'),
                fit: BoxFit.cover,
              ),
            )
          : const BoxDecoration(color: Colors.black87),
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
                    decoration: const BoxDecoration(),
                    child: Card(
                      color: Colors.black,
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Colors.deepPurple,
                          width: 1,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.casino_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .random_character,
                                  style: const TextStyle(
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
                        side: const BorderSide(
                          color: Colors.deepPurple,
                          width: 1,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.start_game,
                                  style: const TextStyle(
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
                      return ListView.builder(
                        itemCount: charactersData!.length,
                        itemBuilder: (context, index) {
                          final characterId =
                              charactersData!.keys.elementAt(index);
                          final characterData = charactersData![characterId];

                          singleton.selectedCharacterId =
                              charactersData!.keys.elementAt(selectedIndex);

                          singleton.selectedCharacterName =
                              charactersData![singleton.selectedCharacterId]
                                  ?['name'];

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
                    } else if (snapshot.hasError) {
                      // Handle the error
                      return Text(
                          '${AppLocalizations.of(context)!.error_loading_character}${snapshot.error}');
                      // 'Error loading character data: ${snapshot.error}');
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

                          singleton.selectedCharacterName =
                              charactersData![singleton.selectedCharacterId]
                                  ?['name'];

                          if (singleton.gameMode.value == "aliens") {
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
                          } else if (singleton.gameMode.value == "dyd") {
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
                          } else if (singleton.gameMode.value == "cthulhu") {
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
