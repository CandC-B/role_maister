import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/config/config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GamePage extends StatelessWidget {
  const GamePage({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Function to show the dialog
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GamePlayers(gameId: singleton.currentGame!);
        },
      );
    }

    return Scaffold(
      appBar: size.width <= 700 || !kIsWeb
          ? AppBar(
              automaticallyImplyLeading: false,
              title: StreamBuilder<double>(
                stream: firebase.getUserSpendingStream(
                  singleton.currentGame!,
                  singleton.user!.uid,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(
                      'MAIster tokens spent: ${snapshot.data?.toString() ?? "N/A"}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width > 700 || kIsWeb ? 16.0 : 12.0,
                      ),
                    );
                  }
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.admin_panel_settings),
                  onPressed: _showDialog,
                ),
              ],
              backgroundColor: Colors.deepPurple,
            )
          : null,
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
            flex: size.width > 700 && kIsWeb ? 3 : 4,
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
