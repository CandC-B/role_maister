import 'package:flutter/material.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/pages/profile_page.dart';
import 'package:role_maister/widgets/characters_tab.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/firebase_logic.dart';

class ProfileDydCharacterCard extends StatefulWidget {
  final DydCharacter character;
  const ProfileDydCharacterCard({super.key, required this.character});

  @override
  State<ProfileDydCharacterCard> createState() =>
      _ProfileDydCharacterCardState();
  showStats(DydCharacter character) {
    _ProfileDydCharacterCardState state = _ProfileDydCharacterCardState();
    return state._showStats(character);
  }
}

class _ProfileDydCharacterCardState extends State<ProfileDydCharacterCard> {
  bool isExpanded = false;

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

  Widget _buildSex(String sex) {
    if (sex == 'Male') {
      return _buildStatItem('Sex', Icons.male, sex, Colors.white);
    } else {
      return _buildStatItem('Sex', Icons.female, sex, Colors.white);
    }
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
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        title: Row(
          children: [
            const Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                widget.character.name,
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CharactersEditionOrDeletionDialog(
                        character: widget.character.toMap(), isEdition: true);
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CharactersEditionOrDeletionDialog(
                        character: widget.character.toMap(), isEdition: false);
                  },
                );
              },
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.white,
            ),
          ],
        ),
        children: [
          _buildStatItem('HP', Icons.favorite, widget.character.hp.toString(),
              Colors.white),
          _buildStatItem('Character Level', Icons.bar_chart,
              widget.character.characterLevel.toString(), Colors.white),
          _buildStatItem(
              'Race', Icons.cruelty_free, widget.character.race, Colors.white),
          _buildAbilitiesStats(widget.character.abilities),
          _buildStatItem('Age', Icons.calendar_today,
              widget.character.age.toString(), Colors.white),
          _buildStatItem("Alignment", Icons.account_balance,
              widget.character.alignment, Colors.white),
          _buildStatItem('Height', Icons.height,
              widget.character.height.toString(), Colors.white),
          _buildStatItem('Weight', Icons.line_weight,
              widget.character.weight.toString(), Colors.white),
          _buildStatItem('Size', Icons.accessibility_new, widget.character.size,
              Colors.white),
          _buildStatItem('Traits', Icons.emoji_emotions,
              widget.character.traits.join(', '), Colors.white),
          _buildStatItem('Languages', Icons.language,
              widget.character.languages.join(', '), Colors.white),
          _buildStatItem('Character Class', Icons.account_box,
              widget.character.characterClass, Colors.white),
          _buildStatItem('Description', Icons.description,
              widget.character.description, Colors.white),
          _buildStatItem(
              'hitDice', Icons.casino, widget.character.hitDie, Colors.white),
          _buildStatItem('Proficiencies', Icons.emoji_objects,
              widget.character.proficiencies.join(', '), Colors.white),
          _buildStatItem('Tools', Icons.backpack,
              widget.character.tools.join(', '), Colors.white),
          _buildStatItem('Skills', Icons.sports_kabaddi,
              widget.character.skills.join(', '), Colors.white),
          _buildStatItem('Equipment', Icons.shopping_bag,
              widget.character.equipment.join(', '), Colors.white),
          _buildSex(widget.character.sex),
          _buildStatItem('Background', Icons.book, widget.character.background,
              Colors.white),
          _buildStatItem('Eyes Color', Icons.remove_red_eye,
              widget.character.eyesColor, Colors.white),
          _buildStatItem('Hair Color', Icons.brush, widget.character.hairColor,
              Colors.white),
          _buildStatItem('Skin Color', Icons.face, widget.character.skinColor,
              Colors.white),
          _buildStatItem('Appearance', Icons.emoji_people,
              widget.character.appearance, Colors.white),
        ],
      ),
    );
  }

  Widget _showStats(DydCharacter character) {
    print("_showStats");
    return Column(
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
        _buildStatItem('Weight', Icons.line_weight,
            character.weight.toString(), Colors.white),
        _buildStatItem('Size', Icons.accessibility_new, character.size,
            Colors.white),
        _buildStatItem('Traits', Icons.emoji_emotions,
            character.traits.join(', '), Colors.white),
        _buildStatItem('Languages', Icons.language,
            character.languages.join(', '), Colors.white),
        _buildStatItem('Character Class', Icons.account_box,
            character.characterClass, Colors.white),
        _buildStatItem('Description', Icons.description,
            character.description, Colors.white),
        _buildStatItem(
            'hitDice', Icons.casino, character.hitDie, Colors.white),
        _buildStatItem('Proficiencies', Icons.emoji_objects,
            character.proficiencies.join(', '), Colors.white),
        _buildStatItem('Tools', Icons.backpack,
            character.tools.join(', '), Colors.white),
        _buildStatItem('Skills', Icons.sports_kabaddi,
            character.skills.join(', '), Colors.white),
        _buildStatItem('Equipment', Icons.shopping_bag,
            character.equipment.join(', '), Colors.white),
        _buildSex(character.sex),
        _buildStatItem('Background', Icons.book, character.background,
            Colors.white),
        _buildStatItem('Eyes Color', Icons.remove_red_eye,
            character.eyesColor, Colors.white),
        _buildStatItem('Hair Color', Icons.brush, character.hairColor,
            Colors.white),
        _buildStatItem(
            'Skin Color', Icons.face, character.skinColor, Colors.white),
        _buildStatItem('Appearance', Icons.emoji_people,
            character.appearance, Colors.white),
      ],
    );
  }
}
