import 'package:firebase_auth/firebase_auth.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/player.dart';
import 'package:role_maister/models/models.dart';
import 'package:flutter/material.dart';

AppSingleton singleton = AppSingleton();

class AppSingleton {
  AppSingleton._privateConstructor();

  static final AppSingleton _instance = AppSingleton._privateConstructor();

  factory AppSingleton() {
    return _instance;
  }

  User? user;
  Player? player;
  String? currentGame;
  String history = "";
  bool multiplayer = false;
  bool pairingMode = false;
  final ValueNotifier<String> gameMode = ValueNotifier<String>("aliens");
  String? selectedCharacterId;
  AliensCharacter alienCharacter = AliensCharacter.random();
  DydCharacter dydCharacter = DydCharacter.random();
  CthulhuCharacter cthulhuCharacter = CthulhuCharacter.random();
}
