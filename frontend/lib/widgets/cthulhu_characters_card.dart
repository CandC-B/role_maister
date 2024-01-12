import 'package:flutter/material.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/widgets.dart';

class CthulhuCharacterCard extends StatelessWidget {
  final CthulhuCharacter character;
  final bool selected;

  CthulhuCharacterCard({super.key, required this.character, required this.selected});

  Widget _buildStatItem(
      String label, IconData icon, String value, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      subtitle: Text(value, style: TextStyle(color: textColor)),
    );
  }

  Widget _buildCharacteristicsStats(Map<String, int> characteristics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: Icon(Icons.insert_chart, color: Colors.white),
          title: Text('Attributes', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.fitness_center, color: Colors.white),
          title: Text('Strength: ${characteristics['STR']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.monitor_weight_outlined, color: Colors.white),
          title: Text('Constitution: ${characteristics['CON']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.hotel_class, color: Colors.white),
          title: Text('Power: ${characteristics['POW']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run, color: Colors.white),
          title: Text('Dexterity: ${characteristics['DEX']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.add_reaction, color: Colors.white),
          title: Text('Appearance: ${characteristics['APP']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.square_foot, color: Colors.white),
          title: Text('Size: ${characteristics['SIZ']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.white),
          title: Text('Intelligence: ${characteristics['INT']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.school, color: Colors.white),
          title: Text('Education: ${characteristics['EDU']}',
              style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildGender(String gender){
    if (gender == 'Male'){
      return _buildStatItem('Gender', Icons.male, gender, Colors.white);
    }else{
      return _buildStatItem('Gender', Icons.female, gender, Colors.white);
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
          // occupation
          _buildStatItem('Occupation', Icons.work, character.occupation.toString(), Colors.white),
          _buildGender(character.gender),
          _buildStatItem('Age', Icons.calendar_today, character.age.toString(), Colors.white),
          _buildCharacteristicsStats(character.characteristics),
          _buildStatItem('Bonus Damage', Icons.keyboard_double_arrow_up, character.bonusDamage.toString(), Colors.white),
          _buildStatItem('HP', Icons.favorite, character.hp.toString(), Colors.white),
          _buildStatItem('Sanity', Icons.psychology, character.sanity.toString(), Colors.white),
          _buildStatItem('MP', Icons.star, character.mp.toString(), Colors.white),
          _buildStatItem('Luck', Icons.casino, character.luck.toString(), Colors.white),
          _buildStatItem('Skills', Icons.sports_kabaddi, character.skills.toString().replaceAll(RegExp("[{}]"), ""), Colors.white),
          _buildStatItem('Weapons', Icons.kitesurfing_outlined, character.weapons.toString().replaceAll(RegExp("[{}]"), ""), Colors.white),
          _buildStatItem('Personal description', Icons.description, character.personalDescription.toString(), Colors.white),
          _buildStatItem('Ideology', Icons.church, character.ideology.toString(), Colors.white),
          _buildStatItem('Relatives', Icons.diversity_1, character.relatives.toString(), Colors.white),
          _buildStatItem('Significant Places', Icons.forest, character.significantPlaces.toString(), Colors.white),
          _buildStatItem('Prized Possessions', Icons.military_tech, character.prizedPossessions.toString(), Colors.white),
          _buildStatItem('Traits', Icons.back_hand_sharp, character.traits.toString(), Colors.white),
          _buildStatItem('Phobia', Icons.sentiment_very_dissatisfied_outlined, character.phobias.toString(), Colors.white),
          _buildStatItem('Mania', Icons.sentiment_dissatisfied_rounded, character.manias.toString(), Colors.white),
          _buildStatItem('Equipment', Icons.shopping_bag, character.equipment.toString(), Colors.white),

          // _buildStatItem('Character Level', Icons.bar_chart,
          //     character.characterLevel.toString(), Colors.white),
          // // age
          // _buildStatItem(
          //     'Career', Icons.school, character.career, Colors.white),
          // // characteristics
          // _buildAttributeStats(character.attributes),
          // // bonusDamage
          // _buildStatItem(
          //     'Skills',
          //     Icons.list,
          //     character.skills.toString().replaceAll(RegExp("[{}]"), ""),
          //     Colors.white),
          // _buildStatItem('Talents', Icons.star, character.talents.join(', '),
          //     Colors.white),
          // _buildStatItem(
          //     'Appearance', Icons.face, character.appearance, Colors.white),
          // _buildStatItem('Personal Agenda', Icons.assignment,
          //     character.personalAgenda, Colors.white),
          // _buildStatItem('Friend', Icons.sentiment_very_satisfied,
          //     character.friend, Colors.white),
          // _buildStatItem('Rival', Icons.sentiment_very_dissatisfied,
          //     character.rival, Colors.white),
          // _buildStatItem('Gear', Icons.accessibility, character.gear.join(', '),
          //     Colors.white),
          // _buildStatItem('Signature Item', Icons.edit, character.signatureItem,
          //     Colors.white),
          // _buildStatItem(
          //     'Cash', Icons.attach_money, '\$${character.cash}', Colors.white),
        ],
      ),
    );
  }
}
