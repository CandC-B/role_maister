import 'package:flutter/material.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AliensCharacterCard extends StatelessWidget {
  final AliensCharacter character;
  final bool selected;

  AliensCharacterCard({super.key, required this.character, required this.selected});

  Widget _buildStatItem(
      String label, IconData icon, String value, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      subtitle: Text(value, style: TextStyle(color: textColor)),
    );
  }

  Widget _buildAttributeStats(Map<String, int> attributes, BuildContext context) {
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
          title: Text(AppLocalizations.of(context)!.aliens_strength + ': ${attributes['Strength']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.aliens_agility + ': ${attributes['Agility']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.aliens_empathy + ': ${attributes['Empathy']}',
              style: const TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.white),
          title: Text(AppLocalizations.of(context)!.aliens_wits + ': ${attributes['Wits']}',
              style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
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
              AppLocalizations.of(context)!.aliens_hp,
              Icons.favorite, character.hp.toString(), Colors.white),
          // _buildStatItem('Character Level', 
          _buildStatItem(AppLocalizations.of(context)!.aliens_character_level,
          Icons.bar_chart,
              character.characterLevel.toString(), Colors.white),
          _buildStatItem(
              AppLocalizations.of(context)!.aliens_career,
              Icons.school, character.career, Colors.white),
          _buildAttributeStats(character.attributes, context),
          _buildStatItem(
              AppLocalizations.of(context)!.aliens_skills,
              Icons.list,
              character.skills.toString().replaceAll(RegExp("[{}]"), ""),
              Colors.white),
          _buildStatItem(AppLocalizations.of(context)!.aliens_talents,
          Icons.star, character.talents.join(', '),
              Colors.white),
          _buildStatItem(
              // 'Appearance', 
              AppLocalizations.of(context)!.aliens_appearance,
              Icons.face, character.appearance, Colors.white),
          // _buildStatItem('Personal Agenda', 
          _buildStatItem(AppLocalizations.of(context)!.aliens_personal_agenda,
          Icons.assignment,
              character.personalAgenda, Colors.white),
          // _buildStatItem('Friend', 
          _buildStatItem(AppLocalizations.of(context)!.aliens_friend,
          Icons.sentiment_very_satisfied,
              character.friend, Colors.white),
          // _buildStatItem('Rival', 
          _buildStatItem(AppLocalizations.of(context)!.aliens_rival,
          Icons.sentiment_very_dissatisfied,
              character.rival, Colors.white),
          // _buildStatItem('Gear', 
          _buildStatItem(AppLocalizations.of(context)!.aliens_gear,
          Icons.accessibility, character.gear.join(', '),
              Colors.white),
          // _buildStatItem('Signature Item', 
          _buildStatItem(AppLocalizations.of(context)!.aliens_signature_item,
          Icons.edit, character.signatureItem,
              Colors.white),
          _buildStatItem(
              AppLocalizations.of(context)!.aliens_cash, 
              Icons.attach_money, '\$${character.cash}', Colors.white),
        ],
      ),
    );
  }
}
