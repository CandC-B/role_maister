import 'package:firebase_auth/firebase_auth.dart';

AppSingleton singleton = AppSingleton();


class AppSingleton {
  AppSingleton._privateConstructor();

  static final AppSingleton _instance = AppSingleton._privateConstructor();

  factory AppSingleton() {
    return _instance;
  }

  User? user;

}
