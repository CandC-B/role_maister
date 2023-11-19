import 'package:flutter/material.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/widgets.dart';

class ProfileCthulhuCharacterCard extends StatelessWidget {
  final CthulhuCharacter character;

  ProfileCthulhuCharacterCard(
      {super.key, required this.character});

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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      shape: new RoundedRectangleBorder(
              side: new BorderSide(color: Colors.deepPurple, width: 2.0),
              borderRadius: BorderRadius.circular(4.0)),
      child: ExpansionTile(
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        title: Row(
          children: [
            const Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                character.name,
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ],
        ),
        children: [
          _buildStatItem(
              'HP', Icons.favorite, character.hp.toString(), Colors.white),
          _buildStatItem('Character Level', Icons.bar_chart,
              character.characterLevel.toString(), Colors.white),
          _buildStatItem(
              'Career', Icons.school, character.career, Colors.white),
          _buildAttributeStats(character.attributes),
          _buildStatItem(
              'Skills',
              Icons.list,
              character.skills.toString().replaceAll(RegExp("[{}]"), ""),
              Colors.white),
          _buildStatItem('Talents', Icons.star, character.talents.join(', '),
              Colors.white),
          _buildStatItem(
              'Appearance', Icons.face, character.appearance, Colors.white),
          _buildStatItem('Personal Agenda', Icons.assignment,
              character.personalAgenda, Colors.white),
          _buildStatItem('Friend', Icons.sentiment_very_satisfied,
              character.friend, Colors.white),
          _buildStatItem('Rival', Icons.sentiment_very_dissatisfied,
              character.rival, Colors.white),
          _buildStatItem('Gear', Icons.accessibility, character.gear.join(', '),
              Colors.white),
          _buildStatItem('Signature Item', Icons.edit, character.signatureItem,
              Colors.white),
          _buildStatItem(
              'Cash', Icons.attach_money, '\$${character.cash}', Colors.white),
        ],
      ),
    );
  }
}
