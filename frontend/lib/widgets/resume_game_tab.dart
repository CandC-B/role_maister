import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/game.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:role_maister/config/firebase_logic.dart';

class ResumeGameTab extends StatelessWidget {
  ResumeGameTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase.fetchGamesByUserId(singleton.player!.uid),
        builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 2), // Añadir padding alrededor del Card
                  child: TokenPackageCard(game: snapshot.data![index]),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
    // )
    // Size size = MediaQuery.of(context).size;
    // bool isSmallScreen = size.width < 700;
    // List games = [];
    // Game game = Game(
    //   num_players: 0,
    //   role_system: "Aliens",
    //   players: [],
    //   story_description: "This is a story description",
    // );

    // return ListView.builder(
    //   itemCount: 50,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding:
    //           const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2), // Añadir padding alrededor del Card
    //       child: TokenPackageCard(game: game),
    //     );
    //   },
    // );
  }
}

class TokenPackageCard extends StatelessWidget {
  Game game;
  TokenPackageCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.deepPurple, // Change the border color to red
          width: 2.0, // Set the border width as needed
        ),
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the border radius as needed
      ),
      child: ListTile(
        title: Text(
          game.role_system,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        subtitle: Text(
          game.story_description,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
            side: MaterialStateProperty.all(const BorderSide(
                color: Colors.white,
                width: 1.0)), // Change the border color and width
          ),
          onPressed: () {
            showConfirmationDialog(context, game);
          },
          child: Text("Resume", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  void showConfirmationDialog(BuildContext context, Game game) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            "Resume Game",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Are you sure you want to resume this game?",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Resume",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                // Once payment is successful, you can update the user's token balance.
                // For this example, you can just close the dialog.
                String characterId =
                    game.players[singleton.player!.uid]["characterId"];
                Map<String, dynamic> character =
                    await firebase.getCharacter(characterId, game.role_system);
                    print(game.uid);
                singleton.currentGame = game.uid;
                singleton.selectedCharacterName = character["name"];
                singleton.selectedCharacterId = characterId;
                singleton.gameMode = ValueNotifier<String>(game.role_system);
                if (game.role_system == "aliens") {
                  singleton.alienCharacter = AliensCharacter.fromMap(character);
                  print("alienCharacter: ${singleton.alienCharacter}");
                } else if (game.role_system == "dyd") {
                  singleton.dydCharacter = DydCharacter.fromMap(character);
                  print("dydCharacter: ${singleton.dydCharacter}");
                } else if (game.role_system == "cthulhu") {
                  singleton.cthulhuCharacter =
                      CthulhuCharacter.fromMap(character);
                  print("cthulhuCharacter: ${singleton.cthulhuCharacter}");
                }
                print("User: ${singleton.user}");
                print("Player: ${singleton.player}");
                print(
                    "SelectedCharacterName: ${singleton.selectedCharacterName}");
                print("CurrentGame: ${singleton.currentGame}");
                print("selectedCharacterId: ${singleton.selectedCharacterId}");
                print("gameMode: ${singleton.gameMode}");

                context.go("/game");
              },
            ),
          ],
        );
      },
    );
  }
}
