import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          if (size.width > 700 && kIsWeb)
            Expanded(
              flex: 1,
              child: Container(
                height: size.height,
                child: GamePlayers(gameId: singleton.currentGame!),
              ),
            ),
          Expanded(
            // flex: 3,
            flex: size.width > 700 && kIsWeb ? 3 : 4,
            child: Container(
              height: size.height,
              child: GameChat(gameId: singleton.currentGame!),
            ),
          ),
        ],
      ),
      floatingActionButton: size.width <= 700 || !kIsWeb
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return AlertDialog(
                    //   content: GamePlayers(gameId: singleton.currentGame!),
                    // );
                    return GamePlayers(gameId: singleton.currentGame!);
                  },
                );
              },
              child: Icon(Icons.admin_panel_settings),
              backgroundColor: Colors.deepPurple,
            )
          : null, // No se muestra el botón flotante en pantallas grandes
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop, // Coloca el botón arriba a la derecha
    );
  }
}
