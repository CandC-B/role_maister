import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile || !kIsWeb) {
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
