import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';

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
              child: ImageColorFilter(
                imagePath: 'assets/images/singleplayer_mobile.PNG',
                routeName: '/form_singleplayer',
                imageText: "SINGLE PLAYER",
                isAvailable: true,
                height: size.height / 3,
                width: size.width,
                isLink: true,
                preset: true,
              ),
            ),
            Expanded(
              child: ImageColorFilter(
                imagePath: 'assets/images/multiplayer.png',
                routeName: '/form_singleplayer',
                imageText: "SINGLE PLAYER",
                isAvailable: false,
                height: size.height / 3,
                width: size.width,
                isLink: false,
                preset: true,
              ),
            ),
            Expanded(
              child: ImageColorFilter(
                imagePath: 'assets/images/pairingmode.PNG',
                routeName: '/form_singleplayer',
                imageText: "SINGLE PLAYER",
                isAvailable: false,
                height: size.height / 3,
                width: size.width,
                isLink: false,
                preset: true,
              ),
            ),
          ],
        ),
    );
  }
}
