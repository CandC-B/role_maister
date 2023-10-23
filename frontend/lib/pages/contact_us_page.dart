import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSingleton singleton = AppSingleton();
    String text = "";
    singleton.user != null ? text = "User Is Not Null" : text = "User Is Null";
    return Center(
          child: Text(text),
        );
  }
}