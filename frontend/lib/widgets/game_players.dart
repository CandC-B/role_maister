import 'package:flutter/material.dart';


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
        body: const TabBarView(
          children: [
            Center(child: StatsTab()),
            Center(child: PlayersTab()),
          ],
        ),
      ),
    );
  }
}

// Stats tab
class StatsTab extends StatelessWidget {
  const StatsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black87,
      body: Container(
        // child: const Text("Stats Tab Content"),
        child: const Stats(),
      )
      
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

class UserStatistics {
  final int characterLevel;
  final String career;
  final Map<String, int> attributes;
  final List<String> skills;
  final List<String> talents;
  final String name;
  final String appearance;
  final String personalAgenda;
  final String friend;
  final String rival;
  final String gear;
  final String signatureItem;
  final int cash;
  final int hp;

  UserStatistics({
    required this.characterLevel,
    required this.career,
    required this.attributes,
    required this.skills,
    required this.talents,
    required this.name,
    required this.appearance,
    required this.personalAgenda,
    required this.friend,
    required this.rival,
    required this.gear,
    required this.signatureItem,
    required this.cash,
    required this.hp,
  });
}

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: This is Mock user statistics, replace with real data
    // TODO: Improve the UI 
    // TODO: Reorder the stats
    UserStatistics userStats = UserStatistics(
      characterLevel: 30,
      career: 'Software Engineer',
      attributes: {'fuerza': 80, 'agilidad': 90, 'empatia': 70, 'iq': 85},
      skills: ['Skill 1', 'Skill 2', 'Skill 3'],
      talents: ['Talent 1', 'Talent 2'],
      name: 'John Doe',
      appearance: 'Tall, dark hair',
      personalAgenda: 'Complete projects on time',
      friend: 'Very Satisfied',
      rival: 'Extremely Dissatisfied',
      gear: 'Laptop, headset',
      signatureItem: 'Favorite Pen',
      cash: 1000,
      hp: 95,
    );

     
    return Scaffold(
        appBar: AppBar(
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
                _buildStatItem('Skills', Icons.list, userStats.skills.join(', '), Colors.white),
                _buildStatItem('Talents', Icons.star, userStats.talents.join(', '), Colors.white),
                _buildStatItem('Appearance', Icons.face, userStats.appearance, Colors.white),
                _buildStatItem('Personal Agenda', Icons.assignment, userStats.personalAgenda, Colors.white),
                _buildStatItem('Friend', Icons.sentiment_very_satisfied, userStats.friend, Colors.white),
                _buildStatItem('Rival', Icons.sentiment_very_dissatisfied, userStats.rival, Colors.white),
                _buildStatItem('Gear', Icons.accessibility, userStats.gear, Colors.white),
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
          title: Text('Fuerza: ${attributes['fuerza']}', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run, color: Colors.white),
          title: Text('Agilidad: ${attributes['agilidad']}', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
          title: Text('Empatia: ${attributes['empatia']}', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.lightbulb, color: Colors.white),
          title: Text('IQ: ${attributes['iq']}', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
