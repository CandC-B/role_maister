import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/widgets/widgets.dart';

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
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
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
                        children: [const ProfileTab(), CharactersTab()],
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
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SingleChildScrollView(
                    child: ProfileIcon(),
                  ),
                  SingleChildScrollView(
                    child: ProfileStats(),
                  )
                ] // Add more user information as needed
                )));
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
          width: 300,
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
              width: double.infinity,
              height: 50,
              child: Center(child: Text('Change Password')),
            ),
          ),
        ),
      ],
    );
  }
}

class CharactersTab extends StatelessWidget {
  final List<AliensCharacter> aliensCharacters = [];
  final List<DydCharacter> dydCharacters = [];
  final List<CthulhuCharacter> cthulhuCharacters = [];

  CharactersTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController characterNameController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Aliens",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: aliensCharacters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(character: aliensCharacters[index]);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CharactersDialog();
                        });
                  },
                  child: const Text(
                    "Add Character",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(250, 40)),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Dungeons and dragons",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: aliensCharacters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(character: aliensCharacters[index]);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CharactersDialog();
                        });
                  },
                  child: const Text(
                    "Add Character",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(250, 40)),
                )
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              const Text(
                "Cthulhu",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: aliensCharacters.length,
                  itemBuilder: (context, index) {
                    return CharacterCard(character: aliensCharacters[index]);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CharactersDialog();
                        });
                },
                child: const Text(
                  "Add Character",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(250, 40)),
              )
            ],
          ))
        ],
      ),
    );
  }
}

class TokenPackage {
  final String name;
  final double price;

  TokenPackage(this.name, this.price);
}

class CharacterCard extends StatelessWidget {
  final character;

  CharacterCard({required this.character});

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
          character.name,
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
  @override
  _CharactersDialogState createState() => _CharactersDialogState();
}

class _CharactersDialogState extends State<CharactersDialog> {
  TextEditingController characterNameController = TextEditingController();

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
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            String characterName = characterNameController.text;
            // Do something with the character name, like saving it to a list
            Navigator.of(context).pop();
          },
          child: const Text('Accept', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}