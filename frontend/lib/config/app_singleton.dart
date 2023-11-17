import 'package:firebase_auth/firebase_auth.dart';
import 'package:role_maister/models/models.dart';

AppSingleton singleton = AppSingleton();

class AppSingleton {
  AppSingleton._privateConstructor();

  static final AppSingleton _instance = AppSingleton._privateConstructor();

  factory AppSingleton() {
    return _instance;
  }

  User? user;
  String? currentGame;
  String? history;
  String? gameMode;
  String? selectedCharacterId;
  UserStatistics? selectedCharacter;
}
