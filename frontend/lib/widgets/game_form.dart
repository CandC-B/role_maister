import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:role_maister/config/config.dart';

class GameForm extends StatelessWidget {
  GameForm({super.key, required this.character});
  final UserStatistics character;
  var _storyController = TextEditingController();

  Future<void> createNewGame(UserStatistics userStats, String history) async {
    Map<String, dynamic> mapUserStats = userStats.toMap();
    mapUserStats["user"] = singleton.user!.uid;
    String character_uid = await firebase.createCharacter(mapUserStats);
    // TODO: don't harcode this
    Map<String, dynamic> gameConfig = {
      "role_system": "aliens",
      "num_players": 1,
      "story_description": history,
      "players": [character_uid]
    };
    String gameUid = await firebase.createGame(gameConfig);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    gameConfig.remove("players");
    print(gameConfig);
    mapUserStats.addAll(gameConfig);
    final response = await http.post(
        // TODO: add constants.dart in utils folder
        Uri.http("localhost:8000", "/game/"),
        headers: headers,
        body: jsonEncode(mapUserStats));
    var coralMessage = json.decode(response.body)["message"];
    await firebase.saveMessage(coralMessage, DateTime.now(), gameUid, "IA");
    singleton.currentGame = gameUid;
    print(singleton.currentGame);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Column(children: [
        Expanded(
          flex: 1,
          child: Row(children: [
            Expanded(
              flex: 1,
              child: ImageColorFilter(
                imagePath: 'assets/images/aliens.jpg',
                routeName: '/game',
                imageText: "ALIENS",
                isAvailable: true,
                height: size.height * 0.9 / 4,
                width: size.width * 0.8 / 3,
                isLink: false,
                preset: true,
              ),
            ),
            Expanded(
              flex: 1,
              child: ImageColorFilter(
                imagePath: 'assets/images/dungeons_and_dragons.jpg',
                routeName: '/game',
                imageText: "DUNGEONS AND DRAGONS",
                isAvailable: false,
                height: size.height * 0.9 / 4,
                width: (size.width * 0.8 * 2 / 3) / 3,
                isLink: false,
                preset: false,
              ),
            ),
            Expanded(
              flex: 1,
              child: ImageColorFilter(
                imagePath: 'assets/images/cthulhu.jpg',
                routeName: '/game',
                imageText: "THE CALL OF CTHULHU",
                isAvailable: false,
                height: size.height * 0.9 / 4,
                width: (size.width * 0.8 * 2 / 3) / 3,
                isLink: false,
                preset: false,
              ),
            ),
          ]),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.width * 0.01),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Number of players: 1"),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text("Brief story description:"),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.width * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.black87, // Set the background color to grey
                      borderRadius: BorderRadius.circular(
                          10), // Optionally, round the corners
                    ),
                    child: TextFormField(
                      cursorColor: Colors.deepPurple,
                      controller: _storyController,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(color: Colors.white),
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                  )),
                ]),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Column(children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Text("Tokens required: 5"),
              SizedBox(
                height: size.height * 0.05,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.deepPurple,
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Colors.deepPurple,),
                              SizedBox(height: 16),
                              Text("Creating Game..."),
                            ],
                          ),
                        );
                      },
                      barrierDismissible: false, // Prevent closing the dialog by tapping outside.
                    );
                    createNewGame(character, _storyController.text)
                        .then((value) {
                          _storyController.text = '';
                          context.go("/game");
                        }
                    );
                  },
                  child: const FittedBox(
                      fit: BoxFit.contain, child: Text("Start Game"))),
            ]),
          ),
        ),
      ]),
    );
  }
}
