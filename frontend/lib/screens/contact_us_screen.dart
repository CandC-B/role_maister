import 'package:flutter/material.dart';
import 'package:role_maister/pages/contact_us_page.dart';
import 'package:role_maister/widgets/widgets.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Contact Us"),
      drawer: customDrawer(context),
      body: ListView(
        children: const [
          ContactUsPage(),
          WebFooter(),
        ],
      )
    );
  }
}