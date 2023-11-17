import 'package:flutter/material.dart';
import 'package:role_maister/pages/contact_us_page.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile || !kIsWeb) {
      return Scaffold(
          appBar: const CustomAppBar(title: "Contact Us"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [ContactUsPage()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "Contact Us"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              ContactUsPage(),
              WebFooter(),
            ],
          ));
    }
  }
}
