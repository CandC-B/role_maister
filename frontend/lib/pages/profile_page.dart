import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/widgets/characters_tab.dart';

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
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
                color: Colors.white70,
              ),
              width: size.width,
              height: size.height - (isSmallScreen ? 100 : 150),
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
              'assets/images/bot_master.png'),
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
          'Email: ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.email ??
              "candcompany@gmail.com",
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
          color: Colors.deepPurple,
          width: 2.0,
        ),
        borderRadius:
            BorderRadius.circular(12.0),
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

class CharactersCreationDialog extends StatefulWidget {
  final String gameMode;
  CharactersCreationDialog({Key? key, required this.gameMode}) : super(key: key);
  @override
  _CharactersCreationDialogState createState() => _CharactersCreationDialogState();
}

class _CharactersCreationDialogState extends State<CharactersCreationDialog> {
  TextEditingController characterNameController = TextEditingController();
  String gameMode = "";
  @override
  void initState() {
    super.initState();
    gameMode = widget.gameMode;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      title: const Text(
        'Enter your new character name',
        style: TextStyle(color: Colors.white),
      ),
      content: TextField(
        controller: characterNameController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Character name',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
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
                  color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            if (gameMode == "aliens") {
              createAlien(characterNameController.text);
            } else if (gameMode == "dyd") {
              createDyd(characterNameController.text);
            } else if (gameMode == "cthulhu") {
              createCthulhu(characterNameController.text);
            }
            Navigator.of(context).pop();
          },
          child: const Text(
            'Accept',
            style: TextStyle(
                color: Colors.white),
          ),
        )
      ],
    );
  }
}



void createAlien(String characterName) {
  singleton.gameMode.value = "aliens";
  AliensCharacter newAlien = AliensCharacter.random();
  newAlien.name = characterName;
  newAlien.userId = singleton.user!.uid;
  firebase.createCharacter(newAlien.toMap());
}

void createDyd(String characterName) {
  singleton.gameMode.value = "dyd";
  DydCharacter newDyd = DydCharacter.random();
  newDyd.name = characterName;
  newDyd.userId = singleton.user!.uid;
  firebase.createCharacter(newDyd.toMap());
}

void createCthulhu(String characterName) {
  singleton.gameMode.value = "cthulhu";
  CthulhuCharacter newCthulhu = CthulhuCharacter.random();
  newCthulhu.name = characterName;
  newCthulhu.userId = singleton.user!.uid;
  firebase.createCharacter(newCthulhu.toMap());
}

class CharactersEditionOrDeletionDialog extends StatefulWidget {
  final Map<String, dynamic> character;
  final bool isEdition;
  CharactersEditionOrDeletionDialog({Key? key, required this.character, required this.isEdition}) : super(key: key);
  @override
  _CharactersEditionOrDeletionDialogState createState() => _CharactersEditionOrDeletionDialogState();
}

class _CharactersEditionOrDeletionDialogState extends State<CharactersEditionOrDeletionDialog> {
  TextEditingController characterNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      title: widget.isEdition ? 
      const Text(
        'Enter your new character name',
        style: TextStyle(color: Colors.white),
      )
      : const Text(
        'Are you sure you want to delete this character?',
        style: TextStyle(color: Colors.white),
      ),
      content: widget.isEdition ? TextField(
        controller: characterNameController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Character name',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ) : const SizedBox(),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
              style: TextStyle(
                  color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            if (widget.isEdition) {
              widget.character['name'] = characterNameController.text;
              firebase.updateCharacter(widget.character);
            } else {
              firebase.deleteCharacter(widget.character);
            }
            Navigator.of(context).pop();
          },
          child: const Text(
            'Accept',
            style: TextStyle(
                color: Colors.white),
          ),
        )
      ],
    );
  }
}