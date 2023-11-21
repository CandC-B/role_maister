import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectGameTypePage extends StatefulWidget {
  const SelectGameTypePage({super.key});

  @override
  State<SelectGameTypePage> createState() => _SelectGameTypePageState();
}

class _SelectGameTypePageState extends State<SelectGameTypePage> {
  
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
                context.go("/form_singleplayer");
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/singleplayer.PNG',
                routeName: '/form_singleplayer',
                imageText: AppLocalizations.of(context)!.single_player,
                isAvailable: true,
                height: size.height * 0.9,
                width: size.width * 0.8 / 3,
                isLink: true,
                preset: false,
                isHovering: false,
              ),
            ),
            ImageColorFilter(
              imagePath: 'assets/images/multiplayer.png',
              routeName: 'FantasyHome',
              imageText: AppLocalizations.of(context)!.multi_player,
              isAvailable: false,
              height: size.height * 0.9,
              width: size.width * 0.8 / 3,
              isLink: false,
              preset: false,
              isHovering: false,
            ),
            ImageColorFilter(
                imagePath: 'assets/images/pairingmode.PNG',
                routeName: 'FantasyHome',
                imageText: AppLocalizations.of(context)!.pairing_mode,
                isAvailable: false,
                height: size.height * 0.9,
                width: size.width * 0.8 / 3,
                isLink: false,
                preset: false,
                isHovering: false,
              ),
          ]),
        ),
      ),
    );
  }
}
