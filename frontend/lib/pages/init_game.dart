import 'package:flutter/material.dart';
import 'package:role_maister/widgets/widgets.dart';
import 'package:role_maister/models/models.dart';

class InitGame extends StatelessWidget {
  const InitGame({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.black87,
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: size.height * 0.9,
            width: size.width * 0.8,
            color: Colors.white,
            child: Row(children: [
              Expanded(
                  flex: 2,
                  child: GameForm(),
                ),
              Expanded(flex: 1, child: StatsTab(userStats: UserStatistics.random(),)),
            ]),
          ),
        ),
      ),
    );
  }
}
