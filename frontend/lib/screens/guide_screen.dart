import 'package:flutter/material.dart';
import 'package:role_maister/pages/guide_page.dart';
import 'package:role_maister/widgets/widgets.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Guide"),
      drawer: customDrawer(context),
      body: ListView(
        children: const [
          GuidePage(),
          WebFooter(),
        ],
      )
    );
  }
}