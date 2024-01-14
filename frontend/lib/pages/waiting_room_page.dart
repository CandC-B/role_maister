import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/cohere_logic.dart';
import 'package:role_maister/config/constants.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/models/chat_messages.dart';
import 'package:role_maister/models/game.dart';
import 'package:role_maister/models/player_game_data.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class WaitingRoomPage extends StatefulWidget {
  const WaitingRoomPage({super.key});

  @override
  State<WaitingRoomPage> createState() => _WaitingRoomPageState();
}

class _WaitingRoomPageState extends State<WaitingRoomPage> {
  bool isButtonPressed = false;

  void observeAndHandleGameChanges(
      String gameId, String currentUserUid, BuildContext context) {
    FirebaseFirestore.instance
        .collection('game')
        .doc(gameId)
        .snapshots()
        .listen((event) async {
      if (event.exists) {
        final data = event.data() as Map<String, dynamic>?;
        if (data != null) {
          // check if currentUserUid is in the players list
          if (data['players'].containsKey(currentUserUid)) {
            // check if the player has voted to kick
            PlayerGameData playerGameData =
                PlayerGameData.fromMap(data['players'][currentUserUid]);

            if (playerGameData.isKickedFromWaitingRoom) {
              // kick the player
              print('A TOMAR POR CULO!! ');

              await firestoreService.deleteKickedPlayer(gameId, currentUserUid);

              // Show a dialog to inform the user
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.deepPurple,
                    title: Text('You were kicked', style: TextStyle(color: Colors.white),),
                    content: Text('You were kicked by the host of the game.', style: TextStyle(color: Colors.white)),
                    
                  );
                },
              );

              // Close the dialog after 3 seconds and navigate to another screen
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop(); // Close the dialog
                context.go("/");
                context.push("/");
                singleton.currentGame = "";
              });
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    observeAndHandleGameChanges(
        singleton.currentGame!, singleton.player!.uid, context);
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background4.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: StreamBuilder(
        stream: firestoreService
            .getCharactersStreamFromGameId(singleton.currentGame!),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset('assets/images/small_logo.png'),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  height: size.height * 0.05,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.waiting_room,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.1,
                  child: Center(
                    child: CopyToClipboardButton(
                      textToCopy: singleton.currentGameShortUid!,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: kIsWeb ? 5 : 3,
                      childAspectRatio: kIsWeb ? 1.0 : 0.6,
                      crossAxisSpacing: kIsWeb ? 20.0 : 8.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      print(
                          "snapshot.data: " + snapshot.data![index].toString());
                      return WaitingRoomPlayerCard(
                        playerName: snapshot.data![index]["name"],
                        ready: snapshot.data![index]["ready"],
                        playerId: snapshot.data![index]["userId"],
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: kIsWeb ? size.width * 0.25 : size.width * 0.5,
                  height: kIsWeb ? size.height * 0.05 : size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor:
                              isButtonPressed ? Colors.grey : Colors.deepPurple,
                          textStyle: const TextStyle(
                              fontSize: kIsWeb ? 30 : 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          setState(() {
                            isButtonPressed = true;
                          });
                          await firebase
                              .gamePlayerReady(singleton.currentGame!);
                          // Wait for all players to be ready
                          while (!(await firebase
                              .allPlayersReady(singleton.currentGame!))) {
                            await Future.delayed(const Duration(seconds: 1));
                          }
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
                                          child: Image.asset(
                                              'assets/images/small_logo.png'),
                                        ),
                                      ),
                                    ),
                                    LinearProgressIndicator(
                                      color: Colors.amber,
                                      backgroundColor: Colors.white,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .creating_game,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            },
                            barrierDismissible: false,
                          );
                          if (singleton.joinPairingMode == false) {
                            // Prompt Coral to start the game
                            Game currentGame = Game.fromMap(
                                await firebase.getGame(singleton.currentGame!));
                            var coralMessage = await createGame(currentGame);
                            // await firebase.saveMessage(
                            //     coralMessage, DateTime.now(), singleton.currentGame!, "IA");
                            await firebase.saveMessage(
                              ChatMessages(
                                sentBy: "IA",
                                sentAt: DateTime.now(),
                                text: coralMessage,
                                characterName: "",
                                senderName: "IA",
                                userImage:
                                    'https://firebasestorage.googleapis.com/v0/b/role-maister.appspot.com/o/bot_master.png?alt=media&token=50e2cacc-58fa-41a4-b6bc-a838538dd48a',
                              ),
                              singleton.currentGame!,
                            );
                            firebase.updateAiWordCount(singleton.currentGame!,
                                coralMessage.split(' ').length);
                            // Take tokens from all players
                            double tokensToSubstract = getPlayerGamePrice(
                                0,
                                coralMessage.split(' ').length,
                                currentGame.num_players);
                            await Future.wait(
                                currentGame.players.keys.map((playerUid) async {
                              await firebase.changePlayerBalance(
                                  playerUid, -tokensToSubstract);
                            }));
                            await firebase.setGameReady(singleton.currentGame!);
                          } else {
                            // Wait for game to be ready
                            while (!(await firebase
                                .isGameReady(singleton.currentGame!))) {
                              await Future.delayed(const Duration(seconds: 1));
                            }
                          }
                          await firebase
                              .updateUserPlayedGames(singleton.user!.uid);
                          context.go("/game");
                        },
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                              AppLocalizations.of(context)!.pairing_mode_ready),
                        ),
                      ),
                      SizedBox(width: kIsWeb ? 20.0 : 8.0),
                      ElevatedButton(
                        onPressed: () async {
                          await firebase.deleteKickedPlayer(
                              singleton.currentGame!, singleton.player!.uid);
                          context.go("/");
                          context.push("/");
                          singleton.currentGame = "";
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.deepPurple,
                          textStyle: const TextStyle(
                              fontSize: kIsWeb ? 30 : 20,
                              fontWeight: FontWeight.bold),
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            AppLocalizations.of(context)!.exit_game_dialog_exit,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Text('Players not found');
          }
        }),
      ),
    );
  }
}
