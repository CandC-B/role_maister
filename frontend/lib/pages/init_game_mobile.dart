import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/models/models.dart';

class InitGamePageMobile extends StatelessWidget {
  const InitGamePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserStatistics character = UserStatistics.random();

    return Container(
        width: size.width,
        height: size.height * 0.9,
        child: GameForm(character: character, image_width: size.width / 3, preset: false, mobile: true,)
      );
  }
}
