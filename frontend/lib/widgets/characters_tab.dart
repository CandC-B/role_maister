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
  List<QueryDocumentSnapshot> aliensCharacters = [];
  List<QueryDocumentSnapshot> dydCharacters = [];
  List<QueryDocumentSnapshot> cthulhuCharacters = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;

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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestoreService.fetchCharactersByUserId(
                      singleton.user!.uid,
                      "Aliens",
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
                                AliensCharacter aliensCharacter =
                                    AliensCharacter.fromMap(
                                  aliensCharacters[index]
                                      .data() as Map<String, dynamic>,
                                );
                                return ProfileAliensCharacterCard(
                                  character: aliensCharacter,
                                );
                              }
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('No messages...'),
                          );
                        }
                      } else {
                        return Center(
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child:
                                  Image.asset('assets/images/small_logo.png'),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CharactersDialog(gameMode: "Aliens");
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: isSmallScreen
                        ? const Size(100, 30)
                        : const Size(250, 40),
                  ),
                  child: Text(
                    "Add Character",
                    style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "D&D",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestoreService.fetchCharactersByUserId(
                      singleton.user!.uid,
                      "Dyd",
                    ),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        dydCharacters = snapshot.data!.docs;
                        if (dydCharacters.isNotEmpty) {
                          return ListView.builder(
                            padding: const EdgeInsets.all(10),
                            reverse: false,
                            // controller: scrollController,
                            itemBuilder: (context, index) {
                              if (index < dydCharacters.length) {
                                DydCharacter dydCharacter =
                                    DydCharacter.fromMap(dydCharacters[index]
                                        .data() as Map<String, dynamic>);
                                return ProfileDydCharacterCard(
                                  character: dydCharacter,
                                );
                                // return messageBubble(
                                //   chatContent: listMessages[index].get('text'),
                                //   messageType: listMessages[index].get('sentBy'),
                                // );
                              }
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('No messages...'),
                          );
                        }
                      } else {
                        return Center(
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child:
                                  Image.asset('assets/images/small_logo.png'),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CharactersDialog(gameMode: "Dyd");
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: isSmallScreen
                        ? const Size(100, 30)
                        : const Size(250, 40),
                  ),
                  child: Text(
                    "Add Character",
                    style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                  ),
                ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestoreService.fetchCharactersByUserId(
                      singleton.user!.uid,
                      "Cthulhu",
                    ),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                      cthulhuCharacters = snapshot.data!.docs;
                      if (cthulhuCharacters.isNotEmpty) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(10),
                          reverse: false,
                          // controller: scrollController,
                          itemBuilder: (context, index) {
                            if (index < cthulhuCharacters.length) {
                              CthulhuCharacter cthulhuCharacter =
                                  CthulhuCharacter.fromMap(cthulhuCharacters[index]
                                      .data() as Map<String, dynamic>);
                              return ProfileCthulhuCharacterCard(
                                character: cthulhuCharacter,
                              );
                              // return messageBubble(
                              //   chatContent: listMessages[index].get('text'),
                              //   messageType: listMessages[index].get('sentBy'),
                              // );
                            }
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No messages...'),
                        );
                      }
                    } else {
                      return Center(
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Image.asset('assets/images/small_logo.png'),
                          ),
                        ),
                      );
                    }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CharactersDialog(gameMode: "Cthulhu");
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: isSmallScreen
                        ? const Size(100, 30)
                        : const Size(250, 40),
                  ),
                  child: Text(
                    "Add Character",
                    style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
