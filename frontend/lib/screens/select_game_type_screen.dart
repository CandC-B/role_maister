import 'package:flutter/material.dart';
import 'package:role_maister/pages/init_game.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/pages/select_game_type_mobile.dart';
import 'package:role_maister/pages/select_game_type_page.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SelectGameTypeScreen extends StatelessWidget {
  const SelectGameTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile) {
      return Scaffold(
          appBar: const CustomAppBar(title: "Game Select"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [SelectGameTypePageMobile()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "Game Select"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              SelectGameTypePage(),
              kIsWeb ? WebFooter() : SizedBox(),
            ],
          ));
    }
  }
}
