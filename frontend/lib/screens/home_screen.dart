import 'package:flutter/material.dart';
import 'package:role_maister/pages/init_game.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Home"),
      drawer: customDrawer(context),
      body: ListView(
        children: const [
          HomePage(),
          WebFooter(),
        ],
      )
    );
  }
}