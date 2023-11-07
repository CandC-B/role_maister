import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';

// TODO check if autenticated or not
Widget drawerHeader(BuildContext context) => Material(
    color: Colors.deepPurple,
    child: InkWell(
        onTap: () {
          if (singleton.user != null) {
            context.go("/profile");
          }
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("asset/images/small_logo.png"),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Username",
                style: TextStyle(
                  // TODO change to user email
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "User Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )));
