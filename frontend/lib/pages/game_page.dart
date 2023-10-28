import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/config.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: size.height,
              child: GamePlayers(gameId: singleton.currentGame!),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: size.height,
              child: GameChat(gameId: singleton.currentGame!),
            ),
          ),
        ],
      ),
    );
  }
}
