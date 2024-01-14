import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/models/game.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/config/config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:role_maister/widgets/characters_tab.dart';
import 'package:role_maister/widgets/profile_aliens_characters_card.dart';
import 'package:role_maister/widgets/profile_cthulhu_characters_card.dart';
import 'package:role_maister/widgets/profile_dyd_characters_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:role_maister/models/player_game_data.dart';

class GamePlayers extends StatefulWidget {
  const GamePlayers({super.key, required this.gameId});
  final String gameId;

  @override
  State<GamePlayers> createState() => _GamePlayersState();
}

class _GamePlayersState extends State<GamePlayers> {

  @override
  Widget build(BuildContext context) {
    // firestoreService.observeAndHandleGameChanges(widget.gameId, singleton.player!.uid, context);
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<AliensCharacter>(
      future: getUserStats(widget.gameId),
      builder:
          (BuildContext context, AsyncSnapshot<AliensCharacter?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.transparent,
            child: Center(
              child: Image.asset(
                  'assets/images/small_logo.png'), // Reemplaza 'assets/loading_image.png' con la ruta de tu imagen
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // final userStatistics;
          // if (singleton.gameMode.value == "aliens") {
          //   userStatistics = singleton.alienCharacter;
          // } else if (singleton.gameMode.value == "dyd") {
          //   userStatistics = singleton.dydCharacter;
          // } else if (singleton.gameMode.value == "cthulhu") {
          //   userStatistics = singleton.cthulhuCharacter;
          // } else {
          //   userStatistics = AliensCharacter.random();
          // }
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: size.width > 700 ? false : true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      // context.go('/');
                      // context.push('/');
                      _showDialog(context);
                    },
                  ),
                ],
                title: const Text('Role MAIster'),
                backgroundColor: Colors.deepPurple,
               
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.game_stats),
                    Tab(text: AppLocalizations.of(context)!.game_players),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Center(child: StatsTab()),
                  Center(child: PlayersTab()),
                ],
              ),
            ),
          );
        } else {
          return Text(AppLocalizations.of(context)!.no_stats_found);
        }
      },
    );
  }

  

  Future<AliensCharacter> getUserStats(String gameId) async {
    // firestoreService.observeAndHandleGameChanges(
    //     widget.gameId, singleton.player!.uid, context);


    try {
      final List<Map<String, dynamic>> statsData =
          await firestoreService.getCharactersFromGameId(gameId);
      try {
        return AliensCharacter.fromMap(statsData.first);
      } catch (e) {
        print("Error: $e");
        return AliensCharacter.random();
      }
    } catch (error) {
      throw Exception("Error al obtener estadísticas del usuario: $error");
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.exit_game_dialog_title,
            style: const TextStyle(color: Colors.white),
          ),
          // content: Text(
          //   AppLocalizations.of(context)!.exit_game_dialog_text,
          //   style: const TextStyle(color: Colors.white),
          // ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.exit_game_dialog_text,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                  height:
                      8.0), // Espacio entre el texto principal y el texto en cursiva
              Text(
                AppLocalizations.of(context)!.exit_game_dialog_autosave,
                style: const TextStyle(
                    color: Colors.white, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          backgroundColor: Colors.deepPurple,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.exit_game_dialog_cancel,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                context.push('/');
              },
              child: Text(
                AppLocalizations.of(context)!.exit_game_dialog_exit,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Stats tab
class StatsTab extends StatefulWidget {
  const StatsTab({
    super.key,
  });

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  @override
  Widget build(BuildContext context) {
    ProfileAliensCharacterCard profileAliensCharacterCard =
        ProfileAliensCharacterCard(character: singleton.alienCharacter);
    ProfileDydCharacterCard profiledydCharacterCard =
        ProfileDydCharacterCard(character: singleton.dydCharacter);
    ProfileCthulhuCharacterCard profileCthulhuCharacterCard =
        ProfileCthulhuCharacterCard(character: singleton.cthulhuCharacter);
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
            child: singleton.gameMode.value == "aliens"
                ? profileAliensCharacterCard.showStats(singleton.alienCharacter)
                : singleton.gameMode.value == "dyd"
                    ? profiledydCharacterCard.showStats(singleton.dydCharacter)
                    : singleton.gameMode.value == "cthulhu"
                        ? profileCthulhuCharacterCard.showStats(singleton.cthulhuCharacter)
                        :  const Center(child: CircularProgressIndicator(color: Colors.deepPurple,))));
  }
}

// Players tab
class PlayersTab extends StatelessWidget {

  const PlayersTab({  
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream:
            // firestoreService.getCharactersFromGameId(singleton.currentGame!),
            firestoreService
                .getCharactersStreamFromGameId(singleton.currentGame!),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(
                    'assets/images/small_logo.png'), // Reemplaza 'assets/loading_image.png' con la ruta de tu imagen
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // return PlayerCard(playerName: snapshot.data![index]["name"], numPlayers: snapshot.data!.length);
                return PlayerCard(
                  playerName: snapshot.data![index]["name"],
                  numPlayers: snapshot.data!.length,
                  id: snapshot.data![index]["userId"],
                );
              },
            );
          } else {
            return const Text('Players not found');
          }
        }),
      ),
    );
  }
}

class PlayerCard extends StatefulWidget {
  final String playerName;
  final int numPlayers;
  final String id;

  const PlayerCard({
    Key? key,
    required this.playerName,
    required this.numPlayers,
    required this.id,
  }) : super(key: key);

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  bool isReported = false;
  int numPlayers = 0;

  void saveSystemMsg(String text) async {
    text = await translateText(text, 'en');

    firestoreService.saveMessage(
      ChatMessages(
          sentBy: "System",
          sentAt: DateTime.now(),
          text: text,
          senderName: "System",
          characterName: '',
          userImage: 'https://firebasestorage.googleapis.com/v0/b/role-maister.appspot.com/o/small_logo.png?alt=media&token=54ac8a51-9a0d-4a78-baea-81cdc07efc16'),
      singleton.currentGame!,
    );
  }

  void saveVote(String gameId, String playerId) async {
    await firestoreService.saveKickVote(gameId, playerId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Acción vacía
      },
      child: Card(
        color: Colors.deepPurple,
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.playerName,
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              const SizedBox(width: 10.0),
              widget.playerName == singleton.selectedCharacterName
                  ? const SizedBox()
                  : IconButton(
                      icon: Icon(
                        Icons.report,
                        color: isReported ? Colors.grey : Colors.red,
                      ),
                      onPressed: isReported
                          ? null
                          : () {
                              // Abrir el diálogo aquí
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .report_player_dialog_title,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      "${AppLocalizations.of(context)!.report_player_dialog_text}${widget.playerName}?",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .report_player_dialog_cancel,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Lógica para manejar el reporte
                                          setState(() {
                                            isReported = true;
                                          });
                                          Navigator.of(context).pop();

                                          saveSystemMsg(
                                              "El jugador ${widget.playerName} ha sido reportado por mal comportamiento. (+1 voto)");


                                          saveVote(singleton.currentGame!,
                                              widget.id);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .report_player_dialog_report,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                    ),
            ],
          ),
        ),
      ),
    );
  }
   Future<String> translateText(String text, String targetLocale) async {
    final url = Uri.parse(
        'https://google-translate113.p.rapidapi.com/api/v1/translator/text');
    final headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'X-RapidAPI-Key': 'caf9b2a90emsh35ef4bc666f9d1ap107021jsnb69346f6591e',
      'X-RapidAPI-Host': 'google-translate113.p.rapidapi.com',
    };

    final body = {
      'from': 'auto',
      'to': targetLocale,
      'text': text,
    };

    try {
      final response = await http.post(url, headers: headers, body: body);
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('trans')) {
        return responseData['trans'];
      } else {
        throw Exception('Campo "trans" no encontrado en la respuesta');
      }
    } catch (error) {
      throw Exception('Error en la solicitud de traducción: $error');
    }
  }
}

// class Stats extends StatelessWidget {
//   const Stats({super.key, required this.userStats});
//   final AliensCharacter userStats;

//   @override
//   Widget build(BuildContext context) {
//     // TODO: This is Mock user statistics, replace with real data
//     // TODO: Improve the UI
//     // TODO: Reorder the stats

//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.black54,
//         title: Text(userStats.name),
//       ),
//       backgroundColor: Colors.deepPurple,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//           _buildStatItem(
//               AppLocalizations.of(context)!.aliens_hp,
//               Icons.favorite, userStats.hp.toString(), Colors.white),
//           // _buildStatItem('userStats Level', 
//           _buildStatItem(AppLocalizations.of(context)!.aliens_character_level,
//           Icons.bar_chart,
//               userStats.characterLevel.toString(), Colors.white),
//           _buildStatItem(
//               AppLocalizations.of(context)!.aliens_career,
//               Icons.school, userStats.career, Colors.white),
//           _buildAttributeStats(userStats.attributes, context),
//           _buildStatItem(
//               AppLocalizations.of(context)!.aliens_skills,
//               Icons.list,
//               userStats.skills.toString().replaceAll(RegExp("[{}]"), ""),
//               Colors.white),
//           _buildStatItem(
//               AppLocalizations.of(context)!.aliens_talents, 
//           Icons.star, userStats.talents.join(', '),
//               Colors.white),
//           _buildStatItem(
//               // 'Appearance', 
//               AppLocalizations.of(context)!.aliens_appearance,
//               Icons.face, userStats.appearance, Colors.white),
//           // _buildStatItem('Personal Agenda', 
//           _buildStatItem(AppLocalizations.of(context)!.aliens_personal_agenda,
//           Icons.assignment,
//               userStats.personalAgenda, Colors.white),
//           // _buildStatItem('Friend', 
//           _buildStatItem(AppLocalizations.of(context)!.aliens_friend,
//           Icons.sentiment_very_satisfied,
//               userStats.friend, Colors.white),
//           // _buildStatItem('Rival', 
//           _buildStatItem(AppLocalizations.of(context)!.aliens_rival,
//           Icons.sentiment_very_dissatisfied,
//               userStats.rival, Colors.white),
//           // _buildStatItem('Gear', 
//           _buildStatItem(AppLocalizations.of(context)!.aliens_gear,
//           Icons.accessibility, userStats.gear.join(', '),
//               Colors.white),
//           // _buildStatItem('Signature Item', 
//           _buildStatItem(AppLocalizations.of(context)!.aliens_signature_item,
//           Icons.edit, userStats.signatureItem,
//               Colors.white),
//           _buildStatItem(
//               AppLocalizations.of(context)!.aliens_cash, 
//               Icons.attach_money, '\$${userStats.cash}', Colors.white),
//         ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatItem(
//       String label, IconData icon, String value, Color textColor) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.white),
//       title: Text(label, style: const TextStyle(color: Colors.white)),
//       subtitle: Text(value, style: TextStyle(color: textColor)),
//     );
//   }

//   Widget _buildAttributeStats(Map<String, int> attributes, BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ListTile(
//           leading: Icon(Icons.insert_chart, color: Colors.white),
//           title: Text(AppLocalizations.of(context)!.aliens_attributes,
//           style: TextStyle(color: Colors.white)),
//         ),
//         ListTile(
//           leading: const Icon(Icons.sports_tennis, color: Colors.white),
//           title: Text(AppLocalizations.of(context)!.aliens_strength + ': ${attributes['Strength']}',
//               style: const TextStyle(color: Colors.white)),
//         ),
//         ListTile(
//           leading: const Icon(Icons.directions_run, color: Colors.white),
//           title: Text(AppLocalizations.of(context)!.aliens_agility + ': ${attributes['Agility']}',
//               style: const TextStyle(color: Colors.white)),
//         ),
//         ListTile(
//           leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
//           title: Text(AppLocalizations.of(context)!.aliens_empathy + ': ${attributes['Empathy']}',
//               style: const TextStyle(color: Colors.white)),
//         ),
//         ListTile(
//           leading: const Icon(Icons.lightbulb, color: Colors.white),
//           title: Text(AppLocalizations.of(context)!.aliens_wits + ': ${attributes['Wits']}',
//               style: const TextStyle(color: Colors.white)),
//         ),
//       ],
//     );
//   }
// }
