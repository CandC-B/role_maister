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
                    AppLocalizations.of(context)!.guides_aliens_text5,
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
                    AppLocalizations.of(context)!.guides_aliens_text6,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
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
    return Stack(
      children: <Widget>[
        const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: <Widget>[
                // ... (el contenido anterior)
                Text(
                  "This part is important. Since it's an AI that's responsible for guiding the game, and not a human, all players must commit to following certain guidelines to facilitate the flow of the game:\n\n"
                  "Adhere to your character sheet: Remember your character's details and incorporate them into the conversation whenever possible to provide more context to the AI. Don't change your character's details unless instructed to do so.\n\n"
                  "Don't make up dice rolls: The natural mechanism for role-playing is dice rolls. If you're asked to make a roll, don't make up the values. Embrace the randomness!\n\n"
                  "Keep the AI in context: We trust you to follow the story provided by the AI. After all, it's not human. Correct when necessary, make decisions your character would make, and forge your own path, but don't diverge into unrelated topics. You might confuse the AI and disrupt the narrative.\n\n",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Transform.rotate(
                angle: -atan(200 / 200),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "COMING SOON",
                    style: TextStyle(
                      fontSize: 5,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CthulhuTab extends StatelessWidget {
  const CthulhuTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: <Widget>[
                // ... (el contenido anterior)
                Text(
                  "This part is important. Since it's an AI that's responsible for guiding the game, and not a human, all players must commit to following certain guidelines to facilitate the flow of the game:\n\n"
                  "Adhere to your character sheet: Remember your character's details and incorporate them into the conversation whenever possible to provide more context to the AI. Don't change your character's details unless instructed to do so.\n\n"
                  "Don't make up dice rolls: The natural mechanism for role-playing is dice rolls. If you're asked to make a roll, don't make up the values. Embrace the randomness!\n\n"
                  "Keep the AI in context: We trust you to follow the story provided by the AI. After all, it's not human. Correct when necessary, make decisions your character would make, and forge your own path, but don't diverge into unrelated topics. You might confuse the AI and disrupt the narrative.\n\n",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Transform.rotate(
                angle: -atan(200 / 200),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "COMING SOON",
                    style: TextStyle(
                      fontSize: 5,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
