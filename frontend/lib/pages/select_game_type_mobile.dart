import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectGameTypePageMobile extends StatelessWidget {
  const SelectGameTypePageMobile({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.9,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                singleton.multiplayer = false;
                context.go("/form_singleplayer");
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/singleplayer_mobile.PNG',
                routeName: '/form_singleplayer',
                imageText: AppLocalizations.of(context)!.single_player,
                isAvailable: true,
                height: size.height * 0.9 / 3,
                width: size.width,
                isLink: true,
                preset: true,
                isHovering: true,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                singleton.multiplayer = true;
                context.go("/form_multiplayer");
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/multiplayer.png',
                routeName: '/form_singleplayer',
                imageText: AppLocalizations.of(context)!.multi_player,
                isAvailable: true,
                height: size.height * 0.9 / 3,
                width: size.width,
                isLink: false,
                preset: true,
                isHovering: true,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                singleton.multiplayer = true;
                print("pairing mode");
                context.go("/form_pairing_mode");
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/pairingmode.PNG',
                routeName: '/form_singleplayer',
                imageText: AppLocalizations.of(context)!.pairing_mode,
                isAvailable: true,
                height: size.height * 0.9 / 3,
                width: size.width,
                isLink: false,
                preset: true,
                isHovering: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
