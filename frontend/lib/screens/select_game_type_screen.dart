import 'package:flutter/material.dart';
import 'package:role_maister/pages/init_game.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/pages/select_game_type_page.dart';
import 'package:role_maister/widgets/widgets.dart';

class SelectGameTypeScreen extends StatelessWidget {
  const SelectGameTypeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "none"),
      drawer: customDrawer(context),
      body: ListView(
        children: const [
          SelectGameType(),
          WebFooter(),
        ],
      )
    );
  }
}