import 'package:flutter/material.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/pages/profile_page.dart';
import 'package:role_maister/widgets/characters_tab.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Widget _buildAbilitiesStats(Map<String, int> abilities, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.insert_chart, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.cards_dnd_text1, style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sports_tennis, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.cards_dnd_text2 + ': ${abilities['STR']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.cards_dnd_text3 + ': ${abilities['DEX']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.fitness_center, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.cards_dnd_text4 + ': ${abilities['CON']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.cards_dnd_text5 + ': ${abilities['INT']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.cards_dnd_text6 + ': ${abilities['WIS']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.cards_dnd_text7 + ': ${abilities['CHA']}',
              style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildSex(String sex, BuildContext context) {
    if (sex == AppLocalizations.of(context)!.cards_dnd_text8) {
      return _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text9, Icons.male, sex, Colors.white);
    } else {
      return _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text9, Icons.female, sex, Colors.white);
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
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text10, Icons.favorite, widget.character.hp.toString(),
              Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text11, Icons.bar_chart,
              widget.character.characterLevel.toString(), Colors.white),
          _buildStatItem(
              AppLocalizations.of(context)!.cards_dnd_text12, Icons.cruelty_free, widget.character.race, Colors.white),
          _buildAbilitiesStats(widget.character.abilities, context),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text13, Icons.calendar_today,
              widget.character.age.toString(), Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text14, Icons.account_balance,
              widget.character.alignment, Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text15, Icons.height,
              widget.character.height.toString(), Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text16, Icons.line_weight,
              widget.character.weight.toString(), Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text17, Icons.accessibility_new, widget.character.size,
              Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text18, Icons.emoji_emotions,
              widget.character.traits.join(', '), Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text19, Icons.language,
              widget.character.languages.join(', '), Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text20, Icons.account_box,
              widget.character.characterClass, Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text21, Icons.description,
              widget.character.description, Colors.white),
          _buildStatItem(
              AppLocalizations.of(context)!.cards_dnd_text22, Icons.casino, widget.character.hitDie, Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text23, Icons.emoji_objects,
              widget.character.proficiencies.join(', '), Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text24, Icons.backpack,
              widget.character.tools.join(', '), Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text25, Icons.sports_kabaddi,
              widget.character.skills.join(', '), Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text26, Icons.shopping_bag,
              widget.character.equipment.join(', '), Colors.white),
          _buildSex(widget.character.sex, context),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text27, Icons.book, widget.character.background,
              Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text28, Icons.remove_red_eye,
              widget.character.eyesColor, Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text29, Icons.brush, widget.character.hairColor,
              Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text30, Icons.face, widget.character.skinColor,
              Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text31, Icons.emoji_people,
              widget.character.appearance, Colors.white),
        ],
      ),
    );
  }

  Widget _showStats(DydCharacter character) {
    return SingleChildScrollView(child: Column(
      children: [
        _buildStatItem(
            AppLocalizations.of(context)!.cards_dnd_text10, Icons.favorite, character.hp.toString(), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text11, Icons.bar_chart,
            character.characterLevel.toString(), Colors.white),
        _buildStatItem(
            AppLocalizations.of(context)!.cards_dnd_text12, Icons.cruelty_free, character.race, Colors.white),
        _buildAbilitiesStats(character.abilities, context),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text13, Icons.calendar_today,
            character.age.toString(), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text14, Icons.account_balance,
            character.alignment, Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text15, Icons.height,
            character.height.toString(), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text16, Icons.line_weight,
            character.weight.toString(), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text17, Icons.accessibility_new, character.size,
            Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text18, Icons.emoji_emotions,
            character.traits.join(', '), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text19, Icons.language,
            character.languages.join(', '), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text20, Icons.account_box,
            character.characterClass, Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text21, Icons.description,
            character.description, Colors.white),
        _buildStatItem(
            AppLocalizations.of(context)!.cards_dnd_text22, Icons.casino, character.hitDie, Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text23, Icons.emoji_objects,
            character.proficiencies.join(', '), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text24, Icons.backpack,
            character.tools.join(', '), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text25, Icons.sports_kabaddi,
            character.skills.join(', '), Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text26, Icons.shopping_bag,
            character.equipment.join(', '), Colors.white),
        _buildSex(character.sex, context),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text27, Icons.book, character.background,
            Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text28, Icons.remove_red_eye,
            character.eyesColor, Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text29, Icons.brush, character.hairColor,
            Colors.white),
        _buildStatItem(
            AppLocalizations.of(context)!.cards_dnd_text30, Icons.face, character.skinColor, Colors.white),
        _buildStatItem(AppLocalizations.of(context)!.cards_dnd_text31, Icons.emoji_people,
            character.appearance, Colors.white),
      ],
    ),);
    
    
  }
}
