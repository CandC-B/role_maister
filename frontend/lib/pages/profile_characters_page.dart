import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/models/character.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/widgets/cthulhu_characters_card.dart';
import 'package:role_maister/widgets/dyd_characters_card.dart';
import 'package:role_maister/widgets/profile_aliens_characters_card.dart';
import 'package:role_maister/widgets/profile_cthulhu_characters_card.dart';
import 'package:role_maister/widgets/profile_dyd_characters_card.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'dart:convert';

class ProfileCharacterPage extends StatefulWidget {
  final String mode;

  const ProfileCharacterPage({super.key, required this.mode});

  @override
  State<ProfileCharacterPage> createState() =>
      _ProfileCharacterPageState();
}

class _ProfileCharacterPageState extends State<ProfileCharacterPage> {
  Map<String, dynamic>? charactersData;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    firebase.getUserCharactersFromMode(singleton.user!.uid, "aliens");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: !kIsWeb
          ? const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.png'),
                fit: BoxFit.cover,
              ),
            )
          : const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          Expanded(
              child: ValueListenableBuilder<String>(
            valueListenable: singleton.gameMode,
            builder: (BuildContext context, String mode, child) {
              return FutureBuilder<Map<String, dynamic>>(
                  future: firebase.getUserCharactersFromMode(singleton.user!.uid, widget.mode),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Image.asset('assets/images/small_logo.png'),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // Handle the error
                      return Text(
                          'Error loading character data: ${snapshot.error}');
                    } else {
                      charactersData = snapshot.data;
                      // Data loaded successfully, build the list
                      return ListView.builder(
                        itemCount: charactersData!.length,
                        itemBuilder: (context, index) {
                          final characterId =
                              charactersData!.keys.elementAt(index);
                          final characterData = charactersData![characterId];
                          singleton.selectedCharacterId =
                              charactersData!.keys.elementAt(selectedIndex);
                          if (widget.mode == "aliens") {
                            singleton.alienCharacter = AliensCharacter.fromMap(
                                charactersData![charactersData!.keys
                                    .elementAt(selectedIndex)]);
                            return InkWell(

                             
                              child: ProfileAliensCharacterCard(
                                character:
                                    AliensCharacter.fromMap(characterData)
                              ),
                            );
                          } else if (widget.mode == "Dyd") {
                            singleton.dydCharacter = DydCharacter.fromMap(
                                charactersData![charactersData!.keys
                                    .elementAt(selectedIndex)]);
                            return InkWell(
                              child: ProfileDydCharacterCard(
                                character: DydCharacter.fromMap(characterData)
                              ),
                            );
                          } else if (widget.mode == "Cthulhu") {
                            singleton.cthulhuCharacter =
                                CthulhuCharacter.fromMap(charactersData![
                                    charactersData!.keys
                                        .elementAt(selectedIndex)]);
                            return InkWell(
                              child: ProfileCthulhuCharacterCard(
                                character:
                                    CthulhuCharacter.fromMap(characterData)
                              ),
                            );
                          } else {
                            singleton.alienCharacter = AliensCharacter.fromMap(
                                charactersData![charactersData!.keys
                                    .elementAt(selectedIndex)]);
                            return InkWell(
                              child: ProfileAliensCharacterCard(
                                character:
                                    AliensCharacter.fromMap(characterData),
                              ),
                            );
                          }
                        },
                      );
                    }
                  });
            },
          )),
        ],
      ),
    );
  }
}
