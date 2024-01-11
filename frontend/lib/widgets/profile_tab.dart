import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:role_maister/config/app_singleton.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'package:role_maister/config/utils.dart';
import 'package:role_maister/models/game.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 700;
    return isSmallScreen
        ? const SingleChildScrollView(
            child: Column(
            children: [
              ProfileIcon(),
              ProfileStats(),
            ],
          ))
        : const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                SingleChildScrollView(
                  child: ProfileIcon(),
                ),
                SingleChildScrollView(
                  child: ProfileStats(),
                )
              ]);
  }
}

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({Key? key}) : super(key: key);

  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  String image = singleton.player!.photoUrl ??
      "https://firebasestorage.googleapis.com/v0/b/role-maister.appspot.com/o/bot_master.png?alt=media&token=50e2cacc-58fa-41a4-b6bc-a838538dd48a";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 150,
              backgroundImage: NetworkImage(image),
            ),
            Positioned(
              bottom: 0,
              left: 250,
              child: IconButton(
                icon: Icon(Icons.edit_outlined),
                onPressed: selectImage,
              ),
            ),
          ],
        ),
        Text(
          singleton.player?.username ?? "John Doe",
          style: const TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    String photoUrl = await firebase.uploadFile(img!, singleton.player!.email!);
    bool isUserUpdated = await firebase.updateUserProfilePicture(
        singleton.player!.uid, photoUrl);
    if (isUserUpdated) {
      setState(() {
        image = singleton.player!.photoUrl!;
      });
    }
  }
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.email,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.email ?? "candcompany@gmail.com",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.games_played,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.tokens.toString() ?? "0",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.tokens_left,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.tokens.toString() ?? "0",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.experience,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          singleton.player?.experience.toString() ?? "0",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 50),
        Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.shade100,
                  spreadRadius: 10,
                  blurRadius: 20,
                )
              ]),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () => (),
            child: SizedBox(
              width: 150,
              height: 40,
              child: Center(
                  child: Text(AppLocalizations.of(context)!.change_password)),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
