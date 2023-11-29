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
                    // iterate through the list of documents
                    //
                    // for (var doc in aliensCharacters) {
                    //   var data = doc.data() as Map<String, dynamic>;
                    //   if (data['userId'] == singleton.player!.uid) {
                    //     AliensCharacter aliensCharacter =
                    //         AliensCharacter.fromMap(
                    //       doc.data() as Map<String, dynamic>,
                    //     );
                    //   }
                    // }

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
                  return CharactersDialog(gameMode: "aliens");
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
                      // controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index < dydCharacters.length) {
                          var data = dydCharacters[index].data()
                              as Map<String, dynamic>;
                          if (data['userId'] == singleton.player!.uid) {
                            DydCharacter dydCharacter = DydCharacter.fromMap(
                                dydCharacters[index].data()
                                    as Map<String, dynamic>);
                            return ProfileDydCharacterCard(
                              character: dydCharacter,
                            );
                          }

                          // return messageBubble(
                          //   chatContent: listMessages[index].get('text'),
                          //   messageType: listMessages[index].get('sentBy'),
                          // );
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
                  return CharactersDialog(gameMode: "dyd");
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
                      // controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index < cthulhuCharacters.length) {
                          var data = cthulhuCharacters[index].data()
                              as Map<String, dynamic>;
                          if (data['userId'] == singleton.player!.uid) {
                            CthulhuCharacter cthulhuCharacter =
                                CthulhuCharacter.fromMap(
                                    cthulhuCharacters[index].data()
                                        as Map<String, dynamic>);
                            return ProfileCthulhuCharacterCard(
                              character: cthulhuCharacter,
                            );
                          }

                          // return messageBubble(
                          //   chatContent: listMessages[index].get('text'),
                          //   messageType: listMessages[index].get('sentBy'),
                          // );
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
                  return CharactersDialog(gameMode: "dthulhu");
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
