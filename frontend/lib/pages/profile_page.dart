import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/game.dart';
import 'package:role_maister/widgets/characters_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:role_maister/widgets/profile_tab.dart';
import 'package:role_maister/widgets/resume_game_tab.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            horizontal: isSmallScreen ? 10.0 : 50.0,
            vertical: isSmallScreen ? 20.0 : 50.0,
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
                color: Colors.white70,
              ),
              width: size.width,
              height: size.height - (isSmallScreen ? 100 : 150),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.deepPurple,
                      isScrollable: true,
                      labelColor: Colors.deepPurple,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      tabs: [
                        Tab(text: AppLocalizations.of(context)!.profile),
                        Tab(text: AppLocalizations.of(context)!.characters),
                        Tab(text: AppLocalizations.of(context)!.games),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          const ProfileTab(),
                          const CharactersTab(),
                          ResumeGameTab()
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



// class CharacterCard extends StatelessWidget {
//   final characterName;

//   CharacterCard({required this.characterName});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.deepPurple,
//       shape: RoundedRectangleBorder(
//         side: const BorderSide(
//           color: Colors.deepPurple,
//           width: 2.0,
//         ),
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: ListTile(
//         title: Text(
//           characterName,
//           style: const TextStyle(color: Colors.white, fontSize: 24),
//         ),
//         // subtitle: Text(
//         //   '\$${tokenPackage.price.toStringAsFixed(2)}',
//         //   style: const TextStyle(color: Colors.white, fontSize: 20),
//         // ),
//       ),
//     );
//   }
// }
