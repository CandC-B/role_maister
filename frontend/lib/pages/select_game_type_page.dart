import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';

class SelectGameTypePage extends StatelessWidget {
  const SelectGameTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Container(
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageColorFilter(
                    imagePath: 'assets/images/singleplayer.PNG',
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
                    imagePath: 'assets/images/pairingmode.PNG',
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
