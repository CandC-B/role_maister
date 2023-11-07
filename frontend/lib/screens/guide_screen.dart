import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile) {
      return Scaffold(
          appBar: const CustomAppBar(title: "Guide"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [GuidePage()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "Guide"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              GuidePage(),
              WebFooter(),
            ],
          ));
    }
  }
}
