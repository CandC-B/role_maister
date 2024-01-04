import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/cohere_logic.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/models/chat_messages.dart';
import 'package:role_maister/models/game.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    child: CopyToClipboardButton(textToCopy: singleton.currentGameShortUid!,),
                    // child: SelectableText(
                    //   singleton.currentGameShortUid!,
                    //   style: const TextStyle(fontSize: 16, color: Colors.white),
                    // ),
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: kIsWeb ? 3.0 : 0.689),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return PlayerCircle(
                        playerName: snapshot.data![index]["name"],
                        ready: snapshot.data![index]["ready"],
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: kIsWeb ? size.width * 0.25 : size.width * 0.5,
                  height: kIsWeb ? size.height * 0.05 : size.height * 0.05,
                  child: ElevatedButton(
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
                      await firebase.gamePlayerReady(singleton.currentGame!);
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
                                  AppLocalizations.of(context)!.creating_game,
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
                              senderName: "IA"),
                          singleton.currentGame!,
                        );
                        await firebase.setGameReady(singleton.currentGame!);
                      } else {
                        // Wait for game to be ready
                        while (!(await firebase
                            .isGameReady(singleton.currentGame!))) {
                          await Future.delayed(const Duration(seconds: 1));
                        }
                      }
                      context.go("/game");
                    },
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(AppLocalizations.of(context)!.pairing_mode_ready),
                    ),
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

class PlayerCircle extends StatelessWidget {
  final String? playerName;
  final bool? ready;

  const PlayerCircle({Key? key, this.playerName, this.ready}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor:
              Colors.deepPurple, // Customize the background color as needed
          radius: 30.0, // Adjust the radius as needed
          child: Text(
            playerName![0]
                .toUpperCase(), // Display the first letter of the name
            style: TextStyle(
              fontSize: 24.0, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
              color: Colors.white, // Customize the text color as needed
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          playerName! + (ready! ? ' ✓' : ''),
          style: TextStyle(
            fontSize: 22.0, // Adjust the font size as needed
            color: Colors.white, // Customize the text color as needed
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
