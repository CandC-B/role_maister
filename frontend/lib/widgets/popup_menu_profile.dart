import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum ProfileItems { profile, logout }

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
                // TODO Log out
              }
            });
          },
          offset: const Offset(0, 50),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<ProfileItems>>[
            const PopupMenuItem<ProfileItems>(
              value: ProfileItems.profile,
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Icon(Icons.account_circle_outlined, color: Colors.white,),
                      Text('Profile', style: TextStyle(color: Colors.white),)
                    ],
                  ),
            ),
            const PopupMenuItem<ProfileItems>(
              value: ProfileItems.logout,
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Icon(Icons.logout_outlined, color: Colors.white,),
                      Text('Log Out', style: TextStyle(color: Colors.white),)
                    ],
                  ),
            ),
          ],
        );
  }
}




