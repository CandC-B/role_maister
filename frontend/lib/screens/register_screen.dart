import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Register"),
      drawer: customDrawer(context),
      body: ListView(
        children: const [
          RegisterPage(),
          WebFooter(),
        ],
      )
    );
  }
}