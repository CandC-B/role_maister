import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:role_maister/config/config.dart';

class WaitingRoomPlayerCard extends StatelessWidget {
  final String? playerName;
  final bool? ready;
  final String? playerId;

  const WaitingRoomPlayerCard(
      {Key? key, this.playerName, this.ready, this.playerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase.getGame(singleton.currentGame!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            print("My user id: " + singleton.user!.uid);
            print("snapshot.data: " + snapshot.data.toString());
            final Map<String, dynamic> gameData =
                snapshot.data! as Map<String, dynamic>;
            return _buildGameWidget(gameData);
          } else {
            return Text(AppLocalizations.of(context)!.no_stats_found);
          }
        });
  }

  Widget _buildGameWidget(gameData) {
  return FutureBuilder(
    future: _buildPlayersImageMap(gameData),
    builder: (context, playersImageSnapshot) {
      if (playersImageSnapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // o cualquier otro indicador de carga
      } else if (playersImageSnapshot.hasError) {
        return Text('Error: ${playersImageSnapshot.error}');
      } else if (playersImageSnapshot.hasData) {
        final Map<String, String> playersImage =
            playersImageSnapshot.data as Map<String, String>;
        return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              padding: const EdgeInsets.all(kIsWeb ? 30.0 : 8.0),
              child: Column(
                children: [
                  Text(
                    playerName! +
                        (gameData['creator_uid'] == playerId! ? ' 👑' : '') +
                        (playerId! == singleton.user!.uid ? ' (You)' : '') +
                        (ready! ? ' ✓' : ''),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: kIsWeb ? 25.0 : 8.0),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30.0,
                    // Añadir imagen
                    backgroundImage: NetworkImage(playersImage[playerId!]!),
                  ),
                  (gameData['creator_uid'] == singleton.user!.uid &&
                          playerId! != singleton.user!.uid)
                      ? SizedBox(height: kIsWeb ? 25.0 : 8.0)
                      : SizedBox(),
                  (gameData['creator_uid'] == singleton.user!.uid &&
                          playerId! != singleton.user!.uid)
                      ? ElevatedButton(
                          onPressed: () async {
                            print("Kicking player: " + playerId!);
                            await firebase.kickPlayerFromWaitingRoom(
                                singleton.currentGame!, playerId!);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurple),
                          ),
                          child: Text(
                              AppLocalizations.of(context)!.kick_player_button,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        )
                      : SizedBox(),
                ],
              ),
            );
      } else {
        return SizedBox();
      }
    },
  );
}

Future<Map<String, String>> _buildPlayersImageMap(gameData) async {
  final Map<String, dynamic> players = gameData['players'];
  final Map<String, String> playersImage = {};
  final List<Future> futures = [];

  players.forEach((key, value) {
    futures.add(
      firebase.getUserImageFromUserId(key).then((currentPlayerImage) {
        playersImage[key] = currentPlayerImage;
      }),
    );
  });

  await Future.wait(futures);
  return playersImage;
}
}
