import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/config/config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamePlayers extends StatefulWidget {
  const GamePlayers({super.key, required this.gameId});
  final String gameId;

  @override
  State<GamePlayers> createState() => _GamePlayersState();
}

class _GamePlayersState extends State<GamePlayers> {
  @override
  Widget build(BuildContext context) {
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
          final userStatistics;
          if (singleton.gameMode.value == "Aliens") {
            userStatistics = singleton.alienCharacter;
          } else if (singleton.gameMode.value == "Dyd") {
            userStatistics = singleton.dydCharacter;
          } else if (singleton.gameMode.value == "Cthulhu") {
            userStatistics = singleton.cthulhuCharacter;
          } else {
            userStatistics = AliensCharacter.random();
          }
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: kIsWeb ? null : const BackButton(),
                automaticallyImplyLeading: kIsWeb ? false : true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      // context.go('/');
                      // context.push('/');
                      _mostrarDialogo(context);
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
                  Center(child: StatsTab(userStats: userStatistics)),
                  Center(child: PlayersTab(userStats: userStatistics)),
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
    try {
      final List<Map<String, dynamic>> statsData =
          await firestoreService.getCharactersFromGameId(gameId);
      try {
        return AliensCharacter.fromMap(statsData[0]);
      } catch (e) {
        print("Error: $e");
        return AliensCharacter.random();
      }
    } catch (error) {
      throw Exception("Error al obtener estadísticas del usuario: $error");
    }
  }

  void _mostrarDialogo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.exit_game_dialog_title),
          content: Text(AppLocalizations.of(context)!.exit_game_dialog_text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  Text(AppLocalizations.of(context)!.exit_game_dialog_cancel),
            ),
            TextButton(
              onPressed: () {
                context.go('/');
                context.push('/');
              },
              child: Text(AppLocalizations.of(context)!.exit_game_dialog_exit),
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
    required this.userStats,
  });
  final AliensCharacter userStats;

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
          // child: const Text("Stats Tab Content"),
          child: Stats(userStats: widget.userStats),
        ));
  }
}

// Players tab
class PlayersTab extends StatelessWidget {
  const PlayersTab({
    super.key,
    required this.userStats,
  });

  final AliensCharacter userStats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future:
            firestoreService.getCharactersFromGameId(singleton.currentGame!),
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
                return PlayerCard(playerName: snapshot.data![index]["name"]);
              },
            );
          } else {
            return const Text('No se encontraron estadísticas.');
          }
        }),
      ),
    );
  }
}

// TODO: LAS CARTAS DEBEN SER BUTTONS TAMBIÉN PARA  UE PUEDAS VER LOS STATS DE OTROS PLAYERS
class PlayerCard extends StatelessWidget {
  final String playerName;

  const PlayerCard({super.key, required this.playerName});

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
              const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  playerName,
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Stats extends StatelessWidget {
  const Stats({super.key, required this.userStats});
  final AliensCharacter userStats;

  @override
  Widget build(BuildContext context) {
    // TODO: This is Mock user statistics, replace with real data
    // TODO: Improve the UI
    // TODO: Reorder the stats

    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black54,
        title: Text(userStats.name),
      ),
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatItem(AppLocalizations.of(context)!.aliens_hp,
                  Icons.favorite, userStats.hp.toString(), Colors.white),
              // _buildStatItem('userStats Level',
              _buildStatItem(
                  AppLocalizations.of(context)!.aliens_character_level,
                  Icons.bar_chart,
                  userStats.characterLevel.toString(),
                  Colors.white),
              _buildStatItem(AppLocalizations.of(context)!.aliens_career,
                  Icons.school, userStats.career, Colors.white),
              _buildAttributeStats(userStats.attributes, context),
              _buildStatItem(
                  AppLocalizations.of(context)!.aliens_skills,
                  Icons.list,
                  userStats.skills.toString().replaceAll(RegExp("[{}]"), ""),
                  Colors.white),
              _buildStatItem(AppLocalizations.of(context)!.aliens_talents,
                  Icons.star, userStats.talents.join(', '), Colors.white),
              _buildStatItem(
                  // 'Appearance',
                  AppLocalizations.of(context)!.aliens_appearance,
                  Icons.face,
                  userStats.appearance,
                  Colors.white),
              // _buildStatItem('Personal Agenda',
              _buildStatItem(
                  AppLocalizations.of(context)!.aliens_personal_agenda,
                  Icons.assignment,
                  userStats.personalAgenda,
                  Colors.white),
              // _buildStatItem('Friend',
              _buildStatItem(
                  AppLocalizations.of(context)!.aliens_friend,
                  Icons.sentiment_very_satisfied,
                  userStats.friend,
                  Colors.white),
              // _buildStatItem('Rival',
              _buildStatItem(
                  AppLocalizations.of(context)!.aliens_rival,
                  Icons.sentiment_very_dissatisfied,
                  userStats.rival,
                  Colors.white),
              // _buildStatItem('Gear',
              _buildStatItem(AppLocalizations.of(context)!.aliens_gear,
                  Icons.accessibility, userStats.gear.join(', '), Colors.white),
              // _buildStatItem('Signature Item',
              _buildStatItem(
                  AppLocalizations.of(context)!.aliens_signature_item,
                  Icons.edit,
                  userStats.signatureItem,
                  Colors.white),
              _buildStatItem(AppLocalizations.of(context)!.aliens_cash,
                  Icons.attach_money, '\$${userStats.cash}', Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String label, IconData icon, String value, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      subtitle: Text(value, style: TextStyle(color: textColor)),
    );
  }

  Widget _buildAttributeStats(
      Map<String, int> attributes, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.insert_chart, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.aliens_attributes,
              style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sports_tennis, color: Colors.white),
          title: Text(
              AppLocalizations.of(context)!.aliens_strength +
                  ': ${attributes['Strength']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run, color: Colors.white),
          title: Text(
              AppLocalizations.of(context)!.aliens_agility +
                  ': ${attributes['Agility']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
          title: Text(
              AppLocalizations.of(context)!.aliens_empathy +
                  ': ${attributes['Empathy']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.white),
          title: Text(
              AppLocalizations.of(context)!.aliens_wits +
                  ': ${attributes['Wits']}',
              style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
