import 'package:flutter/material.dart';
import 'package:role_maister/pages/about_us_page.dart';
import 'package:role_maister/widgets/widgets.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile) {
      return Scaffold(
          appBar: const CustomAppBar(title: "About Us"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [AboutUsPage()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "About Us"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              AboutUsPage(),
              WebFooter(),
            ],
          ));
    }
  }
}
