import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget drawerItems(BuildContext context) => Wrap(
      children: [
        ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            title: Text(
              AppLocalizations.of(context)!.home,
              style: const TextStyle(
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
            title: Text(
              AppLocalizations.of(context)!.rules,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              context.pop();
              context.go('/rules');
            }),
        ListTile(
            leading: const Icon(
              Icons.book_outlined,
              color: Colors.white,
            ),
            title: Text(
              AppLocalizations.of(context)!.guide,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              context.pop();
              context.go('/guide');
            }),
        ListTile(
            leading: const Icon(
              Icons.payment_outlined,
              color: Colors.white,
            ),
            title: Text(
              AppLocalizations.of(context)!.pricing,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              context.pop();
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
            title: Text(
              AppLocalizations.of(context)!.about_us,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              context.pop();
              context.go('/about_us');
            }),
        ListTile(
            leading: const Icon(
              Icons.mail_outline,
              color: Colors.white,
            ),
            title: Text(
              AppLocalizations.of(context)!.contact_us,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              context.pop();
              context.go('/contact_us');
            }),
        ListTile(
            leading: const Icon(
              Icons.history_edu_outlined,
              color: Colors.white,
            ),
            title: Text(
              AppLocalizations.of(context)!.terms_and_conditions,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              context.pop();
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
              title: Text(
                AppLocalizations.of(context)!.sign_out,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                firebase.signOut(context);
              }),
      ],
    );
