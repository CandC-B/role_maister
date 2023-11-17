import 'package:firebase_auth/firebase_auth.dart';
import 'package:role_maister/models/cthulhu_character.dart';
import 'package:role_maister/models/dyd_character.dart';
import 'package:role_maister/models/player.dart';
import 'package:role_maister/models/models.dart';

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
  String? history;
  String? gameMode;
  String? selectedCharacterId;
  AliensCharacter? alienCharacter;
  DydCharacter? dydCharacter;
  CthulhuCharacter? cthulhuCharacter;
}
