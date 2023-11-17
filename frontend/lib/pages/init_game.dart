import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/models/models.dart';
import 'package:role_maister/pages/pages.dart';

class InitGamePage extends StatelessWidget {
  const InitGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AliensCharacter character = AliensCharacter.random();

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
            color: Colors.white,
            child: Row(children: [
              Expanded(
                  flex: 2,
                  child: GameForm( image_width: (size.width * 0.8 * 2 / 3) / 3, preset: false, mobile: false,), 
                ),
              Expanded(flex: 1, child: SelectCharacterPageMobile()),
            ]),
          ),
        ),
      );
  }
}
