import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget drawerItems(BuildContext context) {
  bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
  return Wrap(
    children: [
      ListTile(
          leading: const Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          title: const Text(
            "Home",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.pop();
            context.go('/');
            context.push('/');
          }),
      ListTile(
          leading: const Icon(
            Icons.rule_outlined,
            color: Colors.white,
          ),
          title: const Text(
            "Rules",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.pop();
            isMobile ? context.push("/rules") :
            context.go('/rules');
          }),
      ListTile(
          leading: const Icon(
            Icons.book_outlined,
            color: Colors.white,
          ),
          title: const Text(
            "Guide",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.pop();
            isMobile ? context.push("/guide") :
            context.go('/guide');
          }),
      ListTile(
          leading: const Icon(
            Icons.payment_outlined,
            color: Colors.white,
          ),
          title: const Text(
            "Pricing",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.pop();
            isMobile ? context.push("/pricing") :
            context.go('/pricing');
          }),
      const Divider(
        color: Colors.white,
      ),
      ListTile(
          leading: const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          title: const Text(
            "About Us",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.pop();
            isMobile ? context.push("/about_us") :
            context.go('/about_us');
          }),
      ListTile(
          leading: const Icon(
            Icons.mail_outline,
            color: Colors.white,
          ),
          title: const Text(
            "Contact Us",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.pop();
            isMobile ? context.push("/contact_us") :
            context.go('/contact_us');
          }),
      ListTile(
          leading: const Icon(
            Icons.history_edu_outlined,
            color: Colors.white,
          ),
          title: const Text(
            "Terms & Conditions",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.pop();
            isMobile ? context.push("/terms_conditions") :
            context.go('/terms_conditions');
          }),
      if (singleton.user != null)
        const Divider(
          color: Colors.white,
        ),
      if (singleton.user != null)
        ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            title: const Text(
              "Log Out",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              firebase.signOut(context);
            }),
    ],
  );
}
