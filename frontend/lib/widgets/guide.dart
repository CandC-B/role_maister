import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Guides extends StatefulWidget {
  const Guides({Key? key}) : super(key: key);

  @override
  _GuidesState createState() => _GuidesState();
}

class _GuidesState extends State<Guides> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            // 'assets/images/aliens_guide.png', // TODO: poner esta, no funciona
            'assets/images/dnd.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 200.0, vertical: 50.0),
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
            height: size.height - 150,
            // color: Colors.white70,
            child: const DefaultTabController(
              length: 3, // Número de pestañas
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.deepPurple,
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
            ),
          ),
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
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              'Setting',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Aliens Role Game is typically set in a futuristic, space-faring universe where humanity and various alien species coexist. Players can choose from a variety of character roles, from spacefaring explorers to alien diplomats or mercenaries.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Game System',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "The game often employs a rule system that combines storytelling, character development, and dice mechanics. Players create characters with unique attributes and skills, and they engage with the game world through narrative interactions and dice rolls.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Character Creation',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Players typically create characters by selecting a species (human or alien) and assigning attributes, skills, and backgrounds. These choices define a character's abilities and role in the game world.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Skills',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Skills are character abilities that represent a character's expertise or proficiency in specific areas. Here's how to use them effectively:\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    "Characters should have a list of skills, each associated with a specific aspect of the game (e.g., diplomacy, combat, technology).\n\n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    "The skills provide bonuses or advantages during relevant actions. For example, a character skilled in piloting might gain a bonus when flying a spaceship.\n\n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Talents',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Talents are unique, character-specific abilities or traits that can be used to gain advantages in the game.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // bullet points
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    "Specialized combat techniques, granting characters unique attacks or defenses.\n\n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    "Exceptional social talents like persuasion, intimidation, or diplomacy.\n\n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    "Technical talents for hacking, repair, or gadget creation.\n\n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Personal Agenda',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Personal agendas add depth to character development and role-playing. Each character can have their own personal goals, desires, and motivations that may conflict or align with the overarching story.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    "Encourage players to create personal agendas for their characters that align with the game's themes and narrative.\n\n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    "You may receive rewards, story hooks, or character development opportunities related to achieving personal agendas.\n\n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    "Use personal agendas to introduce character dilemmas, moral choices, and conflicts that enrich the storytelling experience.\n\n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Text(
              'Dice Mechanics',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "In Aliens Role Game, the dice mechanics provide a way to introduce uncertainty and randomness into the game, allowing players to determine the outcomes of character actions, combat, and various challenges.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Roll Types',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Decide on the types of dice to be used in the game. For example, you can use a standard six-sided die (D6) for simple skill checks, a ten-sided die (D10) for more complex actions, and a twenty-sided die (D20) for critical or significant events.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Skill Checks',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Link character abilities, skills, and attributes to specific dice rolls. For example, a character with high negotiation skills might roll a D10 and add their charisma attribute to determine the outcome of a diplomatic encounter.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Success Thresholds',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Define success thresholds for dice rolls. Players typically need to meet or exceed a target number (a 'success threshold') to succeed in their actions. The threshold can vary depending on the difficulty of the task.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Modifiers',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Consider incorporating modifiers that can influence dice rolls. These modifiers can come from a character's skills, equipment, environmental factors, or other in-game circumstances.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Critical Hits and Failures',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              'Include mechanics for critical successes and critical failures. For instance, rolling the highest possible number on the die might result in an extraordinary success, while rolling the lowest could lead to a catastrophic failure.\n\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Dice Pools',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              'Implement the concept of dice pools, where characters accumulate and roll multiple dice based on their abilities or advantages. The sum of the dice in the pool determines the result.\n\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Game Master',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "A Game Master (GM) guides the story and serves as the storyteller, controlling the non-player characters (NPCs), environments, and challenges that the player characters face. The GM helps to shape the narrative and adapt to player choices.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Alien Encounters',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Players frequently encounter a wide variety of alien species, each with unique characteristics, abilities, and cultures. Diplomacy, negotiation, and combat can all come into play when dealing with these extraterrestrial beings.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Exploration',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "The game encourages exploration of diverse alien worlds, space stations, and cosmic phenomena. This exploration often leads to the discovery of secrets, challenges, and new allies.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Conflict and Combat',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Combat may be an integral part of the game, with characters facing off against alien threats, pirates, or even other factions within the game universe. Use your equipment to defeat your enemies….and try not to panic too often, or you’ll lose your sanity. The system should create tension, simulate fast-paced action, and allow for strategic decision-making.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Initiative',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Determine the order of actions in combat by using an initiative system. This can be based on characters' speed, skills, or a simple roll of the dice.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Actions and Turns',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "In combat, each character takes a turn during which they can perform a set number of actions. Typical actions include attacking, moving, using items, or taking cover.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Attack Rolls',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "When a character attempts to attack, they make an attack roll using the designated combat dice (e.g., D20). The roll's outcome, along with modifiers, determines if the attack hits the target.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Damage and Health',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Determine the amount of damage dealt by successful attacks. Different weapons or abilities may have varying damage values. Characters have a set amount of health (hit points), and taking damage reduces their health.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Armor and Defense',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Characters may have armor or defensive abilities that reduce the damage taken. This adds strategy to combat as players must decide whether to prioritize defensive or offensive actions.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Critical Hits and Special Abilities',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Incorporate critical hit mechanics where a specific result (e.g., rolling a natural 20) leads to a critical hit, inflicting extra damage. Allow for character-specific special abilities that can be used in combat for unique effects.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Status Effects',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Introduce status effects, such as poison, bleeding, or stunned, which can affect characters during combat. Status effects can add complexity to battles.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Movement and Positioning',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              "Take into account character movement and positioning on the battlefield. Consider factors like cover, line of sight, and ranged combat ranges.\n\n",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Morale and Fleeing',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              'Characters may have a morale or bravery score that affects their combat performance. When characters witness disturbing events or are injured, their morale may drop, potentially causing them to flee or panic.\n\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Panic Mechanics',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            Text(
              textAlign: TextAlign.justify,
              'Panic mechanics add a psychological dimension to the Aliens Role Game, reflecting the stress and fear experienced by characters in intense or terrifying situations. Here\'s how panic can be integrated into the game\n\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Panic Threshold',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              'Assign a panic threshold for each character. This threshold represents how much stress or fear a character can withstand before panicking. It can be influenced by character attributes and backgrounds.\n\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Panic Triggers',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.justify,
              'Specify events or conditions that can trigger panic. These may include witnessing a horrific alien creature, being severely injured, or facing overwhelming odds in combat.\n\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Panic Effects',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
                textAlign: TextAlign.justify,
                'When a character\'s panic threshold is exceeded, they might suffer from panic effects. These effects could include:\n\n',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Reduced accuracy in combat.\n\n',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                      textAlign: TextAlign.justify,
                      'Impaired decision-making, causing characters to make irrational choices.\n\n',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                      textAlign: TextAlign.justify,
                      'A heightened likelihood of fleeing from danger.\n\n',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                      textAlign: TextAlign.justify,
                      'Increased vulnerability to status effects like fear or confusion.\n\n',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Recovery',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
                'Characters may have a chance to recover from panic over time, with support from other characters, or by taking specific actions to calm themselves.\n\n',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              'Role-Playing Opportunities',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
                'Feel encouraged to role-play your character’s fear and stress during panic situations. This adds depth to the narrative and immerses players in the game\'s atmosphere.\n\n',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
