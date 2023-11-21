import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;
    
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dnd.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
          padding:
              isMobile
                  ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0)
                  : const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.deepPurple, // Border color
                width: 2.0, // Border width
              ),
              color: Colors.white70,
            ),
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100,
                    backgroundImage: AssetImage(
                        'assets/images/small_logo.png'), // Reemplaza con la ubicación de tu imagen de perfil
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'C & Company - B',
                    style: TextStyle(
                      fontSize: isMobile ? 30 : 44,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    // 'At our core, we are a dedicated group of passionate role-playing enthusiasts who share a common goal: to make the enchanting world of role-playing games accessible to everyone. We believe that the magic of storytelling and immersive adventures should be within reach of all who yearn for the thrill of creating and embarking on epic quests. Whether you are a seasoned veteran or a complete novice, our mission is to provide the tools, guidance, and resources to help you dive into the captivating realm of role-playing games. We are here to foster creativity, spark imaginations, and build a welcoming community where the wonders of role-playing are celebrated.',
                    AppLocalizations.of(context)!.aboutUs_text1,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 60),
                  Text(
                    // 'Our journey is fueled by a deep-rooted love for storytelling, a commitment to inclusivity, and a desire to connect with like-minded individuals who share our passion. With a wealth of experience and boundless enthusiasm, we endeavor to break down barriers, simplify the learning curve, and empower you to embark on your own unique adventures. Whether you are a dungeon master, a player, or someone just curious about this captivating world, join us on this epic quest as we strive to make role-playing games a delightful and accessible experience for all.',
                    AppLocalizations.of(context)!.aboutUs_text2,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          )),
    );
  }
}
