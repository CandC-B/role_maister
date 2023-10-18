import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget drawerItems (BuildContext context) => Wrap(
  children: [
    ListTile(
      leading: const Icon(Icons.home_outlined, color: Colors.deepPurple,),
      title: const Text("Home", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () => context.go('/'),
    ),
    ListTile(
      leading: const Icon(Icons.rule_outlined, color: Colors.deepPurple,),
      title: const Text("Rules", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () => context.go('/rules'),
    ),
    ListTile(
      leading: const Icon(Icons.help_outline, color: Colors.deepPurple,),
      title: const Text("Pricing", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () => context.go('/pricing'),
    ),
    const Divider(color: Colors.black54,),
    ListTile(
      leading: const Icon(Icons.info_outline, color: Colors.deepPurple,),
      title: const Text("About Us", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () => context.go('/aboutUs'),
    ),
    ListTile(
      leading: const Icon(Icons.info_outline, color: Colors.deepPurple,),
      title: const Text("Contact Us", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple, 
          ),),
      onTap: () => context.go('/contactUs'),
    ),
    
  ],
);