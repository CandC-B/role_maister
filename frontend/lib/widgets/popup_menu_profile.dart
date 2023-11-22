import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ProfileItems { profile, logout }
FirebaseService firebase = FirebaseService();

class PopupMenuProfile extends StatefulWidget {
  const PopupMenuProfile({super.key});

  @override
  State<PopupMenuProfile> createState() => _PopupMenuProfileState();
}

class _PopupMenuProfileState extends State<PopupMenuProfile> {
  ProfileItems? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ProfileItems>(
          color: Colors.deepPurple,
          icon: const Icon(Icons.account_circle_outlined, color: Colors.white,),
          // Callback that sets the selected popup menu item.
          onSelected: (ProfileItems item) {
            setState(() {
              if (item == ProfileItems.profile) {
                context.go("/profile");
              } else if (item == ProfileItems.logout) {
                firebase.signOut(context);
              }
            });
          },
          offset: const Offset(0, 50),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<ProfileItems>>[
             PopupMenuItem<ProfileItems>(
              value: ProfileItems.profile,
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Icon(Icons.account_circle_outlined, color: Colors.white,),
                      Text(AppLocalizations.of(context)!.profile,
                      style: const TextStyle(color: Colors.white),)
                    ],
                  ),
            ),
            PopupMenuItem<ProfileItems>(
              value: ProfileItems.logout,
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Icon(Icons.logout_outlined, color: Colors.white,),
                      Text(AppLocalizations.of(context)!.sign_out,
                      style: const TextStyle(color: Colors.white),)
                    ],
                  ),
            ),
          ],
        );
  }
}




