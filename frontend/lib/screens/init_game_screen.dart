import 'package:flutter/material.dart';
import 'package:role_maister/pages/init_game.dart';
import 'package:role_maister/widgets/widgets.dart';

class InitGameScreen extends StatelessWidget {
  const InitGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile) {
      return Scaffold(
          appBar: const CustomAppBar(title: "History Creator"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [InitGame()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "History Creator"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              InitGame(),
              WebFooter(),
            ],
          ));
    }
  }
}
