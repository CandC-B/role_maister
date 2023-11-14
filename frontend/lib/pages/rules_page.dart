import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background2.png'),
              fit: BoxFit.cover,
            ),
          ),
      child: Padding(
        padding: isMobile ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0) : const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.deepPurple, // Border color
              width: 2.0, // Border width
            ),
            color: Colors.white70,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(children: <Widget>[
              Text(
                'Rules',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Welcome to the Rules Section! Here, you'll quickly learn what you need to get started and have some fun!\n\n",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'How to play',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 10),
              Text(
                "To begin playing, simply press the 'Start Game' button and select the game mode (in this first version, only Singleplayer mode is available). Next, you can choose the role you want to play:\n\n"
                "Once you've chosen your game mode, you can configure your game. You'll need to provide a brief description of the story's setting that you want to follow (including the condition to end the game) and create your character sheet. Don't worry if you have no experience with this; the game can generate a character sheet for you—it does it all! (Currently, the game only provides auto-generated character sheets.)\n\n"
                "After this, if you have enough tokens to play, you can start your new campaign!\n\n",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Rules',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 10),
              Text(
                "This part is important. Since it's an AI that's responsible for guiding the game, and not a human, all players must commit to following certain guidelines to facilitate the flow of the game:\n\n"
                "Adhere to your character sheet: Remember your character's details and incorporate them into the conversation whenever possible to provide more context to the AI. Don't change your character's details unless instructed to do so.\n\n"
                "Don't make up dice rolls: The natural mechanism for role-playing is dice rolls. If you're asked to make a roll, don't make up the values. Embrace the randomness!\n\n"
                "Keep the AI in context: We trust you to follow the story provided by the AI. After all, it's not human. Correct when necessary, make decisions your character would make, and forge your own path, but don't diverge into unrelated topics. You might confuse the AI and disrupt the narrative.\n\n"
                "No cheating: We appeal to the goodwill of our players. If things go awry, don't hesitate to help the AI remember certain decisions and aspects of your character sheet.\n\n"
                "Behave as you would with your trusted Game Master: It's each player's responsibility to ensure it's an enjoyable and easy-to-follow game.\n\n"
                "Disclaimer: Since it's an external conversational AI, we're not responsible for the content of the conversations. We trust in you!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
