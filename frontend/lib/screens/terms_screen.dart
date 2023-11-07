import 'package:flutter/material.dart';
import 'package:role_maister/pages/terms_page.dart';
import 'package:role_maister/widgets/widgets.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile) {
      return Scaffold(
          appBar: const CustomAppBar(title: "None"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [TermsPage()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "None"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              TermsPage(),
              WebFooter(),
            ],
          ));
    }
  }
}
