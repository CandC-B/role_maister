import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Rules"),
      drawer: customDrawer(context),
      body: ListView(
        children: const [
          RulesPage(),
          WebFooter(),
        ],
      )
    );
  }
}