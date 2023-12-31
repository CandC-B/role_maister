import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';

class SelectCharacterScreen extends StatelessWidget {
  const SelectCharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile) {
      return Scaffold(
          appBar: const CustomAppBar(title: "Select Character"),
          drawer: customDrawer(context),
          body: ListView(
            children: [SelectCharacterPageMobile()],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "Select Character"),
          drawer: customDrawer(context),
          body: ListView(
            children: [
              SelectCharacterPageMobile(),
              WebFooter(),
            ],
          ));
    }
  }
}
