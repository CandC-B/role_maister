import 'package:flutter/material.dart';

Widget drawerItems (BuildContext context) => Wrap(
  children: [
    ListTile(
      leading: const Icon(Icons.home_outlined, color: Colors.deepPurple,),
      title: const Text("Home", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () {} /*=> 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())*/,
    ),
    ListTile(
      leading: const Icon(Icons.rule_outlined, color: Colors.deepPurple,),
      title: const Text("Rules", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () {}/*=> 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RulesPage())*/,
    ),
    const Divider(color: Colors.black54,),
    ListTile(
      leading: const Icon(Icons.info_outline, color: Colors.deepPurple,),
      title: const Text("About Us", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () {}/*=> 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RulesPage())*/,
    ),
    ListTile(
      leading: const Icon(Icons.help_outline, color: Colors.deepPurple,),
      title: const Text("Help", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () {}/*=> 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RulesPage())*/,
    ),
  ],
);