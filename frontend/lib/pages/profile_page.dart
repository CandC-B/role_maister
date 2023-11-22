import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/pages/profile_characters_page.dart';
import 'package:role_maister/widgets/aliens_characters_card.dart';
import 'package:role_maister/widgets/characters_tab.dart';
import 'package:role_maister/widgets/profile_aliens_characters_card.dart';
import 'package:role_maister/widgets/profile_cthulhu_characters_card.dart';
import 'package:role_maister/widgets/profile_dyd_characters_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// TODO Stream builder para que se actualice la pagina cuando se cree un character
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
                  color: Colors.deepPurple, // Border color
                  width: 2.0, // Border width
                ),
                color: Colors.white70,
              ),
              width: size.width,
              height: size.height - (isSmallScreen ? 100 : 150),
              // child: isSmallScreen
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
                        Tab(text: 'Profile'),
                        Tab(text: 'Characters'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [ProfileTab(), CharactersTab()],
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

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;
    return isSmallScreen
        ? 
                const SingleChildScrollView(
                    child: Column(
                  children: [
                    ProfileIcon(),
                    ProfileStats(),
                  ],
                ))
              
        : const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                SingleChildScrollView(
                  child: ProfileIcon(),
                ),
                SingleChildScrollView(
                  child: ProfileStats(),
                )
              ]);
  }
}

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 150,
          backgroundImage: AssetImage(
              'assets/images/bot_master.png'), // Replace with the path to your profile picture
        ),
        Text(
          singleton.player?.username ?? "John Doe",
          style: const TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Email: ', // Add user's location or other information
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.email ??
              "candcompany@gmail.com", // Add user's location or other information
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 20),
        const Text(
          'Games played: ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.tokens.toString() ?? "0",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 20),
        const Text(
          'Tokens left: ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.tokens.toString() ?? "0",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 20),
        const Text(
          'Experience: ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.experience.toString() ?? "0",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 50),
        Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.shade100,
                  spreadRadius: 10,
                  blurRadius: 20,
                )
              ]),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () => (),
            child: const SizedBox(
              width: 150,
              height: 40,
              child: Center(child: Text('Change Password')),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class TokenPackage {
  final String name;
  final double price;

  TokenPackage(this.name, this.price);
}

class CharacterCard extends StatelessWidget {
  final characterName;

  CharacterCard({required this.characterName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.deepPurple, // Change the border color to red
          width: 2.0, // Set the border width as needed
        ),
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the border radius as needed
      ),
      child: ListTile(
        title: Text(
          characterName,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        // subtitle: Text(
        //   '\$${tokenPackage.price.toStringAsFixed(2)}',
        //   style: const TextStyle(color: Colors.white, fontSize: 20),
        // ),
      ),
    );
  }
}

class CharactersDialog extends StatefulWidget {
  final String gameMode;
  CharactersDialog({Key? key, required this.gameMode}) : super(key: key);
  @override
  _CharactersDialogState createState() => _CharactersDialogState();
}

class _CharactersDialogState extends State<CharactersDialog> {
  TextEditingController characterNameController = TextEditingController();
  String gameMode = "";
  @override
  void initState() {
    super.initState();
    // Configurar el controlador con el valor inicial recibido
    gameMode = widget.gameMode;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Enter your new character name',
        style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: characterNameController,
        cursorColor: Colors.deepPurple,
        style: const TextStyle(color: Colors.deepPurple),
        decoration: const InputDecoration(
          hintText: 'Character name',
          hintStyle: TextStyle(color: Colors.deepPurple),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
              style: TextStyle(
                  color: Colors.deepPurple, fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () {
            if (gameMode == "Aliens") {
              createAlien(characterNameController.text);
            } else if (gameMode == "Dyd") {
              createDyd(characterNameController.text);
            } else if (gameMode == "Cthulhu") {
              createCthulhu(characterNameController.text);
            }
            Navigator.of(context).pop();
          },
          child: const Text(
            'Accept',
            style: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

void createAlien(String characterName) {
  singleton.gameMode.value = "Aliens";
  AliensCharacter newAlien = AliensCharacter.random();
  newAlien.name = characterName;
  firebase.createCharacter(newAlien.toMap());
}

void createDyd(String characterName) {
  singleton.gameMode.value = "Dyd";
  DydCharacter newDyd = DydCharacter.random();
  newDyd.name = characterName;
  firebase.createCharacter(newDyd.toMap());
}

void createCthulhu(String characterName) {
  singleton.gameMode.value = "Cthulhu";
  CthulhuCharacter newCthulhu = CthulhuCharacter.random();
  newCthulhu.name = characterName;
  firebase.createCharacter(newCthulhu.toMap());
}
