import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/models/aliens_character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/pages/profile_page.dart';
import 'package:role_maister/widgets/profile_aliens_characters_card.dart';
import 'package:role_maister/widgets/profile_cthulhu_characters_card.dart';
import 'package:role_maister/widgets/profile_dyd_characters_card.dart';

class CharactersTab extends StatefulWidget {
  const CharactersTab({Key? key}) : super(key: key);

  @override
  _CharactersTabState createState() => _CharactersTabState();
}

class _CharactersTabState extends State<CharactersTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: isSmallScreen
          ? const ProfileCharactersMobile()
          : const ProfileCharactersWeb(),
    );
  }
}

class ProfileCharactersWeb extends StatelessWidget {
  const ProfileCharactersWeb({super.key});

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot> cthulhuCharacters = [];
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;
    return const Row(
      children: [
        ProfileAliensCharacter(),
        ProfileDydCharacter(),
        ProfileCthulhuCharacter()
      ],
    );
  }
}

class ProfileAliensCharacter extends StatelessWidget {
  const ProfileAliensCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot> aliensCharacters = [];
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;
    return Expanded(
      child: Column(
        children: [
          isSmallScreen
              ? const SizedBox()
              : const Text(
                  "Aliens",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.fetchCharactersByMode(
                "aliens",
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  aliensCharacters = snapshot.data!.docs;
                  if (aliensCharacters.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      reverse: false,
                      itemBuilder: (context, index) {
                        if (index < aliensCharacters.length) {
                          var data = aliensCharacters[index].data()
                              as Map<String, dynamic>;
                            if (data['userId'] == singleton.player!.uid) {
                              AliensCharacter aliensCharacter =
                                  AliensCharacter.fromMap(
                                aliensCharacters[index].data()
                                    as Map<String, dynamic>,
                              );
                              return ProfileAliensCharacterCard(
                                character: aliensCharacter,
                              );
                            } else {
                              return const SizedBox();
                            }
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('You don\'t have any characters'),
                    );
                  }
                } else {
                  return Center(
                      child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/small_logo.png'),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ));
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CharactersCreationDialog(gameMode: "aliens");
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize:
                  isSmallScreen ? const Size(100, 30) : const Size(250, 40),
            ),
            child: Text(
              "Add Character",
              style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDydCharacter extends StatelessWidget {
  const ProfileDydCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot> dydCharacters = [];
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;
    return Expanded(
      child: Column(
        children: [
          isSmallScreen
              ? const SizedBox()
              : const Text(
                  "D&D",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.fetchCharactersByMode(
                "dyd",
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  dydCharacters = snapshot.data!.docs;
                  if (dydCharacters.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      reverse: false,
                      itemBuilder: (context, index) {
                        if (index < dydCharacters.length) {
                          var data = dydCharacters[index].data()
                              as Map<String, dynamic>;
                            if (data['userId'] == singleton.player!.uid) {
                              DydCharacter dydCharacter =
                                  DydCharacter.fromMap(
                                dydCharacters[index].data()
                                    as Map<String, dynamic>,
                              );
                              return ProfileDydCharacterCard(
                                character: dydCharacter,
                              );
                            } else {
                              return const SizedBox();
                            }
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('You don\'t have any characters'),
                    );
                  }
                } else {
                  return Center(
                      child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/small_logo.png'),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ));
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CharactersCreationDialog(gameMode: "dyd");
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize:
                  isSmallScreen ? const Size(100, 30) : const Size(250, 40),
            ),
            child: Text(
              "Add Character",
              style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCthulhuCharacter extends StatelessWidget {
  const ProfileCthulhuCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot> cthulhuCharacters = [];
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;
    return Expanded(
      child: Column(
        children: [
          isSmallScreen
              ? const SizedBox()
              : const Text(
                  "Cthulhu",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.fetchCharactersByMode(
                "cthulhu",
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  cthulhuCharacters = snapshot.data!.docs;
                  if (cthulhuCharacters.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      reverse: false,
                      itemBuilder: (context, index) {
                        if (index < cthulhuCharacters.length) {
                          var data = cthulhuCharacters[index].data()
                              as Map<String, dynamic>;
                            if (data['userId'] == singleton.player!.uid) {
                              CthulhuCharacter cthulhuCharacter =
                                  CthulhuCharacter.fromMap(
                                cthulhuCharacters[index].data()
                                    as Map<String, dynamic>,
                              );
                              return ProfileCthulhuCharacterCard(
                                character: cthulhuCharacter,
                              );
                            } else {
                              return const SizedBox();
                            }
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('You don\'t have any characters'),
                    );
                  }
                } else {
                  return Center(
                      child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/small_logo.png'),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ));
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CharactersCreationDialog(gameMode: "cthulhu");
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize:
                  isSmallScreen ? const Size(100, 30) : const Size(250, 40),
            ),
            child: Text(
              "Add Character",
              style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCharactersMobile extends StatelessWidget {
  const ProfileCharactersMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.transparent, // Border color
            width: 2.0, // Border width
          ),
          color: Colors.transparent,
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
                  Tab(text: 'Aliens'),
                  Tab(text: 'Dyd'),
                  Tab(text: 'Cthulhu'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ProfileAliensCharacter(),
                    ProfileDydCharacter(),
                    ProfileCthulhuCharacter()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}


class CharactersCreationDialog extends StatefulWidget {
  final String gameMode;
  CharactersCreationDialog({Key? key, required this.gameMode})
      : super(key: key);
  @override
  _CharactersCreationDialogState createState() =>
      _CharactersCreationDialogState();
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
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
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
            style: TextStyle(color: Colors.white),
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
  CharactersEditionOrDeletionDialog(
      {Key? key, required this.character, required this.isEdition})
      : super(key: key);
  @override
  _CharactersEditionOrDeletionDialogState createState() =>
      _CharactersEditionOrDeletionDialogState();
}

class _CharactersEditionOrDeletionDialogState
    extends State<CharactersEditionOrDeletionDialog> {
  TextEditingController characterNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      title: widget.isEdition
          ? const Text(
              'Enter your new character name',
              style: TextStyle(color: Colors.white),
            )
          : const Text(
              'Are you sure you want to delete this character?',
              style: TextStyle(color: Colors.white),
            ),
      content: widget.isEdition
          ? TextField(
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
            )
          : const SizedBox(),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
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
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}