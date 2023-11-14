import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/models/models.dart';
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

  Future<void> loadCharacterData() async {
    try {
      final Map<String, dynamic> data =
          await firebase.getUserCharacters(singleton.user!.uid);
      setState(() {
        charactersData = data;
      });
    } catch (error) {
      print("Error loading character data: $error");
    }
  }

  Future<void> createRandomPlayer() async {
    try {
      UserStatistics newRandomUser = UserStatistics.random();
      await firebase.createCharacter(newRandomUser.toMap());

      // Reload character data to update the UI
      await loadCharacterData();
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
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text("Creating random player..."),
            ],
          ),
        );
      },
    );
  }

  // TODO: pasar la historia
  Future<void> createNewGame(
      UserStatistics userStats, String characterId) async {
    Map<String, dynamic> mapUserStats = userStats.toMap();
    mapUserStats["user"] = singleton.user!.uid;
    // TODO: don't harcode this
    Map<String, dynamic> gameConfig = {
      "role_system": "aliens",
      "num_players": 1,
      "story_description": "",
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background2.png'),
          fit: BoxFit.cover,
        ),
      ),
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
                    child: Card(
                      color: Colors.black,
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
                    final characterId =
                        charactersData!.keys.elementAt(selectedIndex);
                    final characterData = charactersData![characterId];
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // TODO: robar el de Victor
                        return const AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.deepPurple,
                              ),
                              SizedBox(height: 16),
                              Text("Creating Game..."),
                            ],
                          ),
                        );
                      },
                      barrierDismissible:
                          false, // Prevent closing the dialog by tapping outside.
                    );
                    createNewGame(UserStatistics.fromMap(characterData), characterId).then((value) {
                      context.go("/game");
                    });
                  },
                  child: Container(
                    height: 100.0, // Set a fixed height for the button
                    child: Card(
                      color: Colors.black,
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
          charactersData == null
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: charactersData!.length,
                    itemBuilder: (context, index) {
                      final characterId = charactersData!.keys.elementAt(index);
                      final characterData = charactersData![characterId];

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: CharacterCard(
                          character: UserStatistics.fromMap(characterData),
                          selected: selectedIndex == index,
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
