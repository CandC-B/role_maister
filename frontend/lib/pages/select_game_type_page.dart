import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'dart:math';

class SelectGameType extends StatelessWidget {
  const SelectGameType({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.black87,
        alignment: Alignment.bottomCenter,
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
                    routeName: 'FantasyHome',
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
      ),
    );
  }
}
