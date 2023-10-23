import 'package:flutter/material.dart';
import 'page_widgets/image_color_filter.dart';

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
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageColorFilter(
                    imagePath: 'assets/images/singleplayer.png',
                    routeName: 'FantasyHome',
                    imageText: "SINGLE PLAYER",
                    isAvailable: true,
                    angle: -0.985,
                  ),
                  ImageColorFilter(
                    imagePath: 'assets/images/multiplayer.png',
                    routeName: 'FantasyHome',
                    imageText: "MULTIPLAYER",
                    isAvailable: false,
                    angle: -0.985,
                  ),
                  ImageColorFilter(
                    imagePath: 'assets/images/pairingmode.png',
                    routeName: 'FantasyHome',
                    imageText: "PAIRING MODE",
                    isAvailable: false,
                    angle: -0.985,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
