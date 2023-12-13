import 'package:flutter/material.dart';
import 'package:role_maister/config/app_singleton.dart';
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

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 150,
          backgroundImage: AssetImage('assets/images/bot_master.png'),
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
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Email: ',
          style: TextStyle(
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
        const Text(
          'Games played: ',
          style: TextStyle(
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
        const Text(
          'Tokens left: ',
          style: TextStyle(
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
        const Text(
          'Experience: ',
          style: TextStyle(
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
            child: const SizedBox(
              width: 150,
              height: 40,
              child: Center(child: Text('Change Password')),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}