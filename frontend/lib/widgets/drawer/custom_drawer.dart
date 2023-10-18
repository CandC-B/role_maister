import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';

Widget customDrawer (BuildContext context) {
  return Drawer(
        backgroundColor: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: 
            [
              drawerHeader(context),
              drawerItems(context),
            ],
          ),
        ),
      );
} 