import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Guides extends StatefulWidget {
  const Guides({Key? key}) : super(key: key);

  @override
  _GuidesState createState() => _GuidesState();
}

class _GuidesState extends State<Guides> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/aliens_guide.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20.0 : 100.0,
            vertical: isSmallScreen ? 20.0 : 50.0,
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.deepPurple, // Border color
                  width: 2.0, // Border width
                ),
                color: Colors.white70,
              ),
              width: size.width,
              height: size.height - (isSmallScreen ? 100 : 150),
              // child: isSmallScreen
              //     ? const DefaultTabController(
              child: const DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.deepPurple,
                      isScrollable: true,
                      labelColor: Colors.deepPurple,
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      tabs: [
                        Tab(text: 'Aliens'),
                        Tab(text: 'DnD'),
                        Tab(text: 'Cthulhu'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          AliensTab(),
                          DnDTab(),
                          CthulhuTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

// Tabs
class AliensTab extends StatelessWidget {
  const AliensTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            Text(
              AppLocalizations.of(context)!.guides_settings,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text1,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_game_system,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text2,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_character_creation,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text3,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_skills,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text4,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
           const SizedBox(height: 10),
            const Text(
              'Talents',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text7,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // bullet points
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_aliens_text8,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_aliens_text9,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_aliens_text10,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_personal_agenda,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text11,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_aliens_text12,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_aliens_text13,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_aliens_text14,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.guides_dice_mechanics,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text15,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_roll_types,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text16,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_skill_checks,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text17,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_success_thresholds,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text18,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_modifiers,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text19,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_critical_hits_and_failures,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text20,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dice_pools,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text21,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_game_master,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text22,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_alien_encounters,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text23,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_exploration,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text24,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_conflict_and_combat,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text25,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_initiative,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text26,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_actions_and_turns,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text27,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_attack_rolls,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text28,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_damage_and_health,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text29,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_armor_and_defense,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text30,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!
                  .guides_critical_hits_and_special_abilities,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text31,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_status_effects,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text32,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_movement_and_positioning,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text33,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_morale_and_fleeing,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text34,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_panic_mechanics,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text35,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.guides_panic_threshold,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text36,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_panic_triggers,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_aliens_text37,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_panic_effects,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
                textAlign: TextAlign.justify,
                AppLocalizations.of(context)!.guides_aliens_text38,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                      AppLocalizations.of(context)!.guides_aliens_text39,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                      textAlign: TextAlign.justify,
                      AppLocalizations.of(context)!.guides_aliens_text40,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                      textAlign: TextAlign.justify,
                      AppLocalizations.of(context)!.guides_aliens_text41,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                      textAlign: TextAlign.justify,
                      AppLocalizations.of(context)!.guides_aliens_text42,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_recovery,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(AppLocalizations.of(context)!.guides_aliens_text43,
                textAlign: TextAlign.justify,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_role_playing_opportunities,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(AppLocalizations.of(context)!.guides_aliens_text44,
                textAlign: TextAlign.justify,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class DnDTab extends StatelessWidget {
  const DnDTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
              const SizedBox(height: 40),
              Text(
              AppLocalizations.of(context)!.guides_dnd_text1,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_dnd_text2,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text3,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_dnd_text4,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text5,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text6,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text7,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text8,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text9,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text10,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text11,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text12,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text13,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text14,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text15,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text16,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text17,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text18,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text19,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text20,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text21,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text22,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text23,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text24,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text25,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text26,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text27,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text28,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text29,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text30,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text31,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text32,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text33,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_dnd_text34,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_dnd_text35,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_dnd_text36,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ],
        ),
      ),
    );

    // );
  }
}

class CthulhuTab extends StatelessWidget {
  const CthulhuTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
              const SizedBox(height: 40),
              Text(
              AppLocalizations.of(context)!.guides_cthulhu_text1,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_cthulhu_text2,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text3,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_cthulhu_text4,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text5,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text6,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text7,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text8,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text9,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text10,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text11,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text12,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text13,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text14,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text15,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text16,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text17,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text18,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text19,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text20,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text21,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text22,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text23,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text24,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text25,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text26,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text27,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text28,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text29,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text30,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text31,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text32,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text33,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text34,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.guides_cthulhu_text35,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    AppLocalizations.of(context)!.guides_cthulhu_text36,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              textAlign: TextAlign.justify,
              AppLocalizations.of(context)!.guides_cthulhu_text37,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ],
        ),
      ),
    );
  }
}
