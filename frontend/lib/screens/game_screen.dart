import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const GameScreen()
      );
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GamePage(),
    );
  }
}