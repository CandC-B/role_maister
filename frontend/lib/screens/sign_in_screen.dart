import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile) {
      return Scaffold(
          appBar: const CustomAppBar(title: "Sign In"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [SignInPage()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "Sign In"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              SignInPage(),
              WebFooter(),
            ],
          ));
    }
  }
}
