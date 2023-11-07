import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile) {
      return Scaffold(
          appBar: const CustomAppBar(title: "Profile"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [ProfilePage()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "Profile"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              ProfilePage(),
              WebFooter(),
            ],
          ));
    }
  }
}
