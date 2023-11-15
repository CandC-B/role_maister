import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/models/models.dart';

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
      builder: (BuildContext context, AsyncSnapshot<AliensCharacter?> snapshot) {
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
          final userStats = snapshot.data ??
              AliensCharacter.random(); // Usar datos o valor random
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      context.go('/');
                      context.push('/');
                    },
                  ),
                ],
                title: const Text('Role MAIster'),
                backgroundColor: Colors.deepPurple,
                bottom: const TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: 'Stats'),
                    Tab(text: 'Players'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Center(child: StatsTab(userStats: userStats)),
                  Center(child: PlayersTab(userStats: userStats)),
                ],
              ),
            ),
          );
        } else {
          return const Text('No se encontraron estadísticas.');
        }
      },
    );
  }

  Future<AliensCharacter> getUserStats(String gameId) async {
    try {
      final Map<String, dynamic> statsData =
          await firestoreService.getCharactersFromGameId(gameId);
      try {
        return AliensCharacter.fromMap(statsData);
      } catch (e) {
        print("Error: $e");
        return AliensCharacter.random();
      }
    } catch (error) {
      throw Exception("Error al obtener estadísticas del usuario: $error");
    }
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
        body: PlayerCard(
            playerName: userStats.name) // TODO: REPLACE WITH REAL DATA

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
              _buildStatItem(
                  'HP', Icons.favorite, userStats.hp.toString(), Colors.white),
              _buildStatItem('Character Level', Icons.bar_chart,
                  userStats.characterLevel.toString(), Colors.white),
              _buildStatItem(
                  'Career', Icons.school, userStats.career, Colors.white),
              _buildAttributeStats(userStats.attributes),
              _buildStatItem(
                  'Skills',
                  Icons.list,
                  userStats.skills.toString().replaceAll(RegExp("[{}]"), ""),
                  Colors.white),
              _buildStatItem('Talents', Icons.star,
                  userStats.talents.join(', '), Colors.white),
              _buildStatItem(
                  'Appearance', Icons.face, userStats.appearance, Colors.white),
              _buildStatItem('Personal Agenda', Icons.assignment,
                  userStats.personalAgenda, Colors.white),
              _buildStatItem('Friend', Icons.sentiment_very_satisfied,
                  userStats.friend, Colors.white),
              _buildStatItem('Rival', Icons.sentiment_very_dissatisfied,
                  userStats.rival, Colors.white),
              _buildStatItem('Gear', Icons.accessibility,
                  userStats.gear.join(', '), Colors.white),
              _buildStatItem('Signature Item', Icons.edit,
                  userStats.signatureItem, Colors.white),
              _buildStatItem('Cash', Icons.attach_money, '\$${userStats.cash}',
                  Colors.white),
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

  Widget _buildAttributeStats(Map<String, int> attributes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: Icon(Icons.insert_chart, color: Colors.white),
          title: Text('Attributes', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sports_tennis, color: Colors.white),
          title: Text('Strength: ${attributes['Strength']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run, color: Colors.white),
          title: Text('Agility: ${attributes['Agility']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
          title: Text('Empathy: ${attributes['Empathy']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.white),
          title: Text('Wits: ${attributes['Wits']}',
              style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
