import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class SelectModeMobilePage extends StatelessWidget {
  const SelectModeMobilePage({Key? key});

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
                context.go("/select_character");
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/aliens.jpg',
                routeName: '/form_singleplayer',
                imageText: "ALIENS",
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
                // context.go("/select_character");
              },
              child: ImageColorFilter(
                imagePath: 'assets/images/dungeons_and_dragons.jpg',
                routeName: '/form_singleplayer',
                imageText: "DUNGEONS AND DRAGONS",
                isAvailable: false,
                height: size.height * 0.9 / 3,
                width: size.width,
                isLink: false,
                preset: true,
                isHovering: true,
              ),
            ),
          ),
          Expanded(
            child: ImageColorFilter(
              imagePath: 'assets/images/cthulhu.jpg',
              routeName: '/form_singleplayer',
              imageText: "THE CALL OF CTHULHU",
              isAvailable: false,
              height: size.height * 0.9 / 3,
              width: size.width,
              isLink: false,
              preset: true,
              isHovering: true,
            ),
          ),
        ],
      ),
    );
  }
}
