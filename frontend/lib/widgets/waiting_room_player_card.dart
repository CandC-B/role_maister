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
            final Map<String, dynamic> gameData = snapshot.data! as Map<String, dynamic>;

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
                    playerName! + (ready! ? ' ✓' : ''),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: kIsWeb ? 25.0 : 8.0),
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 30.0,
                    child: Text(
                      playerName![0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  gameData['creator_uid'] == singleton.user!.uid? SizedBox(height: kIsWeb ? 25.0 : 8.0) : SizedBox(),
                  gameData['creator_uid'] == singleton.user!.uid? ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple),
                    ),
                    child: Text(
                        AppLocalizations.of(context)!.kick_player_button,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)),
                  ) : SizedBox(),
                ],
              ),
            );
          } else {
            return Text(AppLocalizations.of(context)!.no_stats_found);
          }
        });
  }
}
