import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget drawerItems (BuildContext context) => Wrap(
  children: [
    ListTile(
      leading: const Icon(Icons.home_outlined, color: Colors.white,),
      title: const Text("Home", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),),
      onTap: () {
        context.pop();
        context.go('/');
      }
    ),
    ListTile(
      leading: const Icon(Icons.rule_outlined, color: Colors.white,),
      title: const Text("Rules", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),),
      onTap: () {
        context.pop();
        context.go('/rules');
      }
    ),
    ListTile(
      leading: const Icon(Icons.payment_outlined, color: Colors.white,),
      title: const Text("Pricing", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),),
      onTap: () {
        context.pop();
        context.go('/pricing');
      }
    ),
    const Divider(color: Colors.white,),
    ListTile(
      leading: const Icon(Icons.info_outline, color: Colors.white,),
      title: const Text("About Us", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),),
      onTap: () {
        context.pop();
        context.go('/about_us');
      }
    ),
    ListTile(
      leading: const Icon(Icons.mail_outline, color: Colors.white,),
      title: const Text("Contact Us", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),),
      onTap: () {
        context.pop();
        context.go('/contact_us');
      }
    ),
    
  ],
);