import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';

// TODO check if autenticated or not
Widget drawerHeader(BuildContext context) {
    String text = "Sign In";
    if(singleton.user != null) {
      text = singleton.player!.username;
    }
    bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Material(
        color: Colors.deepPurple,
        child: InkWell(
            onTap: () {
              if (singleton.user != null) {
                isMobile ? context.push("/profile"):
                  context.go("/profile");
                }else {
                isMobile ? context.push("/sign_in"):
                  context.go("/sign_in");
                }
            },
            child: Container(
              padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top,
                bottom: 24,
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/images/small_logo.png"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      // TODO change to user email
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            )));
}
