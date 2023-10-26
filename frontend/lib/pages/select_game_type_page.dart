import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';

class SelectGameType extends StatelessWidget {
  const SelectGameType({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Container(
        width: size.width,
        height: size.height,
        color: Colors.black87,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: size.height * 0.9,
            width: size.width * 0.8,
            color: Colors.black87,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageColorFilter(
                    imagePath: 'assets/images/singleplayer.png',
                    routeName: '/form_singleplayer',
                    imageText: "SINGLE PLAYER",
                    isAvailable: true,
                    height: size.height * 0.9,
                    width: size.width * 0.8 / 3,
                    isLink: true,
                    preset: false,
                  ),
                  ImageColorFilter(
                    imagePath: 'assets/images/multiplayer.png',
                    routeName: 'FantasyHome',
                    imageText: "MULTIPLAYER",
                    isAvailable: false,
                    height: size.height * 0.9,
                    width: size.width * 0.8 / 3,
                    isLink: false,
                    preset: false,
                  ),
                  ImageColorFilter(
                    imagePath: 'assets/images/pairingmode.png',
                    routeName: 'FantasyHome',
                    imageText: "PAIRING MODE",
                    isAvailable: false,
                    height: size.height * 0.9,
                    width: size.width * 0.8 / 3,
                    isLink: false,
                    preset: false,
                  ),
                ]),
          ),
        ),
      );
  }
}
