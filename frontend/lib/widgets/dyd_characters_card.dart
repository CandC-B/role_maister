import 'package:flutter/material.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/widgets.dart';

class DydCharacterCard extends StatelessWidget {
  final DydCharacter character;
  final bool selected;

  DydCharacterCard({super.key, required this.character, required this.selected});

  Widget _buildStatItem(
      String label, IconData icon, String value, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      subtitle: Text(value, style: TextStyle(color: textColor)),
    );
  }

  Widget _buildAbilitiesStats(Map<String, int> abilities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: Icon(Icons.insert_chart, color: Colors.white),
          title: Text('Abilities', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sports_tennis, color: Colors.white),
          title: Text('Strength: ${abilities['STR']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run, color: Colors.white),
          title: Text('Dexterity: ${abilities['DEX']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.fitness_center, color: Colors.white),
          title: Text('Constitution: ${abilities['CON']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.white),
          title: Text('Intelligence: ${abilities['INT']}',
              style: const TextStyle(color: Colors.white)),
        ),
         ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.white),
          title: Text('Wisdom: ${abilities['WIS']}',
              style: const TextStyle(color: Colors.white)),
        ),
         ListTile(
          leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
          title: Text('Charisma: ${abilities['CHA']}',
              style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildSex(String sex){
    if (sex == 'Male'){
      return _buildStatItem('Sex', Icons.male, sex, Colors.white);
    }else{
      return _buildStatItem('Sex', Icons.female, sex, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      shape: selected
          ? new RoundedRectangleBorder(
              side: new BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(4.0))
          : new RoundedRectangleBorder(
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
              'Race', Icons.cruelty_free, character.race, Colors.white),
          _buildAbilitiesStats(character.abilities),
          _buildStatItem('Age', Icons.calendar_today,
              character.age.toString(), Colors.white),
          _buildStatItem("Alignment", Icons.account_balance,
              character.alignment, Colors.white),
          _buildStatItem('Height', Icons.height,
              character.height.toString(), Colors.white),
          _buildStatItem('Weight', Icons.line_weight, character.weight.toString(),
              Colors.white),
          _buildStatItem('Size', Icons.accessibility_new, character.size,
              Colors.white),
          _buildStatItem(
              'Traits', Icons.emoji_emotions, character.traits.join(', '), Colors.white),
          _buildStatItem('Languages', Icons.language, character.languages.join(', '),
              Colors.white),
          _buildStatItem('Character Class', Icons.account_box,
              character.characterClass, Colors.white),
          _buildStatItem('Description', Icons.description,
              character.description, Colors.white),
          _buildStatItem('hitDice', Icons.casino,
              character.hitDie, Colors.white),
          _buildStatItem('Proficiencies', Icons.emoji_objects,
              character.proficiencies.join(', '), Colors.white),
          _buildStatItem('Tools', Icons.backpack, character.tools.join(', '),
              Colors.white),
          _buildStatItem('Skills', Icons.sports_kabaddi,
              character.skills.join(', '), Colors.white),
          _buildStatItem('Equipment', Icons.shopping_bag,
              character.equipment.join(', '), Colors.white),
          _buildSex(character.sex),
          _buildStatItem('Background', Icons.book,
              character.background, Colors.white),
          _buildStatItem('Eyes Color', Icons.remove_red_eye,
              character.eyesColor, Colors.white),
          _buildStatItem('Hair Color', Icons.brush, character.hairColor,
              Colors.white),
          _buildStatItem('Skin Color', Icons.face, character.skinColor,
              Colors.white),
          _buildStatItem('Appearance', Icons.emoji_people, character.appearance, Colors.white),
        ],
      ),
    );
  }
}
