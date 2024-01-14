import 'package:flutter/material.dart';
import 'package:role_maister/pages/pages.dart';
import 'package:role_maister/pages/waiting_room_page.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({super.key});
  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    if (mobile || !kIsWeb) {
      return Scaffold(
          appBar: const CustomAppBar(title: "Home"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              WaitingRoomPage(),
            ],
          ));
    } else {
      return Scaffold(
          appBar: const CustomAppBar(title: "Home"),
          drawer: customDrawer(context),
          body: ListView(
            children: const [
              WaitingRoomPage(),
              WebFooter(),
            ],
          ));
    }
  }
}