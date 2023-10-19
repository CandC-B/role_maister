import 'package:flutter/material.dart';
import 'package:role_maister/config/app_router.dart';
import 'package:role_maister/screens/game_screen.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Role MAIster",
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}