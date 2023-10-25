import 'package:flutter/material.dart';

// TODO check if autenticated or not
Widget drawerHeader (BuildContext context) => Material(
  color: Colors.deepPurple,
  child: InkWell(
    onTap: () {},
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
            backgroundImage: AssetImage("images/small_logo.png"),
          ),
          SizedBox(height: 12,),
          Text("Username", style: TextStyle( // TODO change to user email
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
          SizedBox(height: 12,),
          Text("User Email", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
        ],
      ),
    )
    )
  );