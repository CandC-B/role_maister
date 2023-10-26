import 'package:flutter/material.dart';
import 'package:role_maister/models/models.dart';
import 'dart:convert';

class GamePlayers extends StatefulWidget {
  const GamePlayers({Key? key}) : super(key: key);

  @override
  State<GamePlayers> createState() => _GamePlayersState();
}

class _GamePlayersState extends State<GamePlayers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
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
            // TODO: poner el de Firebase
            Center(child: StatsTab(userStats: UserStatistics.random(),)),
            Center(child: PlayersTab()),
          ],
        ),
      ),
    );
  }
}

// Stats tab
class StatsTab extends StatefulWidget {
  const StatsTab({
    super.key,
    required this.userStats,
  });
  final UserStatistics userStats;

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // child: const Text("Stats Tab Content"),
        child: Stats(userStats: widget.userStats),
        color: Colors.black87
      );
  }
}

// Players tab
class PlayersTab extends StatelessWidget {
  const PlayersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      backgroundColor: Colors.black,
      body: PlayerCard(playerName: "John Doe") // TODO: REPLACE WITH REAL DATA
      
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
  final UserStatistics userStats;

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
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatItem('HP', Icons.favorite, userStats.hp.toString(), Colors.white),
                _buildStatItem('Character Level', Icons.bar_chart, userStats.characterLevel.toString(), Colors.white),
                _buildStatItem('Career', Icons.school, userStats.career, Colors.white),
                _buildAttributeStats(userStats.attributes),
                _buildStatItem('Skills', Icons.list, userStats.skills.toString().replaceAll(RegExp("[{}]"), ""), Colors.white),
                _buildStatItem('Talents', Icons.star, userStats.talents.join(', '), Colors.white),
                _buildStatItem('Appearance', Icons.face, userStats.appearance, Colors.white),
                _buildStatItem('Personal Agenda', Icons.assignment, userStats.personalAgenda, Colors.white),
                _buildStatItem('Friend', Icons.sentiment_very_satisfied, userStats.friend, Colors.white),
                _buildStatItem('Rival', Icons.sentiment_very_dissatisfied, userStats.rival, Colors.white),
                _buildStatItem('Gear', Icons.accessibility, userStats.gear.join(', '), Colors.white),
                _buildStatItem('Signature Item', Icons.edit, userStats.signatureItem, Colors.white),
                _buildStatItem('Cash', Icons.attach_money, '\$${userStats.cash}', Colors.white),  
              ],
            ),
          ),
        ),
      );    
  }

  Widget _buildStatItem(String label, IconData icon, String value, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: TextStyle(color: Colors.white)),
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
          title: Text('Strength: ${attributes['Strength']}', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run, color: Colors.white),
          title: Text('Agility: ${attributes['Agility']}', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
          title: Text('Empathy: ${attributes['Empathy']}', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.lightbulb, color: Colors.white),
          title: Text('Wits: ${attributes['Wits']}', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
