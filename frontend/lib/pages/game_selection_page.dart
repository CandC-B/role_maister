import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/models/game.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _gameIdController = TextEditingController();

    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background4.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: kIsWeb? 
          EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05):
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.black.withOpacity(0.5),
          ),
          child: Padding(
            padding: kIsWeb? 
            EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.05):
            EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.game_selection,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: kIsWeb? 48: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50.0),
                Padding(
                  padding: kIsWeb? EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.05): EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _gameIdController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.game_code,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                Container(
                  width: kIsWeb? size.width * 0.25 : size.width * 0.5, 
                  height: kIsWeb? size.height * 0.05 : size.height * 0.05, 
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.deepPurple,
                      textStyle: const TextStyle(
                          fontSize: kIsWeb? 30:20, 
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (_gameIdController.text.isNotEmpty) {
                        singleton.currentGame = await firebase.getGameUidByShortUid(_gameIdController.text);
                        singleton.currentGameShortUid = _gameIdController.text;
                        singleton.joinPairingMode = true;
                        context.go("/select_character");
                      }
                    },
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(AppLocalizations.of(context)!.pairing_mode_join),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}