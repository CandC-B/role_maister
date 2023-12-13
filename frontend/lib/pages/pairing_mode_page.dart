import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PairingModePage extends StatefulWidget {
  const PairingModePage({super.key});

  @override
  State<PairingModePage> createState() => _PairingModePageState();
}

class _PairingModePageState extends State<PairingModePage> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dnd.png'),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: size.height * 0.9,
          width: size.width * 0.8,
          color: Colors.black87,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
              onTap: () {
                singleton.multiplayer = false;
                singleton.pairingMode = true;
                context.go("/form_singleplayer");
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/create_game_pairing_mode.jpg',
                routeName: '/form_singleplayer',
                imageText: AppLocalizations.of(context)!.pairing_mode_create,
                isAvailable: true,
                height: size.height * 0.9,
                width: size.width * 0.8 / 2,
                isLink: true,
                preset: false,
                isHovering: false,
              ),
            ),
            InkWell(
              onTap: () {
                singleton.multiplayer = false;
                singleton.pairingMode = true;
                context.go("/form_multiplayer");
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/join_game_pairing_mode.jpg',
                routeName: 'FantasyHome',
                imageText: AppLocalizations.of(context)!.pairing_mode_join,
                isAvailable: true,
                height: size.height * 0.9,
                width: size.width * 0.8 / 2,
                isLink: false,
                preset: false,
                isHovering: false,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
